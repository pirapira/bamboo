open PseudoImm
open CodegenEnv
open Evm
open Syntax

let size_of_typ (* in bytes *) = function
  | UintType -> 32
  | AddressType -> 32 (* Though only 20 bytes are used *)
  | BoolType -> 32
  | ReferenceType _ -> 32
  | TupleType lst ->
     failwith "size_of_typ Tuple"
  | MappingType _ -> failwith "size_of_typ MappingType"
  | ContractArchType _ -> failwith "size_of_typ ContractArchType"
  | ContractInstanceType _ -> 32 (* address as word *)

let copy_storage_range_to_stack_top le ce (range : PseudoImm.pseudo_imm Location.storage_range) =
  let () = assert (PseudoImm.is_constant_int 1 range.Location.storage_size) in
  let offset : PseudoImm.pseudo_imm = range.Location.storage_start in
  let ce = append_instruction ce (PUSH32 offset) in
  let ce = append_instruction ce SLOAD in
  (le, ce)

let copy_to_stack_top le ce (l : Location.location) =
  Location.(
    match l with
    | Storage range ->
       copy_storage_range_to_stack_top le ce range
    | CachedStorage _ -> failwith "copy_to_stack_top: CachedStorage"
    | Volatile _ -> failwith "copy_to_stack_top: Volatile"
    | Code _ -> failwith "copy_to_stack_top: Code"
    | Calldata _ -> failwith "copy_to_stack_top: Calldata"
    | Stack _ -> failwith "copy_to_stack_top: Stack"
  )


(* le is not updated here.  It can be only updated in
 * a variable initialization *)
let rec codegen_exp
      (le : LocationEnv.location_env)
      (ce : CodegenEnv.codegen_env)
      ((e,t) : Syntax.typ Syntax.exp) :
      CodegenEnv.codegen_env =
  let ret =
  Syntax.
  (match e,t with
   | AddressExp ((c, ContractInstanceType _)as inner), AddressType ->
      let ce = codegen_exp le ce inner in
      (* c is a contract instance.
       * The concrete representation of a contact instance is
       * already the address
       *)
      ce
   | AddressExp _, _ ->
      failwith "codegen_exp: AddressExp of unexpected type"
   | ValueExp,UintType ->
      let ce = CodegenEnv.append_instruction ce CALLVALUE in
      ce
   | ValueExp,_ -> failwith "ValueExp of strange type"
   | SenderExp,AddressType ->
      let ce = CodegenEnv.append_instruction ce CALLER in
      ce
   | SenderExp,_ -> failwith "codegen_exp: SenderExp of strange type"
   | ArrayAccessExp _, _ ->
      failwith "code gen array access"
   | ThisExp,_ ->
      let ce = CodegenEnv.append_instruction ce ADDRESS in
      ce
   | IdentifierExp id,_ ->
      begin match LocationEnv.lookup le id with
      (** if things are just DUP'ed, location env should not be
       * updated.  If they are SLOADED, the location env should be
       * updated. *)
      | Some location ->
         let (le, ce) = copy_to_stack_top le ce location in
         ce
      | None -> failwith ("identifier's location not found: "^id)
      end
  | FalseExp,BoolType ->
     let ce = CodegenEnv.append_instruction
                ce (Evm.PUSH1 (Big Big_int.zero_big_int)) in
     ce
  | FalseExp, _ -> failwith "codegen_exp: FalseExp of unexpected type"
  | TrueExp,BoolType ->
     let ce = append_instruction ce (PUSH1 (Big Big_int.unit_big_int)) in
     ce
  | TrueExp, _ -> failwith "codegen_exp: TrueExp of unexpected type"
  | NotExp sub,_ -> (* perhaps, better to check types *)
     let ce = codegen_exp le ce sub in
     let ce = append_instruction ce NOT in
     ce
  | NowExp,UintType ->
     append_instruction ce TIMESTAMP
  | NowExp,_ -> failwith "codegen_exp: NowExp of unexpected type"
  | NeqExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in (* l later because it should come at the top *)
     let ce = append_instruction ce EQ in
     let ce = append_instruction ce ISZERO in
     ce
  | NeqExp _, _ ->
     failwith "codegen_exp: NeqExp of unexpected type"
  | LtExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce LT in
     ce
  | LtExp _, _ -> failwith "codegen_exp: LtExp of unexpected type"
  | GtExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce GT in
     ce
  | GtExp _, _ -> failwith "codegen_exp GtExp of unexpected type"
  | EqualityExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce EQ in
     ce
  | EqualityExp _, _ ->
     failwith "codegen_exp EqualityExp of unexpected type"
  | SendExp s, _ ->
     failwith "codegen for SendExp"
     (* argument order, gas, to, value, in offset in size out offset, out size *)
(*     let out_size = send_out_size t s in
     let out_offset = usual_memory_offset in (* new location should be allocated *)
     let in_size = sned_in_size s in
     let in_offset = usual_memory_offset in
     let ce = append_instruction ce (PUSH32 out_size) in
     let ce = append_instruction ce (PUSH32 out_offset) in
     let ce = append_instruction ce (PUSH32 in_size) in
     let ce = append_instruction ce (PUSH32 in_offset) in
     let ce = prepare_arguments_in_memory ce s in
     let ce = codegen_exp ce value_exp in
     let ce = codegen_exp ce to_exp in
     let ce = append_instruction ce GAS in
     let ce = append_instruction ce CALL in
     let ce = append_instruction ce ISZERO in
     let ce = append_instruction ce NOT in (* stack head should be true iff success *)
     let (ce, success_label) = generate_new_label ce in
     let ce = append_instruction ce (PUSH32 success_label) in (* jump destination in case of success *)
     let ce = append_instruction ce IJUMP in
     let ce = append_instruction ce (PUSH1 0) in
     let ce = append_instruction ce JUMP in
     let ce = append_instruction ce (JUMPDEST success_label) in
     ce *)
  | NewExp new_e, _ ->
     failwith "exp code gen for new expression"
  | FunctionCallExp _, _ ->
     (* TODO maybe the name callexp should be changed, the only instance is the newly created contract, for which the new_exp should be responsible *)
     failwith "exp code gen for callexp"
  | ParenthExp _, _ ->
     failwith "ParenthExp not expected."
  | SingleDereferenceExp (reference, ref_typ), value_typ ->
     let () = assert (ref_typ = ReferenceType [value_typ]) in
     let size = size_of_typ value_typ in
     let () = assert (size mod 32 = 0) in (* assuming word-size *)
     let ce = codegen_exp le ce (reference, ref_typ) in (* pushes the pointer *)
     let ce = append_instruction ce MLOAD in
     ce
  | TupleDereferenceExp _, _ ->
     failwith "code generation for TupleDereferenceExp should not happen.  Instead, try to decompose it into several assignments."
  ) in
  let () = assert (stack_size ret = stack_size ce + 1) in
  ret

