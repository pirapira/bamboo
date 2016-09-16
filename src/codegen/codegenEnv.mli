(* codegenEnv remembers the current stack size,
   initial storage assumtion, and
   accumulated instructions. *)
type codegenEnv

val push : pseudo_imm -> codegenEnv -> codegenEnv
