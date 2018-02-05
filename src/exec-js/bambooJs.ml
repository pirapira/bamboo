open Lexer
open Syntax
open Codegen

let parse_with_error lexbuf =
  try Parser.file Lexer.read lexbuf with
  | SyntaxError msg ->
    failwith msg
  | Parser.Error ->
    failwith "syntax error"
  | _ ->
    failwith "syntax error"

let compile_file input_file =
  let lexbuf = Lexing.from_string input_file in
  let toplevels : unit Syntax.toplevel list = parse_with_error lexbuf in
  let toplevels = Assoc.list_to_contract_id_assoc toplevels in
  let toplevels : Syntax.typ Syntax.toplevel Assoc.contract_id_assoc = Type.assign_types toplevels in
  let contracts = Assoc.filter_map (fun x ->
                      match x with
                      | Contract c -> Some c
                      | _ -> None) toplevels in
  let () = match contracts with
  | [] -> ()
  | _ ->
     let constructors : constructor_compiled Assoc.contract_id_assoc = compile_constructors contracts in
     let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
       List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
     let layout = LayoutInfo.construct_layout_info contracts_layout_info in
     let runtime_compiled = compile_runtime layout contracts in
     let bytecode : WrapBn.t Evm.program =
       compose_bytecode constructors runtime_compiled (fst (List.hd contracts)) in
     let () =
       Evm.print_imm_program bytecode
     in
     () in
  ()


external resume : unit -> unit = "process.stdin.resume" [@@bs.val]
external setEncoding : string -> unit =
  "process.stdin.setEncoding" [@@bs.val]
external stdin_on_data : (_ [@bs.as "data"]) -> (string -> unit) -> unit =
  "process.stdin.on" [@@bs.val]

let () = resume ()
let () = setEncoding "utf8"
let () = stdin_on_data compile_file