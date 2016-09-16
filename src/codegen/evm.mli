(** ['imm program] is a sequence of EVM instructions
 * where immediate values are expressed with type 'imm *)
type 'imm program
val empty_program : 'imm program

val program_length : 'imm program -> int

type 'imm instruction =
  | PUSH1 of 'imm
  | PUSH32 of 'imm
  | NOT
  | TIMESTAMP
  | NEQ
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
  | JUMPDEST
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

val append_inst : 'imm program -> 'imm instruction -> 'imm program

val stack_eaten : 'imm instruction -> int
val stack_pushed : 'imm instruction -> int