let codegen_sentence
  (orig : CodegenEnv.codegen_env)
  (s : Syntax.typ Syntax.sentence)
  (* is this enough? also add sentence Id's around?
   * I think this is enough.
   *)
  : CodegenEnv.codegen_env = failwith "codegen_sentence"

let move_info_around
  (assumption : CodegenEnv.codegen_env)
  (goal : LocationEnv.location_env) :
      CodegenEnv.codegen_env = failwith "move_info_around"

let codegen_bytecode
  (src : Syntax.typ Syntax.contract) :
      PseudoImm.pseudo_imm Evm.program = failwith "codegen_bytecode"

(** [initialize_memory_allocator] initializes memory position 64 as 96 *)
let initialize_memory_allocator (ce : CodegenEnv.codegen_env) =
  let ce = append_instruction ce (PUSH1 (Int 96)) in
  let ce = append_instruction ce (PUSH1 (Int 64)) in
  let ce = append_instruction ce MSTORE in
  ce

(** [push_allocated_memory] behaves like an instruction
 * that takes a desired memory size as an argument.
 * This pushes the allocated address.
 *)
let push_allocated_memory (ce : CodegenEnv.codegen_env) =
  let original_stack_size = stack_size ce in
  (* [desired_length] *)
  let ce = append_instruction ce (PUSH32 (Int 64)) in
  let ce = append_instruction ce DUP1 in
  (* [desired_length, 64, 64] *)
  let ce = append_instruction ce MLOAD in
  (* [desired_length, 64, memory[64]] *)
  let ce = append_instruction ce DUP1 in
  (* [desired_length, 64, memory[64], memory[64]] *)
  let ce = append_instruction ce SWAP3 in
  (* [memory[64], 64, memory[64], desired_length] *)
  let ce = append_instruction ce ADD in
  (* [memory[64], 64, new_head] *)
  let ce = append_instruction ce SWAP1 in
  (* [memory[64], new_head, 64] *)
  let ce = append_instruction ce MSTORE in
  (* [memory[64]] *)
  let () = assert (stack_size ce = original_stack_size) in
  ce

(** [copy_arguments_from_code_to_memory]
 *  copies constructor arguments at the end of the
 *  bytecode into the memory.  The number of bytes is
 *  decided using the contract interface.
 *  The memory usage counter at byte [0x40] is increased accordingly.
 *  After this, the stack contains the size and the beginning of the memory
 *  piece that contains the arguments.
 *  Output [rest of the stack, mem_size, mem_begin].
 *)
