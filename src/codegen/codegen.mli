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

(** [runtime_initial_location_env specifies
 * where the state variables should be found
 * when the runtie code starts.
 * The deployment bytecode must establish this.
 * Storage index 0 is used for contract dispatching.
 * The following indices are used to store the
 * state variables.
 *)
val runtime_initial_location_env :
  Syntax.typ Syntax.contract ->
  LocationEnv.location_env

val codegen_runtime_bytecode :
  Syntax.typ Syntax.contract ->
  (CodegenEnv.codegen_env (* containing the program *)
   * LocationEnv.location_env)

val codegen_constructor_bytecode :
  (Syntax.typ Syntax.contract list *
   Syntax.contract_id) ->
  ((* LocationEnv.location_env * *)
     CodegenEnv.codegen_env (* containing the program *))

(** The combination of the constructor_bytecode and the runtime_bytecode **)
val codegen_bytecode :
  Syntax.typ Syntax.contract ->
  PseudoImm.pseudo_imm Evm.program

val size_of_typ : Syntax.typ -> int

val move_info_around :
  (* assumption *) CodegenEnv.codegen_env ->
  (* goal *)       LocationEnv.location_env ->
                   CodegenEnv.codegen_env
