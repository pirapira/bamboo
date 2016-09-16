(* codegenEnv remembers the current stack size,
   initial storage assumtion, and
   accumulated instructions. *)
type codegenEnv

val codeLength : codegenEnv -> int

(* for each instruction,
 * create an interface function.
 * This allows keeping track of stack size...
 *)

val push : PseudoImm.pseudo_imm -> codegenEnv -> codegenEnv