let copy_arguments_from_code_to_memory
      (le : LocationEnv.location_env)
      (ce : CodegenEnv.codegen_env)
      (contract : Syntax.typ Syntax.contract) :
      (CodegenEnv.codegen_env) =
  let total_size = Ethereum.total_size_of_interface_args
                     (List.map snd (Ethereum.constructor_arguments contract)) in
  let () = Printf.printf "total size of constructor arguments: %d\n%!" total_size in
  let original_stack_size = stack_size ce in
  (* [] *)
  let ce = append_instruction ce (PUSH32 (Int total_size)) in
  (* [total_size] *)
  let ce = append_instruction ce DUP1 in
  (* [total_size, total_size] *)
  let ce = push_allocated_memory ce in
  (* [total_size, memory_start] *)
  let ce = append_instruction ce DUP2 in
  (* [total_size, memory_start, total_size] *)
  let ce = append_instruction ce DUP1 in
  (* [total_size, memory_start, total_size, total_size] *)
  let ce = append_instruction ce CODESIZE in
  (* [total_size, memory_start, total_size, total_size, code size] *)
  let ce = append_instruction ce SUB in
  (* [total_size, memory_start, total_size, code_begin] *)
  let ce = append_instruction ce DUP3 in
  (* [total size, memory_start, total_size, code_begin, memory_start *)
  let ce = append_instruction ce CODECOPY in
  (* [total size, memory_start] *)
  let () = assert (original_stack_size + 2 = stack_size ce) in
  ce

(**
 * [set_contract_pc ce id] puts the program counter for the contract specified by
   [id] in the storage at index [StorageProgramCounterIndex]
 *)
let set_contract_pc ce (id : Assoc.contract_id) =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH32 (ContractOffsetInRuntimeCode id)) in
  let ce = append_instruction ce (PUSH32 StorageProgramCounterIndex) in
  let ce = append_instruction ce SSTORE in
  let () = assert (stack_size ce = original_stack_size) in
  ce

(**
 * [get_contract_pc ce] pushes the value at [StorageProgramCounterIndex] in storage.
 *)
let get_contract_pc ce =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH32 StorageProgramCounterIndex) in
  let ce = append_instruction ce SLOAD in
  let () = assert (stack_size ce = original_stack_size + 1) in
  ce

let increase_top ce (inc : int) =
  let ce = append_instruction ce (PUSH32 (Int inc)) in
  let ce = append_instruction ce ADD in
  ce

(**
 * [bulk_store_from_memory ce]
 * adds instructions to ce after which some memory contents are copied
 * to the storage.
 * Precondition: the stack has [..., size, memory_src_start, storage_target_start]
 * Postcondition: the stack has [...]
 *)
let bulk_sstore_from_memory ce =
  let original_stack_size = stack_size ce in
  (* TODO: check that size is a multiple of 32 *)
  let jump_label_continue = Label.new_label () in
  let jump_label_exit = Label.new_label () in
  let ce = append_instruction ce (JUMPDEST jump_label_continue) in
  (* stack [..., size, memory_src_start, storage_target_start] *)
  let ce = append_instruction ce DUP3 in
  (* stack [..., size, memory_src_start, storage_target_start, size] *)
  let ce = append_instruction ce ISZERO in
  (* stack [..., size, memory_src_start, storage_target_start, size is zero] *)
  let ce = append_instruction ce (PUSH32 (DestLabel jump_label_exit)) in
  (* stack [..., size, memory_src_start, storage_target_start, size is zero, jump_label_exit] *)
  let () = assert (stack_size ce = original_stack_size + 2) in
  let ce = append_instruction ce JUMPI in
  (* stack [..., size, memory_src_start, storage_target_start] *)
  let ce = append_instruction ce DUP2 in
  (* stack [..., size, memory_src_start, storage_target_start, memory_src_start] *)
  let ce = append_instruction ce MLOAD in
  (* stack [..., size, memory_src_start, storage_target_start, stored] *)
  let ce = append_instruction ce DUP2 in
  (* stack [..., size, memory_src_start, storage_target_start, stored, storage_target_start] *)
  let ce = append_instruction ce SSTORE in
  (* stack [..., size, memory_src_start, storage_target_start] *)
  (* decrease size *)
  let ce = append_instruction ce (PUSH32 (Int 32)) in
  (* stack [..., size, memory_src_start, storage_target_start, 32] *)
  let ce = append_instruction ce SWAP1 in
  (* stack [..., size, memory_src_start, 32, storage_target_start] *)
  let ce = append_instruction ce SWAP3 in
  (* stack [..., storage_target_start, memory_src_start, 32, size] *)
  let ce = append_instruction ce SUB in
  (* stack [..., storage_target_start, memory_src_start, new_size] *)
  let ce = append_instruction ce SWAP2 in
  (* stack [..., new_size, memory_src_start, storage_target_start] *)
  let ce = increase_top ce 1 in (* 1 word is 32 bytes. *)
  (* stack [..., new_size, memory_src_start, new_storage_target_start] *)
  let ce = append_instruction ce SWAP1 in
  (* stack [..., new_size, new_storage_target_start, memory_src_start] *)
  (* increase memory_src_start *)
  let ce = increase_top ce 32 in
  (* stack [..., new_size, new_storage_target_start, new_memory_src_start] *)
  let ce = append_instruction ce SWAP1 in
  (* stack [..., new_size, new_memory_src_start, new_storage_target_start] *)
  let () = assert (stack_size ce = original_stack_size) in
  (** add create a combinatino of jump and reset_stack_size *)
  let ce = append_instruction ce (PUSH32 (DestLabel jump_label_continue)) in
  let ce = append_instruction ce JUMP in
  (* stack [..., new_size, new_memory_src_start, new_storage_target_start] *)
  let ce = set_stack_size ce (original_stack_size) in
  let ce = append_instruction ce (JUMPDEST jump_label_exit) in
  (* stack [..., size, memory_src_start, storage_target_start] *)
  let ce = append_instruction ce POP in
  let ce = append_instruction ce POP in
  let ce = append_instruction ce POP in
  let () = assert (stack_size ce = original_stack_size - 3) in
  (* stack [...] *)
  ce

