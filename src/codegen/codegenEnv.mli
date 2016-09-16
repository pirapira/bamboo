(* codegenEnv remembers the current stack size,
   initial storage assumtion, and
   accumulated instructions. *)
type codegenEnv

val empty_env : codegenEnv

val code_length : codegenEnv -> int
val stack_size : codegenEnv -> int

(* for each instruction,
 * create an interface function.
 * This allows keeping track of stack size...
 *)

val append_instruction :
  codegenEnv -> PseudoImm.pseudo_imm Evm.instruction -> codegenEnv
