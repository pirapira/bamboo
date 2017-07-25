open Lexer
open Lexing
open Printf
open Syntax
open Codegen

(* The following two functions comes from
 * https://github.com/realworldocaml/examples/tree/master/code/parsing-test
 * which is under UNLICENSE
 *)
let print_position outx lexbuf =
  let pos = lexbuf.lex_curr_p in
  fprintf outx "%s:%d:%d" pos.pos_fname
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)

let parse_with_error lexbuf =
  try Parser.file Lexer.read lexbuf with
  | SyntaxError msg ->
    fprintf stderr "%a: %s\n" print_position lexbuf msg;
    exit (-1)
  | Parser.Error ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)
  | _ ->
    fprintf stderr "%a: syntax error\n" print_position lexbuf;
    exit (-1)

let () =
  let lexbuf = Lexing.from_channel stdin in
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
     let bytecode : Big_int.big_int Evm.program =
       compose_bytecode constructors runtime_compiled (fst (List.hd contracts)) in
     let () = Evm.print_imm_program bytecode in
     () in
  ()
