
(** [codegen_exp original_env exp]
 * is a new codegenEnv where a stack element is pushed, whose
 * value is the evaluation of exp *)
val codegen_exp :
  LocationEnv.location_env ->
  CodegenEnv.codegen_env ->
  Syntax.typ Syntax.exp ->
  CodegenEnv.codegen_env

val codegen_sentence :
  CodegenEnv.codegen_env ->
  Syntax.typ Syntax.sentence -> (* is this enough? also add sentence Id's around?
                   * I think this is enough.
                   *)
  CodegenEnv.codegen_env

val size_of_typ : Syntax.typ -> int

val move_info_around :
  (* assumption *) CodegenEnv.codegen_env ->
  (* goal *)       LocationEnv.location_env ->
                   CodegenEnv.codegen_env
