open Syntax
open Codegen

(* The following two functions comes from
 * https://github.com/realworldocaml/examples/tree/master/code/parsing-test
 * which is under UNLICENSE
 *)
let _ =
  let dummy_env = CodegenEnv.empty_env in
  let _ = codegen_exp dummy_env (FalseExp, BoolType) in
  let _ = codegen_exp dummy_env (TrueExp, BoolType) in
  let _ = codegen_exp dummy_env (NotExp (TrueExp, BoolType), BoolType) in
  let _ = codegen_exp dummy_env (NowExp, UintType) in
  Printf.printf "Finished codgen_test.\n"
