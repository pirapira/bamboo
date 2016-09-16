open PseudoImm
open CodegenEnv
open Evm

let rec codegen_exp
      (ce : CodegenEnv.codegenEnv)
      ((e,t) : Syntax.typ Syntax.exp) :
      CodegenEnv.codegenEnv =
  let ret =
  Syntax.
  (match e with
  | FalseExp ->
     let ce = CodegenEnv.append_instruction
                ce (Evm.PUSH1 (Concrete Big_int.zero_big_int)) in
     ce
  | TrueExp ->
     let ce = append_instruction ce (PUSH1 (Concrete Big_int.unit_big_int)) in
     ce
  | NotExp sub ->
     let ce = codegen_exp ce sub in
     let ce = append_instruction ce NOT in
     ce
  | NowExp ->
     append_instruction ce TIMESTAMP
  | NeqExp (l, r)->
     let ce = codegen_exp ce r in
     let ce = codegen_exp ce l in (* l later because it should come at the top *)
     let ce = append_instruction ce NEQ in
     ce
  | LtExp (l, r) ->
     let ce = codegen_exp ce r in
     let ce = codegen_exp ce l in
     let ce = append_instruction ce LT in
     ce
  | SendExp s ->
     (* argument order, gas, to, value, in offset in size out offset, out size *)
     failwith "exp code gen for sendexp"
  | CallExp _ ->
     (* TODO maybe the name callexp should be changed, the only instance is the newly created contract, for which the new_exp should be responsible *)
     failwith "exp code gen for callexp"
  ) in
  let () = assert (stack_size ret = stack_size ce + 1) in
  ret

let codegen_sentence
  (orig : CodegenEnv.codegenEnv)
  (s : Syntax.typ Syntax.sentence)
  (* is this enough? also add sentence Id's around?
   * I think this is enough.
   *)
  : CodegenEnv.codegenEnv = failwith "codegen_sentence"

let move_info_around
  (assumption : CodegenEnv.codegenEnv)
  (goal : LocationEnv.location_env) :
      CodegenEnv.codegenEnv = failwith "move_info_around"
