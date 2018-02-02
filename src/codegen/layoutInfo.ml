(* Layout information that should be available after the constructor compilation finishes *)
type layout_info =
  { contract_ids : Assoc.contract_id list
  ; constructor_code_size : Assoc.contract_id -> int
    (* numbers about the storage *)
    (* The storage during the runtime looks like this: *)
    (* |current pc (might be entry_pc_of_current_contract)|array seed counter|pod contract argument0|pod contract argument1|...
       |array0's seed|array1's seed| *)
    (* In addition, array elements are placed at the same location as in Solidity *)

  ; storage_current_pc_index : int
  ; storage_array_counter_index : int
  ; storage_constructor_arguments_begin : Assoc.contract_id -> int
  ; storage_constructor_arguments_size : Assoc.contract_id -> int
  ; storage_array_seeds_begin : Assoc.contract_id -> int
  ; storage_array_seeds_size : Assoc.contract_id -> int
  }

(* Layout information that should be available after the runtime compilation finishes. *)
type post_layout_info =
  { (* The initial data is organized like this: *)
    (* |constructor code|runtime code|constructor arguments|  *)
    init_data_size : Assoc.contract_id -> int
    (* runtime_coode_offset is equal to constructor_code_size *)
  ; runtime_code_size : int
  ; contract_offset_in_runtime_code : int Assoc.contract_id_assoc
  (* And then, the runtime code is organized like this: *)
  (* |dispatcher that jumps into the stored pc|runtime code for contract A|runtime code for contract B|runtime code for contract C| *)

  ; constructor_in_runtime_code_offset : int Assoc.contract_id_assoc

  (* And then, the runtime code for a particular contract is organized like this: *)
  (* |dispatcher that jumps into a case|runtime code for case f|runtime code for case g| *)
  ; l : layout_info
  }


let print_layout_info l =
  let () = Printf.printf "layout_info\n" in
  let () = Printf.printf "  init_data_size:" in
  let () = Printf.printf "\n" in
  ()

type contract_layout_info =
  { contract_constructor_code_size : int
  ; contract_argument_size : int
  (** the number of words that the contract arguments occupy *)
  ; contract_num_array_seeds : int
  (** the number of arguments that arrays *)
  ; contract_args : Syntax.typ list
  (** the list of argument types *)
  }

type runtime_layout_info =
  { runtime_code_size : int
  ; runtime_offset_of_contract_id : int Assoc.contract_id_assoc
  ; runtime_offset_of_constructor : int Assoc.contract_id_assoc
  ; runtime_size_of_constructor : int Assoc.contract_id_assoc
  }

let compute_constructor_code_size lst cid =
  let c : contract_layout_info = Assoc.choose_contract cid lst in
  c.contract_constructor_code_size

let compute_constructor_arguments_size lst cid =
  let c : contract_layout_info = Assoc.choose_contract cid lst in
  c.contract_argument_size

let compute_constructor_arguments_begin lst runtime cid =
  compute_constructor_code_size lst cid +
    runtime.runtime_code_size

let compute_init_data_size lst runtime cid =
  compute_constructor_arguments_begin lst runtime cid +
    compute_constructor_arguments_size lst cid

let compute_storage_constructor_arguments_begin lst cid =
  2

let compute_storage_array_seeds_begin lst cid =
  compute_storage_constructor_arguments_begin lst cid +
    compute_constructor_arguments_size lst cid

let compute_storage_array_seeds_size lst cid =
  let c = Assoc.choose_contract cid lst in
  c.contract_num_array_seeds

let construct_layout_info
      (lst : (Assoc.contract_id * contract_layout_info) list) : layout_info =
  { contract_ids = List.map fst lst
  ; constructor_code_size = compute_constructor_code_size lst
  ; storage_current_pc_index = 0 (* This is a magic constant. *)
  ; storage_array_counter_index = 1 (* This is also a magic constant. *)
  ; storage_constructor_arguments_begin = compute_storage_constructor_arguments_begin lst
  ; storage_constructor_arguments_size = compute_constructor_arguments_size lst
  ; storage_array_seeds_begin = compute_storage_array_seeds_begin lst
  ; storage_array_seeds_size = compute_storage_array_seeds_size lst
  }

let construct_post_layout_info (lst : (Assoc.contract_id * contract_layout_info) list)
      (runtime : runtime_layout_info) : post_layout_info =
  { init_data_size = compute_init_data_size lst runtime
  ; runtime_code_size = runtime.runtime_code_size
  ; contract_offset_in_runtime_code = runtime.runtime_offset_of_contract_id
  ; l = construct_layout_info lst
  ; constructor_in_runtime_code_offset = runtime.runtime_offset_of_constructor
  }

(* Assuming the layout described above, this definition makes sense. *)
let runtime_code_offset (layout : layout_info) (cid : Assoc.contract_id) : int =
  layout.constructor_code_size cid

