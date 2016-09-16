(* codegenEnv remembers the current stack size,
   initial storage assumtion, and
   accumulated instructions. *)
type codegenEnv

val empty_env : codegenEnv

val codeLength : codegenEnv -> int

(* for each instruction,
 * create an interface function.
 * This allows keeping track of stack size...
 *)

val append_instruction :
  codegenEnv -> PseudoImm.pseudo_imm Evm.instruction -> codegenEnv