(** [copy_arguments_from_memory_to_storage le ce]
 *  adds instructions to ce such that the constructor arguments
 *  stored in the memory are copied to the storage.
 *  Precondition: the stack has [..., total, memory_start]
 *  Final storage has the arguments in [ConstructorArgumentBegin...ConstructorArgumentBegin + ConstructorArgumentLength]
 *  The final stack has [...] in the precondition.
 *)
let copy_arguments_from_memory_to_storage le ce (contract_id : Assoc.contract_id) =
  let ce = append_instruction
             ce (PUSH32 (StorageConstructorArgumentsBegin contract_id)) in
  (* stack, [..., size, memory_start, destination_storage_start] *)
  bulk_sstore_from_memory ce

(** [copy_runtime_code_to_memory ce contracts contract_id]
 * adds instructions to [ce] so that in the final
 * state the memory contains the runtime code
 * for all contracts that are reachable from [contract_id] in the
 * list [contracts] in the
 * addresses [code_start, code_start + code_size).
 * This adds two elements to the stack, resulting in
 * [..., code_length, code_start) *)
let copy_runtime_code_to_memory ce contracts contract_id =
  let original_stack_size = stack_size ce in
  (* stack: [...] *)
  let ce = append_instruction ce (PUSH32 (RuntimeCodeSize)) in
  (* stack: [run_code_size] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [run_code_size, run_code_size] *)
  let ce = push_allocated_memory ce in
  (* stack: [run_code_size, run_code_address] *)
  let ce = append_instruction ce DUP2 in
  (* stack: [run_code_size, run_code_address, run_code_size] *)
  let ce = append_instruction ce (PUSH32 (RuntimeCodeOffset)) in
  (* stack: [run_code_size, run_code_address, run_code_size, RuntimeCodeOffset] *)
  let ce = append_instruction ce DUP3 in
  (* stack: [run_code_size, run_code_address, run_code_size, run_code_in_code, run_code_address] *)
  let ce = append_instruction ce CODECOPY in
  (* stack: [run_code_size, run_code_address] *)
  let () = assert (stack_size ce = original_stack_size + 2) in
  ce

let cid_lookup_in_assoc (contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc)
                        (name : string) : Assoc.contract_id =
  Assoc.lookup_id (fun c -> c.contract_name = name) contracts

let setup_seed (le, ce) (loc : Storage.storage_location) =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 1)) in
  (* stack: [1] *)
  let ce = append_instruction ce SLOAD in
  (* stack: [orig_seed] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [orig_seed, orig_seed] *)
  let ce = append_instruction ce (PUSH4 (PseudoImm.Int loc)) in
  (* stack: [orig_seed, orig_seed, loc] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [orig_seed] *)
  let ce = increase_top ce 1 in
  (* stack: [orig_seed + 1] *)
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 1)) in
  (* stack: [orig_seed + 1, 1] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [] *)
  let () = assert (stack_size ce = original_stack_size) in
  (le, ce)

