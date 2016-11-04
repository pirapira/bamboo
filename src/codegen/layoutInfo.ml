type layout_info =
  { (* The initial data is organized like this: *)
    (* |constructor code|runtime code|constructor arguments|  *)
    init_data_size : Syntax.contract_id -> int
  ; constructor_code_size : int
    (* runtime_coode_offset is equal to constructor_code_size *)
  ; runtime_code_size : int
  ; contract_offset_in_runtime_code : Syntax.contract_id -> int

    (* And then, the runtime code is organized like this: *)
    (* |dispatcher that jumps into a contract|runtime code for contract A|runtime code for contract B|runtime code for contract C| *)

    (* And then, the runtime code for a particular contract is organized like this: *)
    (* |dispatcher that jumps into somewhere|runtime code for case f|runtime code for case g| *)

    (* numbers about the storage *)
    (* The storage during the runtime looks like this: *)
    (* |pc of the current contract|pod contract argument0|pod contract argument1| *)
    (* In addition, array elements are placed at the same location as in Solidity *)

  ; storage_contract_switcher_index : int
  ; storage_constructor_arguments_begin : Syntax.contract_id -> int
  ; storage_constructor_arguments_size : Syntax.contract_id -> int
  }

type contract_layout_info =
  { contract_runtime_code_size : int
  (** the number of bytes that the runtime code occupy *)
  ; contract_argument_size : int
  (** the number of words that the contract arguments occupy *)
  }

let construct_layout_info : contract_layout_info list -> layout_info =
  failwith "not implemented"

(* Assuming the layout described above, this definition makes sense. *)
let runtime_code_offset (layout : layout_info) :int =
  layout.constructor_code_size

let rec realize_pseudo_imm (layout : layout_info) (p : PseudoImm.pseudo_imm) : Big_int.big_int =
  PseudoImm.(
  match p with
  | Big b -> b
  | Int i -> Big_int.big_int_of_int i
  | DestLabel l ->
     failwith "realize_pseudo_imm: destlabel"
  | ContractId cid ->
     failwith "realize_pseudo_imm: should be a pc or an id itself or a signature?"
  | StorageContractSwitcherIndex ->
     Big_int.big_int_of_int layout.storage_contract_switcher_index
  | StorageConstructorArgumentsBegin cid ->
     Big_int.big_int_of_int (layout.storage_constructor_arguments_begin cid)
  | StorageConstructorArgumentsSize cid ->
     Big_int.big_int_of_int (layout.storage_constructor_arguments_size cid)
  | InitDataSize cid ->
     Big_int.big_int_of_int (layout.init_data_size cid)
  | RuntimeCodeOffset ->
     Big_int.big_int_of_int (runtime_code_offset layout)
  | RuntimeCodeSize ->
     Big_int.big_int_of_int (layout.runtime_code_size)
  | ContractOffsetInRuntimeCode cid ->
     Big_int.big_int_of_int (layout.contract_offset_in_runtime_code cid)
  | CaseOffsetInRuntimeCode (cid, case_header) ->
     failwith "realize_pseudo_imm caseoffset"
  | Minus (a, b) ->
     Big_int.sub_big_int (realize_pseudo_imm layout a) (realize_pseudo_imm layout b)
  )

let realize_pseudo_instruction (l : layout_info) (i : PseudoImm.pseudo_imm Evm.instruction)
    : Big_int.big_int Evm.instruction =
  Evm.(
  match i with
  | PUSH1 imm -> PUSH1 (realize_pseudo_imm l imm)
  | PUSH32 imm -> PUSH32 (realize_pseudo_imm l imm)
  | NOT -> NOT
  | TIMESTAMP -> TIMESTAMP
  | EQ -> EQ
  | ISZERO -> ISZERO
  | LT -> LT
  | GT -> GT
  | BALANCE -> BALANCE
  | STOP -> STOP
  | ADD -> ADD
  | MUL -> MUL
  | SUB -> SUB
  | DIV -> DIV
  | SDIV -> SDIV
  | MOD -> MOD
  | SMOD -> SMOD
  | ADDMOD -> ADDMOD
  | MULMOD -> MULMOD
  | EXP -> EXP
  | SIGNEXTEND -> SIGNEXTEND
  | ADDRESS -> ADDRESS
  | ORIGIN -> ORIGIN
  | CALLER -> CALLER
  | CALLVALUE -> CALLVALUE
  | CALLDATALOAD -> CALLDATALOAD
  | CALLDATASIZE -> CALLDATASIZE
  | CALLDATACOPY -> CALLDATACOPY
  | CODESIZE -> CODESIZE
  | CODECOPY -> CODECOPY
  | GASPRICE -> GASPRICE
  | EXTCODESIZE -> EXTCODESIZE
  | EXTCODECOPY -> EXTCODECOPY
  | POP -> POP
  | MLOAD -> MLOAD
  | MSTORE -> MSTORE
  | MSTORE8 -> MSTORE8
  | SLOAD -> SLOAD
  | SSTORE -> SSTORE
  | JUMP -> JUMP
  | JUMPI -> JUMPI
  | PC -> PC
  | MSIZE -> MSIZE
  | GAS -> GAS
  | JUMPDEST l -> JUMPDEST l
  | LOG0 -> LOG0
  | LOG1 -> LOG1
  | LOG2 -> LOG2
  | LOG3 -> LOG3
  | LOG4 -> LOG4
  | CREATE -> CREATE
  | CALL -> CALL
  | CALLCODE -> CALLCODE
  | RETURN -> RETURN
  | DELEGATECALL -> DELEGATECALL
  | SUICIDE -> SUICIDE
  | SWAP1 -> SWAP1
  | SWAP2 -> SWAP2
  | SWAP3 -> SWAP3
  | SWAP4 -> SWAP4
  | SWAP5 -> SWAP5
  | SWAP6 -> SWAP6
  | DUP1 -> DUP1
  | DUP2 -> DUP2
  | DUP3 -> DUP3
  | DUP4 -> DUP4
  | DUP5 -> DUP5
  | DUP6 -> DUP6
  | DUP7 -> DUP7
  )

let realize_pseudo_program (l : layout_info) (p : PseudoImm.pseudo_imm Evm.program)
    : Big_int.big_int Evm.program
  = List.map (realize_pseudo_instruction l) p

let layout_info_of_contract = failwith "unimplemented"
