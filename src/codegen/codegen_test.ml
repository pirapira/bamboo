open Syntax
open Codegen

(* The following two functions comes from
 * https://github.com/realworldocaml/examples/tree/master/code/parsing-test
 * which is under UNLICENSE
 *)
let _ =
  let dummy_cid_lookup (_ : string) = 3 in
  let dummy_env = CodegenEnv.empty_env dummy_cid_lookup in
  let dummy_l = LocationEnv.empty_location_env in
  let _ = codegen_exp dummy_l dummy_env (FalseExp, BoolType) in
  let _ = codegen_exp dummy_l dummy_env (TrueExp, BoolType) in
  let _ = codegen_exp dummy_l dummy_env (NotExp (TrueExp, BoolType), BoolType) in
  let _ = codegen_exp dummy_l dummy_env (NowExp, UintType) in
  Printf.printf "Finished codgen_test.\n"
