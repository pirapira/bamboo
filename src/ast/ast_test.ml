open Lexer
open Lexing
open Printf

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
  let contracts : unit Syntax.toplevel list = parse_with_error lexbuf in
  let contracts = Assoc.list_to_contract_id_assoc contracts in
  let _ = Type.assign_types contracts in
  Printf.printf "Finished typing.\n"
