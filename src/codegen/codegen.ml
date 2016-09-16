open PseudoImm

let codegen_exp
      (ce : CodegenEnv.codegenEnv)
      ((e,t) : Syntax.typ Syntax.exp) :
      CodegenEnv.codegenEnv =
  Syntax.
  (match e with
  | FalseExp ->
     let ce = CodegenEnv.append_instruction
                ce (Evm.PUSH1 (Concrete Big_int.zero_big_int)) in
     ce
  | _ -> failwith ("codegen_exp "^Syntax.string_of_exp_inner e^": "^Syntax.string_of_typ t))

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
