open Codegen

let compile_file (file : string) : string =
  BatFile.with_file_in
    file
    (fun channel ->
      let lexbuf = BatLexing.from_input channel in
      let contracts : unit Syntax.toplevel list = Parse.parse_with_error lexbuf in
      let contracts = Assoc.list_to_contract_id_assoc contracts in
      let contracts : Syntax.typ Syntax.toplevel Assoc.contract_id_assoc = Type.assign_types contracts in
      let contracts = Assoc.filter_map (fun x -> match x with Syntax.Contract c -> Some c | _ -> None) contracts in
      let constructors : constructor_compiled Assoc.contract_id_assoc = compile_constructors contracts in
      let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
        List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
      let layout = LayoutInfo.construct_layout_info contracts_layout_info in
      let runtime_compiled = compile_runtime layout contracts in
      let bytecode = compose_bytecode constructors runtime_compiled (fst (List.hd contracts)) in
      Evm.string_of_imm_program bytecode)
