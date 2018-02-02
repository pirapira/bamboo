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

type 'imm program = 'imm instruction list
let num_instructions = List.length

let empty_program = []

(** The program is stored in the reverse order *)
let append_inst orig i = i :: orig

let to_list (p : 'imm program) =
  List.rev p

let stack_eaten = function
  | PUSH1 _ -> 0
  | PUSH4 _ -> 0
  | PUSH32 _ -> 0
  | NOT -> 1
  | TIMESTAMP -> 0
  | EQ -> 2
  | ISZERO -> 1
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
  | SHA3 -> 2
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
  | EXTCODECOPY -> 4
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
  | JUMPDEST _ -> 0
  | SWAP1 -> 2
  | SWAP2 -> 3
  | SWAP3 -> 4
  | SWAP4 -> 5
  | SWAP5 -> 6
  | SWAP6 -> 7
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
  | DUP1 -> 1
  | DUP2 -> 2
  | DUP3 -> 3
  | DUP4 -> 4
  | DUP5 -> 5
  | DUP6 -> 6
  | DUP7 -> 7


let stack_pushed = function
  | PUSH1 _ -> 1
  | PUSH4 _ -> 1
  | PUSH32 _ -> 1
  | NOT -> 1
  | TIMESTAMP -> 1
  | EQ -> 1
  | ISZERO -> 1
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
  | SHA3 -> 1
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
  | EXTCODECOPY -> 0
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
  | JUMPDEST _ -> 0
  | SWAP1 -> 2
  | SWAP2 -> 3
  | SWAP3 -> 4
  | SWAP4 -> 5
  | SWAP5 -> 6
  | SWAP6 -> 7
  | DUP1 -> 2
  | DUP2 -> 3
  | DUP3 -> 4
  | DUP4 -> 5
  | DUP5 -> 6
  | DUP6 -> 7
  | DUP7 -> 8
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

let string_of_pseudo_opcode op =
  match op with
  | PUSH1 v -> "PUSH1 "^(PseudoImm.string_of_pseudo_imm v)
  | PUSH4 v -> "PUSH4 "^(PseudoImm.string_of_pseudo_imm v)
  | PUSH32 v -> "PUSH32 "^(PseudoImm.string_of_pseudo_imm v)
  | NOT -> "NOT"
  | TIMESTAMP -> "TIMESTAMP"
  | EQ -> "EQ"
  | ISZERO -> "ISZERO"
  | LT -> "LT"
  | GT -> "GT"
  | BALANCE -> "BALANCE"
  | STOP -> "STOP"
  | ADD -> "ADD"
  | MUL -> "MUL"
  | SUB -> "SUB"
  | DIV -> "DIV"
  | SDIV -> "SDIV"
  | EXP -> "EXP"
  | MOD -> "MOD"
  | SMOD -> "SMOD"
  | ADDMOD -> "ADDMOD"
  | MULMOD -> "MULMOD"
  | SIGNEXTEND -> "SIGNEXTEND"
  | SHA3 -> "SHA3"
  | ADDRESS -> "ADDRESS"
  | ORIGIN -> "ORIGIN"
  | CALLER -> "CALLER"
  | CALLVALUE -> "CALLVALUE"
  | CALLDATALOAD -> "CALLDATALOAD"
  | CALLDATASIZE -> "CALLDATASIZE"
  | CALLDATACOPY -> "CALLDATACOPY"
  | CODESIZE -> "CODESIZE"
  | CODECOPY -> "CODECOPY"
  | GASPRICE -> "GASPRICE"
  | EXTCODESIZE -> "EXTCODESIZE"
  | EXTCODECOPY -> "EXTCODECOPY"
  | POP -> "POP"
  | MLOAD -> "MLOAD"
  | MSTORE -> "MSTORE"
  | MSTORE8 -> "MSTORE8"
  | SLOAD -> "SLOAD"
  | SSTORE -> "SSTORE"
  | JUMP -> "JUMP"
  | JUMPI -> "JUMPI"
  | PC -> "PC"
  | MSIZE -> "MSIZE"
  | GAS -> "GAS"
  | JUMPDEST l -> "JUMPDEST (print label)"
  | SWAP1 -> "SWAP1"
  | SWAP2 -> "SWAP2"
  | SWAP3 -> "SWAP3"
  | SWAP4 -> "SWAP5"
  | SWAP5 -> "SWAP5"
  | SWAP6 -> "SWAP6"
  | DUP1 -> "DUP1"
  | DUP2 -> "DUP2"
  | DUP3 -> "DUP3"
  | DUP4 -> "DUP4"
  | DUP5 -> "DUP5"
  | DUP6 -> "DUP6"
  | DUP7 -> "DUP7"
  | LOG0 -> "LOG0"
  | LOG1 -> "LOG1"
  | LOG2 -> "LOG2"
  | LOG3 -> "LOG3"
  | LOG4 -> "LOG4"
  | CREATE -> "CREATE"
  | CALL -> "CALL"
  | CALLCODE -> "CALLCODE"
  | RETURN -> "RETURN"
  | DELEGATECALL -> "DELEGATECALL"
  | SUICIDE -> "SUICIDE"

let string_of_pseudo_program prg =
  let op_lst = to_list prg in
  String.concat "" (List.map (fun op -> string_of_pseudo_opcode op ^ "\n") op_lst)

let print_pseudo_program prg =
  Printf.printf "%s" (string_of_pseudo_program prg)

let hex_of_instruction (i : WrapBn.t instruction) : Hexa.hex =
  let h = Hexa.hex_of_string in
  match i with
  | PUSH1 i -> Hexa.concat_hex (h "60") (Hexa.hex_of_big_int i 1)
  | PUSH4 i -> Hexa.concat_hex (h "63") (Hexa.hex_of_big_int i 4)
  | PUSH32 i -> Hexa.concat_hex (h "7f") (Hexa.hex_of_big_int i 32)
  | NOT -> h "19"
  | TIMESTAMP -> h "42"
  | EQ -> h "14"
  | ISZERO -> h "15"
  | LT -> h "10"
  | GT -> h "11"
  | BALANCE -> h "31"
  | STOP -> h "00"
  | ADD -> h "01"
  | MUL -> h "02"
  | SUB -> h "03"
  | DIV -> h "04"
  | SDIV -> h "05"
  | MOD -> h "06"
  | SMOD -> h "07"
  | ADDMOD -> h "08"
  | MULMOD -> h "09"
  | EXP -> h "0a"
  | SIGNEXTEND -> h "0b"
  | SHA3 -> h "20"
  | ADDRESS -> h "30"
  | ORIGIN -> h "32"
  | CALLER -> h "33"
  | CALLVALUE -> h "34"
  | CALLDATALOAD -> h "35"
  | CALLDATASIZE -> h "36"
  | CALLDATACOPY -> h "37"
  | CODESIZE -> h "38"
  | CODECOPY -> h "39"
  | GASPRICE -> h "3a"
  | EXTCODESIZE -> h "3b"
  | EXTCODECOPY -> h "3c"
  | POP -> h "50"
  | MLOAD -> h "51"
  | MSTORE -> h "52"
  | MSTORE8 -> h "53"
  | SLOAD -> h "54"
  | SSTORE -> h "55"
  | JUMP -> h "56"
  | JUMPI -> h "57"
  | PC -> h "58"
  | MSIZE -> h "59"
  | GAS -> h "5a"
  | JUMPDEST _ -> h "5b"
  | LOG0 -> h "a0"
  | LOG1 -> h "a1"
  | LOG2 -> h "a2"
  | LOG3 -> h "a3"
  | LOG4 -> h "a4"
  | CREATE -> h "f0"
  | CALL -> h "f1"
  | CALLCODE -> h "f2"
  | RETURN -> h "f3"
  | DELEGATECALL -> h "f4"
  | SUICIDE -> h "ff"
  | SWAP1 -> h "90"
  | SWAP2 -> h "91"
  | SWAP3 -> h "92"
  | SWAP4 -> h "93"
  | SWAP5 -> h "94"
  | SWAP6 -> h "95"
  | DUP1 -> h "80"
  | DUP2 -> h "81"
  | DUP3 -> h "82"
  | DUP4 -> h "83"
  | DUP5 -> h "84"
  | DUP6 -> h "85"
  | DUP7 -> h "86"

let log (n : int) =
  match n with
  | 0 -> LOG0
  | 1 -> LOG1
  | 2 -> LOG2
  | 3 -> LOG3
  | 4 -> LOG4
  | _ -> failwith "too many indexed arguments for an event"

let rev_append_op (h : Hexa.hex) (i : WrapBn.t instruction) : Hexa.hex =
  Hexa.concat_hex (hex_of_instruction i) h

let hex_of_program (p : WrapBn.t program) : Hexa.hex =
  List.fold_left rev_append_op Hexa.empty_hex p

let print_imm_program (p : WrapBn.t program) : unit =
  let hex = hex_of_program p in
  Hexa.print_hex ~prefix:"0x" hex

let string_of_imm_program (p : WrapBn.t program) : string =
  let hex = hex_of_program p in
  Hexa.string_of_hex ~prefix:"0x" hex

let size_of_instruction i =
  match i with
  | PUSH1 _ -> 2
  | PUSH4 _ -> 5
  | PUSH32 _ -> 33
  | _ -> 1

let size_of_program p =
  List.fold_left (fun a i -> a + size_of_instruction i) 0 p

let dup_suc_n (n : int) =
  match n with
  | 0 -> DUP1
  | 1 -> DUP2
  | 2 -> DUP3
  | 3 -> DUP4
  | 4 -> DUP5
  | 5 -> DUP6
  | 6 -> DUP7
  | _ -> failwith "more DUP instructions needed"
