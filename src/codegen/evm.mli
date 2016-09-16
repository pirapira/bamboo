(** ['imm program] is a sequence of EVM instructions
 * where immediate values are expressed with type 'imm *)
type 'imm program
val empty_program : 'imm program

val program_length : 'imm program -> int

type 'imm instruction =
  | PUSH1 of 'imm
  | PUSH32 of 'imm

val append_inst : 'imm program -> 'imm instruction -> 'imm program

val stack_eaten : 'imm instruction -> int
val stack_pushed : 'imm instruction -> int