let setup_array_seeds le ce (contract: Syntax.typ Syntax.contract) : CodegenEnv.codegen_env =
  let array_locations = LayoutInfo.array_locations contract in
  let (_, ce) =
    List.fold_left setup_seed (le, ce) array_locations in
  ce

let codegen_constructor_bytecode
      ((contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc),
       (contract_id : Assoc.contract_id))
    :
      (CodegenEnv.codegen_env (* containing the program *)
       ) =
  let le = LocationEnv.constructor_initial_location_env contract_id
                                                        (Assoc.choose_contract contract_id contracts) in
  let ce = CodegenEnv.empty_env (cid_lookup_in_assoc contracts) contracts in
  let ce = initialize_memory_allocator ce in
  (* implement some kind of fold function over the argument list
   * each step generates new (le,ce) *)
  let ce = copy_arguments_from_code_to_memory le ce
             (Assoc.choose_contract contract_id contracts) in
  (* stack: [arg_mem_size, arg_mem_begin] *)
  let (ce: CodegenEnv.codegen_env) = copy_arguments_from_memory_to_storage le ce contract_id in
  (* stack: [] *)
  (* set up array seeds *)
  let (ce :CodegenEnv.codegen_env) = setup_array_seeds le ce (Assoc.choose_contract contract_id contracts) in
  let ce = set_contract_pc ce contract_id in
  (* stack: [] *)
  let ce = copy_runtime_code_to_memory ce contracts contract_id in
  (* stack: [code_length, code_start_on_memory] *)
  let ce = CodegenEnv.append_instruction ce RETURN in
  ce

type constructor_compiled =
  { constructor_codegen_env : CodegenEnv.codegen_env
  ; constructor_interface : Contract.contract_interface
  ; constructor_contract : Syntax.typ Syntax.contract
  }

type runtime_compiled =
  { runtime_codegen_env : CodegenEnv.codegen_env
  ; runtime_contract_offsets : int Assoc.contract_id_assoc
  }

let empty_runtime_compiled cid_lookup layouts =
  { runtime_codegen_env = (CodegenEnv.empty_env cid_lookup layouts)
  ; runtime_contract_offsets = []
  }

let compile_constructor ((lst, cid) : (Syntax.typ Syntax.contract Assoc.contract_id_assoc * Assoc.contract_id)) : constructor_compiled =
  { constructor_codegen_env = codegen_constructor_bytecode (lst, cid)
  ; constructor_interface = Contract.contract_interface_of (List.assoc cid lst)
  ; constructor_contract = List.assoc cid lst
  }

let compile_constructors (contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc)
    : constructor_compiled Assoc.contract_id_assoc =
  Assoc.assoc_pair_map (fun cid _ -> compile_constructor (contracts, cid)) contracts

let initial_runtime_compiled (cid_lookup : string -> Assoc.contract_id) layouts : runtime_compiled =
  let ce = CodegenEnv.empty_env cid_lookup layouts in
  let ce = get_contract_pc ce in
  let ce = append_instruction ce JUMP in
  { runtime_codegen_env = ce
  ; runtime_contract_offsets = []
  }

let push_signature_code (ce : CodegenEnv.codegen_env)
                        (case_signature : usual_case_header)
  =
  let hash = Ethereum.case_header_signature_hash case_signature in
  let ce = append_instruction ce (PUSH4 (Big (Ethereum.hex_to_big_int hash))) in
  ce

let push_destination_for (ce : CodegenEnv.codegen_env)
                         (cid : Assoc.contract_id)
                         (case_signature : case_header) =
  append_instruction ce
  (PUSH32 (CaseOffsetInRuntimeCode (cid, case_signature)))

let add_dispatcher_for_a_usual_case le ce contract_id case_signature
  =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce DUP1 in
  let ce = push_signature_code ce case_signature in
  let ce = append_instruction ce EQ in
  let ce = push_destination_for ce contract_id (UsualCaseHeader case_signature) in
  let ce = append_instruction ce JUMPI in
  let () = assert (stack_size ce = original_stack_size) in
  ce

let add_dispatcher_for_default_case le ce contract_id =
  let original_stack_size = stack_size ce in
  let ce = push_destination_for ce contract_id DefaultCaseHeader in
  let ce = append_instruction ce JUMP in
  let () = assert (stack_size ce = original_stack_size) in
  ce

let push_word_from_input_data_at_byte ce b =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH32 b) in
  let ce = append_instruction ce CALLDATALOAD in
  let () = assert (stack_size ce = original_stack_size + 1) in
  ce

