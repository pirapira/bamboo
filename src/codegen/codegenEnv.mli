(* codegenEnv remembers the current stack size,
   initial storage assumtion, and
   accumulated instructions. *)
type codegen_env

val empty_env : codegen_env

val ce_program : codegen_env -> PseudoImm.pseudo_imm Evm.program
val code_length : codegen_env -> int

val stack_size : codegen_env -> int
val set_stack_size : codegen_env -> int -> codegen_env

(* for each instruction,
 * create an interface function.
 * This allows keeping track of stack size...
 *)

val append_instruction :
  codegen_env -> PseudoImm.pseudo_imm Evm.instruction -> codegen_env

val cid_lookup : codegen_env -> string -> Assoc.contract_id
