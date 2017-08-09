open Syntax
open Codegen

(* The following two functions comes from
 * https://github.com/realworldocaml/examples/tree/master/code/parsing-test
 * which is under UNLICENSE
 *)
let _ =
  let dummy_cid_lookup (_ : string) = 3 in
  let dummy_env = CodegenEnv.empty_env dummy_cid_lookup [] in
  let dummy_l = LocationEnv.empty_env in
  let _ = codegen_exp dummy_l dummy_env RightAligned (FalseExp, BoolType) in
  let _ = codegen_exp dummy_l dummy_env RightAligned (TrueExp, BoolType) in
  let _ = codegen_exp dummy_l dummy_env RightAligned (NotExp (TrueExp, BoolType), BoolType) in
  let _ = codegen_exp dummy_l dummy_env RightAligned (NowExp, Uint256Type) in
  Printf.printf "Finished codgen_test.\n"