let stack_top_shift_right ce amount =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH1 (Int amount)) in
  let ce = append_instruction ce (PUSH1 (Int 2)) in
  let ce = append_instruction ce EXP in
  let ce = append_instruction ce SWAP1 in
  let ce = append_instruction ce DIV in
  let () = assert (stack_size ce = original_stack_size) in
  ce

let add_throw ce =
  (* Just using the same method as solc. *)
  let ce = append_instruction ce (PUSH1 (Int 2)) in
  let ce = append_instruction ce JUMP in
  ce

let add_dispatcher le ce contract_id contract =
  let original_stack_size = stack_size ce in

  (* load the first four bytes of the input data *)
  let ce = push_word_from_input_data_at_byte ce (Int 0) in
  let ce = stack_top_shift_right ce Ethereum.(word_bits - signature_bits) in
  let () = assert (stack_size ce = original_stack_size + 1) in
  let case_signatures = List.map (fun x -> x.Syntax.case_header) contract.contract_cases in

  let usual_case_headers = BatList.filter_map
                             (fun h -> match h with DefaultCaseHeader -> None |
                                                    UsualCaseHeader u -> Some u
                             ) case_signatures in
  let ce = List.fold_left
             (fun ce case_signature ->
               add_dispatcher_for_a_usual_case le ce contract_id case_signature)
             ce usual_case_headers in
  let ce = append_instruction ce POP in (* the signature in input is not necessary anymore *)
  let ce =
    if List.exists (fun h -> match h with DefaultCaseHeader -> true | _ -> false) case_signatures then
      add_dispatcher_for_default_case le ce contract_id
    else add_throw ce
  in
  (le, ce)

let add_case_destination ce (cid : Assoc.contract_id) (h : Syntax.case_header) =
  let new_label = Label.new_label () in
  let ce = append_instruction ce (JUMPDEST new_label) in
  let () = EntrypointDatabase.(register_entrypoint (Case (cid, h)) new_label) in
  ce

(** [prepare_words_on_stack le ce [arg0 arg1]] evaluates
 * [arg1] and then [arg0] and puts them onto the stack.
 * [arg0] will be the topmost element of the stack.
 *)
let prepare_words_on_stack le ce (args : typ exp list) =
  (le, List.fold_right (fun arg ce' -> codegen_exp le ce' arg) args ce)

let store_word_into_storage_location (le, ce) (arg_location : Storage.storage_location) =
  let ce = append_instruction ce (PUSH32 (PseudoImm.Int arg_location)) in
  let ce = append_instruction ce SSTORE in
  (le, ce)

(** [store_words_into_storage_locations le ce arg_locations] moves the topmost stack element to the
 *  location indicated by [arg_locations] and the next element to the next location and so on.
 *  The stack elements will disappear.
 *)
let store_words_into_storage_locations le ce arg_locations =
  List.fold_left
    store_word_into_storage_location
    (le, ce) arg_locations

let set_contract_arguments le ce offset cid (args : typ exp list) =
  let contract =
    try contract_lookup ce cid
    with e ->
      let () = Printf.eprintf "set_contract_arguments: looking up %d\n" cid in
      raise e
  in
  let arg_locations : Storage.storage_location list = LayoutInfo.arg_locations offset contract in
  let () = assert (List.length arg_locations = List.length args) in
  let (le, ce) = prepare_words_on_stack le ce args in
  let (le, ce) = store_words_into_storage_locations le ce arg_locations in
  (* TODO
   * In a special case where no movements are necessary, we can then skip these arguments.
   *)
  (le, ce)

let set_continuation_to_function_call le ce layout (fcall, typ_exp) =
  let head : string = fcall.call_head in
  let args : typ exp list = fcall.call_args in
  let cid = cid_lookup ce head in
  let ce = set_contract_pc ce cid in
  let offset = layout.LayoutInfo.storage_constructor_arguments_begin cid in
  let (le, ce) =
    try
      set_contract_arguments le ce offset cid args
    with e ->
      let () = Printf.eprintf "name of contract: %s\n" head in
      let () = Printf.eprintf "set_continuation_to_function_call cid: %d\n" cid in
      raise e
  in
  (le, ce)

(*
 * set_continuation sets the storage contents.
 * So that the next message call would start from the continuation.
 *)
let set_continuation le ce (layout : LayoutInfo.layout_info) (cont_exp, typ_exp) =
  let original_stack_size = stack_size ce in
  let (le, ce) =
    match cont_exp with
    | FunctionCallExp fcall -> set_continuation_to_function_call le ce layout (fcall, typ_exp)
    | _ -> failwith "strange_continuation" in
  let () = assert (stack_size ce = original_stack_size) in
  (le, ce)

(*
 * Before this, the stack contains
 * ..., value (depends on typ).
 * The value would be stored in memory
 * After this, the stack contains
 * ..., size_in_bytes, offset_in_memory
 *)
