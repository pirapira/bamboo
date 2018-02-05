type alignment = LeftAligned | RightAligned

(** [codegen_exp original_env exp]
 * is a new codegenEnv where a stack element is pushed, whose
 * value is the evaluation of exp *)
val codegen_exp :
  LocationEnv.t ->
  CodegenEnv.t ->
  alignment ->
  Syntax.typ Syntax.exp ->
  CodegenEnv.t

val codegen_sentence :
  CodegenEnv.t ->
  Syntax.typ Syntax.sentence -> (* is this enough? also add sentence Id's around?
                   * I think this is enough.
                   *)
  CodegenEnv.t

type constructor_compiled =
  { constructor_codegen_env : CodegenEnv.t
  ; constructor_interface : Contract.contract_interface
  ; constructor_contract : Syntax.typ Syntax.contract
  }

val compile_constructor :
  (Syntax.typ Syntax.contract Assoc.contract_id_assoc *
   Assoc.contract_id) -> constructor_compiled

type runtime_compiled =
  { runtime_codegen_env : CodegenEnv.t
  ; runtime_contract_offsets : int Assoc.contract_id_assoc
  }

val compile_runtime :
  LayoutInfo.layout_info ->
  Syntax.typ Syntax.contract Assoc.contract_id_assoc -> runtime_compiled

(* TODO: remove from the interface.
 * Use instead compile_constructor *)
val codegen_constructor_bytecode :
  (Syntax.typ Syntax.contract Assoc.contract_id_assoc *
   Assoc.contract_id) ->
  ((* LocationEnv.location_env * *)
     CodegenEnv.t (* containing the program *))

val compile_constructors :
  Syntax.typ Syntax.contract Assoc.contract_id_assoc ->
  constructor_compiled Assoc.contract_id_assoc

val layout_info_from_constructor_compiled : constructor_compiled -> LayoutInfo.contract_layout_info

val layout_info_from_runtime_compiled : runtime_compiled -> constructor_compiled Assoc.contract_id_assoc -> LayoutInfo.runtime_layout_info

(** The combination of the constructor_bytecode and the runtime_bytecode **)
val codegen_bytecode :
  Syntax.typ Syntax.contract ->
  PseudoImm.pseudo_imm Evm.program

val move_info_around :
  (* assumption *) CodegenEnv.t ->
  (* goal *)       LocationEnv.t ->
                   CodegenEnv.t


val compose_bytecode : constructor_compiled Assoc.contract_id_assoc ->
                       runtime_compiled -> Assoc.contract_id ->
                       WrapBn.t Evm.program

val compose_runtime_bytecode :
  constructor_compiled Assoc.contract_id_assoc ->
  runtime_compiled -> WrapBn.t Evm.program
