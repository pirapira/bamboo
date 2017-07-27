type 'imm instruction =
  | PUSH1 of 'imm
  | PUSH4 of 'imm
  | PUSH32 of 'imm
  | NOT
  | TIMESTAMP
  | EQ
  | ISZERO
  | LT
  | GT
  | BALANCE
  | STOP
  | ADD
  | MUL
  | SUB
  | DIV
  | SDIV
  | MOD
  | SMOD
  | ADDMOD
  | MULMOD
  | EXP
  | SIGNEXTEND
  | SHA3
  | ADDRESS
  | ORIGIN
  | CALLER
  | CALLVALUE
  | CALLDATALOAD
  | CALLDATASIZE
  | CALLDATACOPY
  | CODESIZE
  | CODECOPY
  | GASPRICE
  | EXTCODESIZE
  | EXTCODECOPY
  | POP
  | MLOAD
  | MSTORE
  | MSTORE8
  | SLOAD
  | SSTORE
  | JUMP
  | JUMPI
  | PC
  | MSIZE
  | GAS
  | JUMPDEST of Label.label
  | LOG0
  | LOG1
  | LOG2
  | LOG3
  | LOG4
  | CREATE
  | CALL
  | CALLCODE
  | RETURN
  | DELEGATECALL
  | SUICIDE
  | SWAP1
  | SWAP2
  | SWAP3
  | SWAP4
  | SWAP5
  | SWAP6
  | DUP1
  | DUP2
  | DUP3
  | DUP4
  | DUP5
  | DUP6
  | DUP7

val log : int -> 'a instruction


val dup_suc_n : int -> 'imm instruction

(** ['imm program] is a sequence of EVM instructions
 * where immediate values are expressed with type 'imm *)
type 'imm program = 'imm instruction list
val empty_program : 'imm program

val num_instructions : 'imm program -> int

val append_inst : 'imm program -> 'imm instruction -> 'imm program

val stack_eaten : 'imm instruction -> int
val stack_pushed : 'imm instruction -> int

val string_of_pseudo_opcode : PseudoImm.pseudo_imm instruction -> string

val string_of_pseudo_program : PseudoImm.pseudo_imm program -> string
val print_pseudo_program : PseudoImm.pseudo_imm program -> unit

val hex_of_instruction : Big_int.big_int instruction -> Hexa.hex
val hex_of_program : Big_int.big_int program -> Hexa.hex

val string_of_imm_program : Big_int.big_int program -> string
val print_imm_program : Big_int.big_int program -> unit

val size_of_instruction : 'exp instruction -> int
val size_of_program : 'exp program -> int

(*
Commented out till we need it.

val string_of_real_instruction :
  Big_int.big_int instruction -> string
val string_of_real_program : Big_int.big_int program -> unit
*)
