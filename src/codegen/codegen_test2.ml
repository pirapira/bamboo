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

let _ =
  let lexbuf = Lexing.from_channel stdin in
  let contracts : unit Syntax.contract list = parse_with_error lexbuf in
  let contracts = Assoc.list_to_contract_id_assoc contracts in
  let contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc = Type.assign_types contracts in
  let () = match contracts with
  | [] -> ()
  | _ ->
     let (env : CodegenEnv.codegen_env)
       = codegen_constructor_bytecode (contracts, fst (List.hd contracts)) in
     let constructor_program = CodegenEnv.ce_program env in
     let () = Printf.printf "=====constructor for first contract=====\n" in
     let () = Evm.print_pseudo_program constructor_program in
     let () = Printf.printf "=====runtime code (common to all contracts)=====\n" in
     let env = codegen_runtime_bytecode contracts in
     let constructors : constructor_compiled Assoc.contract_id_assoc = compile_constructors contracts in
     let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
       List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
     let _ = LayoutInfo.construct_layout_info contracts_layout_info in
     let runtime_program = CodegenEnv.ce_program env in
     let () = Evm.print_pseudo_program runtime_program in
     let () = Printf.printf "=====layout_info (common to all contracts)=====\n" in
     let runtime_layout = failwith "runtime_layout" in
     let layout = LayoutInfo.construct_layout_info contracts_layout_info runtime_layout in
     let () = LayoutInfo.print_layout_info layout in
     () in
  Printf.printf "Finished codgen_test2.\n"
