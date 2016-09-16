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

type 'imm program = 'imm instruction list
let program_length = List.length

let empty_program = []

(** The program is stored in the reverse order *)
let append_inst orig i = i :: orig

let to_list (p : 'imm program) =
  List.rev p

let stack_eaten = function
  | PUSH1 _ -> 0
  | PUSH32 _ -> 0
  | NOT -> 1
  | TIMESTAMP -> 0
  | NEQ -> 2
  | LT -> 2
  | GT -> 2
  | BALANCE -> 1
  | STOP -> 0
  | ADD -> 2
  | MUL -> 2
  | SUB -> 2
  | DIV -> 2
  | SDIV -> 2
  | MOD -> 2
  | SMOD -> 2
  | ADDMOD -> 3
  | MULMOD -> 3
  | EXP -> 2
  | SIGNEXTEND -> 2
  | ADDRESS -> 0
  | ORIGIN -> 0
  | CALLER -> 0
  | CALLVALUE -> 0
  | CALLDATALOAD -> 1
  | CALLDATASIZE -> 0
  | CALLDATACOPY -> 3
  | CODESIZE -> 0
  | CODECOPY -> 3
  | GASPRICE -> 0
  | EXTCODESIZE -> 1
  | POP -> 1
  | MLOAD -> 1
  | MSTORE -> 2
  | MSTORE8 -> 2
  | SLOAD -> 1
  | SSTORE -> 2
  | JUMP -> 1
  | JUMPI -> 2
  | PC -> 0
  | MSIZE -> 0
  | GAS -> 0
  | JUMPDEST -> 0
  | SWAP1 -> 2
  | LOG0 -> 2
  | LOG1 -> 3
  | LOG2 -> 4
  | LOG3 -> 5
  | LOG4 -> 6
  | CREATE -> 3
  | CALL -> 7
  | CALLCODE -> 7
  | RETURN -> 2
  | DELEGATECALL -> 7
  | SUICIDE -> 1


let stack_pushed = function
  | PUSH1 _ -> 1
  | PUSH32 _ -> 1
  | NOT -> 1
  | TIMESTAMP -> 1
  | NEQ -> 1
  | LT -> 1
  | GT -> 1
  | BALANCE -> 1
  | STOP -> 0
  | ADD -> 1
  | MUL -> 1
  | SUB -> 1
  | DIV -> 1
  | SDIV -> 1
  | EXP -> 1
  | MOD -> 1
  | SMOD -> 1
  | ADDMOD -> 1
  | MULMOD -> 1
  | SIGNEXTEND -> 1
  | ADDRESS -> 1
  | ORIGIN -> 1
  | CALLER -> 1
  | CALLVALUE -> 1
  | CALLDATALOAD -> 1
  | CALLDATASIZE -> 1
  | CALLDATACOPY -> 0
  | CODESIZE -> 1
  | CODECOPY -> 0
  | GASPRICE -> 1
  | EXTCODESIZE -> 1
  | POP -> 0
  | MLOAD -> 1
  | MSTORE -> 0
  | MSTORE8 -> 0
  | SLOAD -> 1
  | SSTORE -> 0
  | JUMP -> 0
  | JUMPI -> 0
  | PC -> 1
  | MSIZE -> 1
  | GAS -> 1
  | JUMPDEST -> 0
  | SWAP1 -> 2
  | LOG0 -> 0
  | LOG1 -> 0
  | LOG2 -> 0
  | LOG3 -> 0
  | LOG4 -> 0
  | CREATE -> 1
  | CALL -> 1
  | CALLCODE -> 1
  | RETURN -> 0
  | DELEGATECALL -> 1
  | SUICIDE -> 0
