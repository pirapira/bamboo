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

let abi_option = BatOptParse.StdOpt.store_true ()

let optparser : BatOptParse.OptParser.t = BatOptParse.OptParser.make ~version:"0.0.03" ~usage:"bamboo [options] < src.bbo" ~description:"By default, bamboo compiles the source from stdin and prints EVM bytecode in stdout.  Do not trust the output as the compiler still contains bugs probably." ()

let () =
  let () = BatOptParse.OptParser.add optparser ~long_names:["abi"] ~help:"print the ABI interface in JSON" abi_option in
  let files = BatOptParse.OptParser.parse_argv optparser in
  let () =
    if files <> [] then
      (Printf.eprintf "This compiler accepts input from stdin.\n";
       exit 1)
  in

  let abi : bool = (Some true = abi_option.BatOptParse.Opt.option_get ()) in

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
     let bytecode : WrapBn.t Evm.program =
       compose_bytecode constructors runtime_compiled (fst (List.hd contracts)) in
     let () =
       if abi then
         Ethereum.print_abi toplevels
       else
         Evm.print_imm_program bytecode
     in
     () in
  ()
