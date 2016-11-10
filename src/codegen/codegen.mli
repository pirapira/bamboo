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

val codegen_runtime_bytecode :
  Syntax.typ Syntax.contract Assoc.contract_id_assoc ->
  (CodegenEnv.codegen_env (* containing the program *)
  (* * LocationEnv.location_env *))

type constructor_compiled =
  { constructor_codegen_env : CodegenEnv.codegen_env
  ; constructor_interface : Contract.contract_interface
  ; constructor_contract : Syntax.typ Syntax.contract
  }

val compile_constructor :
  (Syntax.typ Syntax.contract Assoc.contract_id_assoc *
   Assoc.contract_id) -> constructor_compiled

type runtime_compiled =
  { runtime_codegen_env : CodegenEnv.codegen_env
  }

val compile_runtime :
  Syntax.typ Syntax.contract Assoc.contract_id_assoc -> runtime_compiled

(* TODO: remove from the interface.
 * Use instead compile_constructor *)
val codegen_constructor_bytecode :
  (Syntax.typ Syntax.contract Assoc.contract_id_assoc *
   Assoc.contract_id) ->
  ((* LocationEnv.location_env * *)
     CodegenEnv.codegen_env (* containing the program *))

val compile_constructors :
  Syntax.typ Syntax.contract Assoc.contract_id_assoc ->
  constructor_compiled Assoc.contract_id_assoc

val layout_info_from_constructor_compiled : constructor_compiled -> LayoutInfo.contract_layout_info

val layout_info_from_runtime_compiled : runtime_compiled -> LayoutInfo.runtime_layout_info

(** The combination of the constructor_bytecode and the runtime_bytecode **)
val codegen_bytecode :
  Syntax.typ Syntax.contract ->
  PseudoImm.pseudo_imm Evm.program

val size_of_typ : Syntax.typ -> int

val move_info_around :
  (* assumption *) CodegenEnv.codegen_env ->
  (* goal *)       LocationEnv.location_env ->
                   CodegenEnv.codegen_env