let move_stack_top_to_memory typ le ce =
  let () = assert (size_of_typ typ = 32) in
  (* ..., value *)
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 32)) in
  (* ..., value, 32 *)
  let ce = append_instruction ce DUP1 in
  (* ..., value, 32, 32 *)
  let ce = push_allocated_memory ce in
  (* ..., value, 32, addr *)
  let ce = append_instruction ce SWAP2 in
  (* ..., 32, addr, value *)
  let ce = append_instruction ce DUP2 in
  (* ..., 32, addr, value, addr *)
  let ce = append_instruction ce MSTORE in
  (* ..., 32, addr *)
  ce

(*
 * after this, the stack contains
 * ..., size, offset_in_memory
 *)
let place_exp_in_memory le ce ((e, typ) : typ exp) =
  let original_stack_size = stack_size ce in
  let ce = codegen_exp le ce (e, typ) in
  let () = assert (stack_size ce = 1 + original_stack_size) in
  (* the stack layout depends on typ *)
  let ce = move_stack_top_to_memory typ le ce in
  let () = assert (stack_size ce = 2 + original_stack_size) in
  le, ce

(*
 * return_mem_content assumes the stack left after place_exp_in_memory
 * ..., size, offset_in_memory
 *)
let return_mem_content le ce =
  append_instruction ce RETURN

let add_return le ce (layout : LayoutInfo.layout_info) ret =
  let original_stack_size = stack_size ce in
  let e = ret.return_exp in
  let c = ret.return_cont in
  let (le, ce) = set_continuation le ce layout c in
  let (le, ce) = place_exp_in_memory le ce e in
  let ce = return_mem_content le ce in
  let () = assert (stack_size ce = original_stack_size) in
  (le, ce)

(* TODO: refactor with codegen_exp *)
let codegen_array_seed le ce array =
  begin match LocationEnv.lookup le array with
  (** if things are just DUP'ed, location env should not be
   * updated.  If they are SLOADED, the location env should be
   * updated. *)
  | Some location ->
     let (le, ce) = copy_to_stack_top le ce location in
     ce
  | None -> failwith ("identifier's location not found: "^array)
  end

let keccak_cons le ce =
  let original_stack_size = stack_size ce in
  (* put the top into 0x00 *)
  let ce = append_instruction ce (PUSH1 (Int 0x0)) in
  let ce = append_instruction ce MSTORE in
  (* put the top into 0x20 *)
  let ce = append_instruction ce (PUSH1 (Int 0x20)) in
  let ce = append_instruction ce MSTORE in
  (* take the sah3 of 0x00--0x40 *)
  let ce = append_instruction ce (PUSH1 (Int 0x20)) in
  let ce = append_instruction ce (PUSH1 (Int 0x0)) in
  let ce = append_instruction ce SHA3 in
  let () = assert (stack_size ce + 1 = original_stack_size) in
  ce

let put_stacktop_into_array_access le ce layout (aa : Syntax.typ Syntax.array_access) =
  let array = aa.Syntax.array_access_array in
  let index = aa.Syntax.array_access_index in
  let ce = codegen_exp le ce index in
  (* stack : [value, index] *)
  let ce = codegen_array_seed le ce array in
  (* stack : [value, index, array_seed] *)
  let ce = keccak_cons le ce in
  (* stack : [value, kec(array_seed ^ index)] *)
  let ce = append_instruction ce SSTORE in
  ce

let put_stacktop_into_lexp le ce layout l =
  let original_stack_size = stack_size ce in
  let ce =
    match l with
    | IdentifierLExp ident -> failwith "put into identifier"
    | ArrayAccessLExp aa -> put_stacktop_into_array_access le ce layout aa
    in
  let () = assert (original_stack_size = stack_size ce + 1) in
  ce

let add_assignment le ce layout l r =
  let original_stack_size = stack_size ce in
  (* produce r on the stack and then think about where to put that *)
  let ce = codegen_exp le ce r in
  let () = assert (1 + original_stack_size = stack_size ce) in
  let ce = put_stacktop_into_lexp le ce layout l in
  let () = assert (original_stack_size = stack_size ce) in
  (le, ce)

let add_variable_init le ce layout i =
  let position = stack_size ce in
  let ce = codegen_exp le ce i.Syntax.variable_init_value in
  let name = i.Syntax.variable_init_name in
  let loc = Location.Stack position in
  let le = LocationEnv.add_pair le name loc in
  (le, ce)

