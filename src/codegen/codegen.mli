
(** [codegen_exp original_env exp]
 * is a new codegenEnv where a stack element is pushed, whose
 * value is the evaluation of exp *)
val codegen_exp :
  CodegenEnv.codegenEnv ->
  Syntax.typ Syntax.exp ->
  CodegenEnv.codegenEnv

val codegen_sentence :
  CodegenEnv.codegenEnv ->
  Syntax.typ Syntax.sentence -> (* is this enough? also add sentence Id's around?
                   * I think this is enough.
                   *)
  CodegenEnv.codegenEnv

val move_info_around :
  (* assumption *) CodegenEnv.codegenEnv ->
  (* goal *)       LocationEnv.location_env ->
                   CodegenEnv.codegenEnv
