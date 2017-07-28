open Lexer
open Lexing
open Printf
open Syntax
open Codegen

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let contracts : unit Syntax.toplevel list = Parse.parse_with_error lexbuf in
  let contracts = Assoc.list_to_contract_id_assoc contracts in
  let contracts : Syntax.typ Syntax.toplevel Assoc.contract_id_assoc = Type.assign_types contracts in
  let contracts = Assoc.filter_map (fun x -> match x with
                                             | Contract x -> Some x
                                             | _ -> None) contracts in
  let () = match contracts with
  | [] -> ()
  | _ ->
     let (env : CodegenEnv.t)
       = codegen_constructor_bytecode (contracts, fst (List.hd contracts)) in
     let constructor_program = CodegenEnv.ce_program env in
     let () = Printf.printf "=====constructor for first contract=====\n" in
     let () = Evm.print_pseudo_program constructor_program in
     let () = Printf.printf "=====runtime code (common to all contracts)=====\n" in
     let constructors : constructor_compiled Assoc.contract_id_assoc = compile_constructors contracts in
     let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
       List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
     let layout = LayoutInfo.construct_layout_info contracts_layout_info in
     let runtime_compiled = compile_runtime layout contracts in
     let runtime_ce = runtime_compiled.runtime_codegen_env in
     let () = Evm.print_pseudo_program (CodegenEnv.ce_program runtime_ce) in
     let () = Printf.printf "=====layout_info (common to all contracts)=====\n" in
     let layout = LayoutInfo.construct_layout_info contracts_layout_info in
     let () = LayoutInfo.print_layout_info layout in
     let () = Printf.printf "=====bytecode (with the constructor for first contract)=====\n" in
     let bytecode : Big_int.big_int Evm.program =
       compose_bytecode constructors runtime_compiled (fst (List.hd contracts)) in
     let () = Evm.print_imm_program bytecode in
     let () = Printf.printf "=====runtime bytecode=====\n" in
     let runtime_bytecode : Big_int.big_int Evm.program =
       compose_runtime_bytecode constructors runtime_compiled in
     let () = Evm.print_imm_program runtime_bytecode in
     () in
  Printf.printf "Finished codgen_test2.\n"