let rec realize_pseudo_imm (layout : post_layout_info) (initial_cid : Assoc.contract_id) (p : PseudoImm.pseudo_imm) : WrapBn.t =
  PseudoImm.(
  match p with
  | Big b -> b
  | Int i -> WrapBn.big_int_of_int i
  | DestLabel l ->
     WrapBn.big_int_of_int (Label.lookup_value l)
  | StorageProgramCounterIndex ->
     WrapBn.big_int_of_int (layout.l.storage_current_pc_index)
  | StorageConstructorArgumentsBegin cid ->
     WrapBn.big_int_of_int (layout.l.storage_constructor_arguments_begin cid)
  | StorageConstructorArgumentsSize cid ->
     WrapBn.big_int_of_int (layout.l.storage_constructor_arguments_size cid)
  | InitDataSize cid ->
     WrapBn.big_int_of_int (layout.init_data_size cid)
  | RuntimeCodeOffset cid ->
     WrapBn.big_int_of_int (runtime_code_offset layout.l cid)
  | RuntimeCodeSize ->
     WrapBn.big_int_of_int (layout.runtime_code_size)
  | ConstructorCodeSize cid ->
     WrapBn.big_int_of_int (layout.l.constructor_code_size cid)
  | ConstructorInRuntimeCodeOffset cid ->
     WrapBn.big_int_of_int (Assoc.choose_contract cid layout.constructor_in_runtime_code_offset)
  | ContractOffsetInRuntimeCode cid ->
     WrapBn.big_int_of_int (Assoc.choose_contract cid layout.contract_offset_in_runtime_code)
  | CaseOffsetInRuntimeCode (cid, case_header) ->
     let label = EntrypointDatabase.(lookup_entrypoint (Case (cid, case_header))) in
     let v = Label.lookup_value label in
     WrapBn.big_int_of_int v
  | Minus (a, b) ->
     WrapBn.sub_big_int (realize_pseudo_imm layout initial_cid a) (realize_pseudo_imm layout initial_cid b)
  )

let realize_pseudo_instruction (l : post_layout_info) (initial_cid : Assoc.contract_id) (i : PseudoImm.pseudo_imm Evm.instruction)
    : WrapBn.t Evm.instruction =
  Evm.(
  match i with
  | PUSH1 imm -> PUSH1 (realize_pseudo_imm l initial_cid imm)
  | PUSH4 imm -> PUSH4 (realize_pseudo_imm l initial_cid imm)
  | PUSH32 imm -> PUSH32 (realize_pseudo_imm l initial_cid imm)
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
  | SHA3 -> SHA3
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

let realize_pseudo_program (l : post_layout_info) (initial_cid : Assoc.contract_id) (p : PseudoImm.pseudo_imm Evm.program)
    : WrapBn.t Evm.program
  = List.map (realize_pseudo_instruction l initial_cid) p

let layout_info_of_contract (c : Syntax.typ Syntax.contract) (constructor_code : PseudoImm.pseudo_imm Evm.program) =
  { contract_constructor_code_size = Evm.size_of_program constructor_code
  ; contract_argument_size  = Ethereum.total_size_of_interface_args (List.map snd (Ethereum.constructor_arguments c))
  ; contract_num_array_seeds = List.length (Ethereum.arrays_in_contract c)
  ; contract_args = List.map (fun a -> a.Syntax.arg_typ) (c.Syntax.contract_arguments)
  }

let rec arg_locations_inner (offset : int) (used_plain_args : int) (used_mapping_seeds : int)
                            (num_of_plains : int)
                            (args : Syntax.typ list) : Storage.storage_location list =
  match args with
  | [] -> []
  | h :: t ->
     if Syntax.is_mapping h then
       (offset + num_of_plains + used_mapping_seeds) ::
         arg_locations_inner offset used_plain_args (used_mapping_seeds + 1) num_of_plains t
     else
       (offset + used_plain_args) ::
         arg_locations_inner offset (used_plain_args + 1) used_mapping_seeds num_of_plains t

(* this needs to take storage_constructor_arguments_begin *)
let arg_locations (offset : int) (cntr : Syntax.typ Syntax.contract) : Storage.storage_location list =
  let argument_types = List.map (fun a -> a.Syntax.arg_typ) cntr.Syntax.contract_arguments in
  let () = assert (List.for_all Syntax.fits_in_one_storage_slot argument_types) in
  let num_of_plains = Syntax.count_plain_args argument_types in
  arg_locations_inner offset 0 0 num_of_plains argument_types

let array_locations (cntr : Syntax.typ Syntax.contract) : Storage.storage_location list =
  let argument_types = List.map (fun a -> a.Syntax.arg_typ) cntr.Syntax.contract_arguments in
  let () = assert (List.for_all Syntax.fits_in_one_storage_slot argument_types) in
  let num_of_plains = Syntax.count_plain_args argument_types in
  let total_num = List.length argument_types in
  if total_num = num_of_plains then []
  else
  WrapList.range (2 + num_of_plains) (total_num + 1)