let add_sentence le ce (layout : LayoutInfo.layout_info) sent =
  match sent with
  | AbortSentence -> (le, add_throw ce)
  | ReturnSentence ret -> add_return le ce layout ret
  | AssignmentSentence (l, r) -> add_assignment le ce layout l r
  | VariableInitSentence i -> add_variable_init le ce layout i
  | IfSingleSentence _ -> failwith "ifsingle"
  | SelfdestructSentence _ -> failwith "destruct"

let add_case_argument_locations (le : LocationEnv.location_env) (case : Syntax.typ Syntax.case) =
  let additions : (string * Location.location) list = Ethereum.arguments_with_locations case in
  LocationEnv.add_pairs le additions

let add_case (le : LocationEnv.location_env) (ce : CodegenEnv.codegen_env) layout (cid : Assoc.contract_id) (case : Syntax.typ Syntax.case) =
  let ce = add_case_destination ce cid case.case_header in
  let le = LocationEnv.add_empty_block le in
  let le = add_case_argument_locations le case in
  let ((le : LocationEnv.location_env), ce) =
    List.fold_left
      (fun ((le : LocationEnv.location_env), ce) sent -> add_sentence le ce layout sent)
      (le, ce) case.case_body in
  (le, ce)

let codegen_append_contract_bytecode
      le ce layout
      ((cid, contract) : Assoc.contract_id * Syntax.typ Syntax.contract) =
  (* jump destination for the contract *)
  let entry_label = Label.new_label () in
  let ce = append_instruction ce (JUMPDEST entry_label) in
  (* update the entrypoint database with (id, pc) pair *)
  let () = EntrypointDatabase.(register_entrypoint
                                 (Contract cid) entry_label) in

  let ce = initialize_memory_allocator ce in

  (* add jumps to the cases *)
  let (le, ce) = add_dispatcher le ce cid contract in

  (* add the cases *)
  let cases = contract.Syntax.contract_cases in
  let (le, ce) = List.fold_left
                   (fun (le,ce) case -> add_case le ce layout cid case)
                   (le, ce) cases in

  ce

let append_runtime layout (prev : runtime_compiled)
                   ((cid : Assoc.contract_id), (contract : Syntax.typ Syntax.contract))
                   : runtime_compiled =
  { runtime_codegen_env = codegen_append_contract_bytecode (LocationEnv.runtime_initial_location_env contract) prev.runtime_codegen_env layout (cid, contract)
  ; runtime_contract_offsets = Assoc.insert cid (CodegenEnv.code_length prev.runtime_codegen_env) prev.runtime_contract_offsets
  }

let compile_runtime layout (contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc)
    : runtime_compiled =
  List.fold_left (append_runtime layout) (initial_runtime_compiled (cid_lookup_in_assoc contracts) contracts) contracts

let layout_info_from_constructor_compiled (cc : constructor_compiled) : LayoutInfo.contract_layout_info =
  LayoutInfo.layout_info_of_contract cc.constructor_contract (CodegenEnv.ce_program cc.constructor_codegen_env)

let layout_info_from_runtime_compiled (rc : runtime_compiled) : LayoutInfo.runtime_layout_info =
  { LayoutInfo.runtime_code_size = CodegenEnv.code_length rc.runtime_codegen_env
  ; LayoutInfo.runtime_offset_of_contract_id = rc.runtime_contract_offsets
  }


let compose_bytecode (constructors : constructor_compiled Assoc.contract_id_assoc)
                     (runtime : runtime_compiled) (cid : Assoc.contract_id)
    : Big_int.big_int Evm.program =
  let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
    List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
  let runtime_layout = layout_info_from_runtime_compiled runtime in
  let layout = LayoutInfo.construct_post_layout_info contracts_layout_info runtime_layout in
  let pseudo_constructor = Assoc.choose_contract cid constructors in
  let imm_constructor = LayoutInfo.realize_pseudo_program layout cid (CodegenEnv.ce_program pseudo_constructor.constructor_codegen_env) in
  let imm_runtime = LayoutInfo.realize_pseudo_program layout cid (CodegenEnv.ce_program runtime.runtime_codegen_env) in
  (* the code is stored in the reverse order *)
  imm_runtime@imm_constructor

let compose_runtime_bytecode (constructors : constructor_compiled Assoc.contract_id_assoc)
                     (runtime : runtime_compiled)
    : Big_int.big_int Evm.program =
  let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
    List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
  let runtime_layout = layout_info_from_runtime_compiled runtime in
  let layout = LayoutInfo.construct_post_layout_info contracts_layout_info runtime_layout in
  (* TODO: 0 in the next line is a bit ugly. *)
  let imm_runtime = LayoutInfo.realize_pseudo_program layout 0 (CodegenEnv.ce_program runtime.runtime_codegen_env) in
  imm_runtime
