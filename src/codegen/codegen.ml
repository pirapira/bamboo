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

let copy_to_stack_top (l : Location.location) =
  failwith "copy_to_stack_top"

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
         let (le, ce) = copy_to_stack_top location in
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
     let ce = append_instruction ce NEQ in
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
 * [set_contract_id ce id] puts the id in the storage at index
 * [StorageContractId]
 *)
let set_contract_id ce (id : Syntax.contract_id) =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH32 (ContractOffsetInRuntimeCode id)) in
  let ce = append_instruction ce (PUSH32 StorageContractOffset) in
  let ce = append_instruction ce SSTORE in
  let () = assert (stack_size ce = original_stack_size) in
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
  let ce = append_instruction ce DUP2 in
  (* stack [..., size, memory_src_start, storage_target_start, memory_src_start, storage_target_start] *)
  let ce = append_instruction ce SSTORE in
  (* stack [..., size, memory_src_start, storage_target_start] *)
  (* decrease size *)
  let ce = append_instruction ce (PUSH32 (Int 32)) in
  (* stack [..., size, memory_src_start, storage_target_start, 32] *)
  let ce = append_instruction ce SWAP3 in
  (* stack [..., storage_target_start, memory_src_start, 32, size] *)
  let ce = append_instruction ce SUB in
  (* stack [..., storage_target_start, memory_src_start, new_size] *)
  let ce = append_instruction ce SWAP2 in
  (* stack [..., new_size, storage_target_start, memory_src_start] *)
  (* increase memory_src_start *)
  let ce = increase_top ce 32 in
  (* stack [..., new_size, storage_target_start, new_memory_src_start] *)
  (* increase storage_target_start *)
  let ce = append_instruction ce SWAP1 in
  (* stack [..., new_size, new_memory_src_start, storage_target_start] *)
  let ce = increase_top ce 32 in
  (* stack [..., new_size, new_memory_src_start, new_storage_target_start] *)
  let () = assert (stack_size ce = original_stack_size) in
  (** add create a combinatino of jump and reset_stack_size *)
  let ce = append_instruction ce JUMP in
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
let copy_arguments_from_memory_to_storage le ce (contract_id : Syntax.contract_id) =
  let ce = append_instruction
             ce (PUSH32 (StorageConstructorArgumentBegin contract_id)) in
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


let codegen_constructor_bytecode
      ((contracts : Syntax.typ Syntax.contract list),
       (contract_id : Syntax.contract_id))
    :
      (CodegenEnv.codegen_env (* containing the program *)
       ) =
  let le = LocationEnv.constructor_initial_location_env
             (Syntax.choose_contract contract_id contracts) in
  let ce = CodegenEnv.empty_env in
  (* implement some kind of fold function over the argument list
   * each step generates new (le,ce) *)
  let ce = copy_arguments_from_code_to_memory le ce
             (Syntax.choose_contract contract_id contracts) in
  (* stack: [arg_mem_size, arg_mem_begin] *)
  let (ce: CodegenEnv.codegen_env) = copy_arguments_from_memory_to_storage le ce contract_id in
  let ce = set_contract_id ce contract_id in
  (* stack: [] *)
  (* TODO: return the code as a return value *)
  let ce = copy_runtime_code_to_memory ce contracts contract_id in
  (* stack: [code_length, code_start_on_memory] *)
  let ce = CodegenEnv.append_instruction ce RETURN in
  ce

let codegen_runtime_bytecode
      (src : Syntax.typ Syntax.contract) :
        (CodegenEnv.codegen_env (* containing the program *)
         * LocationEnv.location_env) = failwith "codegen_runtime_bytecode"

let runtime_initial_location_env
      (contract : Syntax.typ Syntax.contract) :
        LocationEnv.location_env =
  let _ = Ethereum.constructor_arguments contract in
  failwith "runtime_initial_location_env"
