open PseudoImm
open CodegenEnv
open Evm
open Syntax

let copy_storage_range_to_stack_top le ce (range : PseudoImm.pseudo_imm Location.storage_range) =
  let () = assert (PseudoImm.is_constant_int 1 range.Location.storage_size) in
  let offset : PseudoImm.pseudo_imm = range.Location.storage_start in
  let ce = append_instruction ce (PUSH32 offset) in
  let ce = append_instruction ce SLOAD in
  (le, ce)

let copy_stack_to_stack_top le ce (s : int) =
  let original_stack_size = stack_size ce in
  let diff = original_stack_size - s in
  let () = assert (diff >= 0) in
  let ce = append_instruction ce (Evm.dup_suc_n diff) in
  let () = assert (stack_size ce = original_stack_size + 1) in
  le, ce

let append_label ce label =
  append_instruction ce (PUSH4 (DestLabel label))

let shift_stack_top_to_right ce bits =
  let () = assert (bits >= 0) in
  let () = assert (bits < 256) in
  if bits = 0 then ce
  else
    (* [x] *)
    let ce = append_instruction ce (PUSH1 (Int bits)) in
    (* [x, bits] *)
    let ce = append_instruction ce (PUSH1 (Int 2)) in
    (* [x, bits, 2] *)
    let ce = append_instruction ce EXP in
    (* [x, 2 ** bits] *)
    let ce = append_instruction ce SWAP1 in
    (* [2 ** bits, x] *)
    let ce = append_instruction ce DIV in
    (* [x / (2 ** bits)] *)
    ce

let shift_stack_top_to_left ce bits =
  let () = assert (bits >= 0) in
  let () = assert (bits < 256) in
  if bits = 0 then ce
  else
    (* [x] *)
    let ce = append_instruction ce (PUSH1 (Int bits)) in
    (* [x, bits] *)
    let ce = append_instruction ce (PUSH1 (Int 2)) in
    (* [x, bits, 2] *)
    let ce = append_instruction ce EXP in
    (* [x, 2 ** bits] *)
    let ce = append_instruction ce MUL in
    (* [(2 ** bits) * x] *)
    ce

let copy_calldata_to_stack_top le ce (range : Location.calldata_range) =
  let () = assert (range.Location.calldata_size > 0) in
  let () = assert (range.Location.calldata_size <= 32) in
  let ce = append_instruction ce (PUSH4 (Int range.Location.calldata_offset)) in
  let ce = append_instruction ce CALLDATALOAD in
  let ce = shift_stack_top_to_right ce ((32 - range.Location.calldata_size) * 8) in
  le, ce

type alignment = LeftAligned | RightAligned

let align_boolean ce alignment =
  let () = assert (alignment = RightAligned) in
  ce

let align_address ce alignment =
  match alignment with RightAligned -> ce
                     | LeftAligned ->
                        shift_stack_top_to_left ce (12 * 8)


let align_from_right_aligned (ce : CodegenEnv.t) alignment typ =
  match alignment with
  | RightAligned -> ce
  | LeftAligned ->
     let size = size_of_typ typ in
     let () = assert (size <= 32) in
     if size = 32 then
       ce
     else
       let shift = (32 - size) * 8 in
       let ce = append_instruction ce (PUSH1 (Int shift)) in
       (* stack: [shift] *)
       let ce = append_instruction ce (PUSH1 (Int 2)) in
       (* stack: [shift, 2] *)
       let ce = append_instruction ce EXP in
       (* stack: [2 ** shift] *)
       let ce = append_instruction ce MUL in
       ce


let copy_to_stack_top le ce alignment typ (l : Location.location) =
  let le, ce =
    Location.(
      match l with
      | Storage range ->
         copy_storage_range_to_stack_top le ce range
      | CachedStorage _ -> failwith "copy_to_stack_top: CachedStorage"
      | Volatile _ -> failwith "copy_to_stack_top: Volatile"
      | Code _ -> failwith "copy_to_stack_top: Code"
      | Calldata range -> copy_calldata_to_stack_top le ce range
      | Stack s ->
         copy_stack_to_stack_top le ce s
    ) in
  let ce = align_from_right_aligned ce alignment typ in
  (* le needs to remember the alignment *)
  le, ce

let swap_entrance_pc_with_zero ce =
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  let ce = append_instruction ce SLOAD in
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  let ce = append_instruction ce DUP1 in
  let ce = append_instruction ce SSTORE in
  ce

(** [restore_entrance_pc] moves the topmost stack element to the entrance pc *)
let restore_entrance_pc ce =
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  let ce = append_instruction ce SSTORE in
  ce

(** [throw_if_zero] peeks the topmost stack element and throws if it's zero *)
let throw_if_zero ce =
  let ce = append_instruction ce DUP1 in
  let ce = append_instruction ce ISZERO in
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  let ce = append_instruction ce JUMPI in
  ce

(** [push_allocated_memory] behaves like an instruction
 * that takes a desired memory size as an argument.
 * This pushes the allocated address.
 *)
let push_allocated_memory (ce : CodegenEnv.t) =
  let original_stack_size = stack_size ce in
  (* [desired_length] *)
  let ce = append_instruction ce (PUSH1 (Int 64)) in
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

let peek_next_memory_allocation (ce : CodegenEnv.t) =
  let original_stack_size = stack_size ce in
  (* [] *)
  let ce = append_instruction ce (PUSH1 (Int 64)) in
  let ce = append_instruction ce MLOAD in
  let () = assert (stack_size ce = 1 + original_stack_size) in
  ce

(** [Tight] just uses [size_of_typ] bytes on the memory.
 *  [ABI] always uses multiples of 32 bytes.
 *  These choices do not affect the alighments
 *)
type memoryPacking = TightPacking | ABIPacking

let copy_from_code_to_memory ce =
  (* stack: [codesize, codeoffset] *)
  let ce = append_instruction ce DUP2 in
  (* stack: [codesize, codeoffset, codesize] *)
  let ce = push_allocated_memory ce in
  (* stack: [codesize, codeoffset, memory_address] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [codesize, memory_address, codeoffset] *)
  let ce = append_instruction ce DUP3 in
  (* stack: [codesize, memory_address, codeoffset, codesize] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [codesize, memory_address, codesize, codeoffset] *)
  let ce = append_instruction ce DUP3 in
  (* stack: [codesize, memory_address, codesize, codeoffset, memory_address] *)
  let ce = append_instruction ce CODECOPY in
  (* stack: [codesize, memory_address] *)
  ce

(** [copy_whole_current_code_to_memory] allocates enough memory to accomodate the
 *  whole of the currently running code, and copies it there.
 *  After this, [size, offset] of the memory region is left on the stack.
 *)
let copy_whole_current_code_to_memory ce =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce CODESIZE in
  (* stack: [size] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [size, size] *)
  let ce = push_allocated_memory ce in
  (* stack: [size, offset] *)
  let ce = append_instruction ce DUP2 in
  (* stack: [size, offset, codesize] *)
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  (* stack: [size, offset, codesize, 0] *)
  let ce = append_instruction ce DUP3 in
  (* stack: [size, offset, codesize, 0, offset] *)
  let ce = append_instruction ce CODECOPY in
  (* stack: [size, offset] *)
  let () = assert(original_stack_size + 2 = stack_size ce) in
  ce

let push_signature_code (ce : CodegenEnv.t)
                        (case_signature : usual_case_header)
  =
  let hash = Ethereum.case_header_signature_hash case_signature in
  let ce = append_instruction ce (PUSH4 (Big (Ethereum.hex_to_big_int hash))) in
  ce

(** [prepare_functiohn_signature ce usual_header]
 *  Allocates 4 bytes on the memory, and puts the function signature of the argument there.
 *  After that, the stack has (..., signature size, signature offset )
 *)
let prepare_function_signature ce usual_header =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH1 (Int 4)) in
  (* stack : (..., 4) *)
  let ce = append_instruction ce DUP1 in
  (* stack : (..., 4, 4) *)
  let ce = push_allocated_memory ce in
  (* stack : (..., 4, signature_offset) *)
  let ce = push_signature_code ce usual_header in
  (* stack : (..., 4, signature_offset, sig) *)
  let ce = append_instruction ce DUP2 in
  (* stack : (..., 4, signature_offset, sig, signature_offset) *)
  let ce = append_instruction ce MSTORE in
  (* stack : (..., 4, signature_offset) *)
  let () = assert (stack_size ce = original_stack_size + 2) in
  ce

let keccak_cons le ce =
  let original_stack_size = stack_size ce in
  (* put the top into 0x00 *)
  let ce = append_instruction ce (PUSH1 (Int 0x0)) in
  let ce = append_instruction ce MSTORE in
  (* put the top into 0x20 *)
  let ce = append_instruction ce (PUSH1 (Int 0x20)) in
  let ce = append_instruction ce MSTORE in
  (* take the sah3 of 0x00--0x40 *)
  let ce = append_instruction ce (PUSH1 (Int 0x40)) in
  let ce = append_instruction ce (PUSH1 (Int 0x0)) in
  let ce = append_instruction ce SHA3 in
  let () = assert (stack_size ce + 1 = original_stack_size) in
  ce

let increase_top ce (inc : int) =
  let ce = append_instruction ce (PUSH32 (Int inc)) in
  let ce = append_instruction ce ADD in
  ce

(** [add_constructor_argument_to_memory ce arg] realizes [arg] on the memory
 *  according to the ABI.  This increases the stack top element by the size of the
 *  new allocation. *)
let rec add_constructor_argument_to_memory le (packing : memoryPacking) ce (arg : Syntax.typ exp) =
  let () = Printf.printf "it's about appending type %s\n" (Syntax.string_of_typ (snd arg)) in
  let original_stack_size = stack_size ce in
  let typ = snd arg in
  let () = assert (Syntax.fits_in_one_storage_slot typ) in
  (* stack : [acc] *)
  let ce = append_instruction ce (PUSH1 (Int
                                           (match packing with
                                           | ABIPacking -> 32
                                           | TightPacking -> Syntax.size_of_typ typ))) in
  (* stack : [acc, size] *)
  let ce = append_instruction ce DUP1 in
  (* stack : [acc, size, size] *)
  let ce = push_allocated_memory ce in
  (* stack : [acc, size, offset] *)
  let ce = codegen_exp le ce (match packing with
                                  | ABIPacking -> RightAligned
                                  | TightPacking -> LeftAligned
                                 ) arg in
  (* stack : [acc, size, offset, val] *)
  let ce = append_instruction ce SWAP1 in
  (* stack : [acc, size, val, offset] *)
  let ce = append_instruction ce MSTORE in
  (* stack : [acc, size] *)
  let ce = append_instruction ce ADD in
  let () = assert (stack_size ce = original_stack_size) in
  ce
(** [add_constructor_arguments_to_memory args] realizes [args] on the memory
 *  according to the ABI.  This leaves the amount of memory on the stack.
 *  Usually this function is called right after the constructor code is set up in the memory,
 *  so the offset of the memory is not returned.
 *  (This makes it easy for the zero-argument case)
 *)
and add_constructor_arguments_to_memory le (packing : memoryPacking) ce (args : Syntax.typ exp list) =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  (* stack [0] *)
  let ce = List.fold_left (add_constructor_argument_to_memory le packing)
                          ce args in
  let () = assert (original_stack_size + 1 = stack_size ce) in
  ce
and produce_init_code_in_memory (le : LocationEnv.t) ce new_exp =
  let name = new_exp.new_head in
  let contract_id =
    try CodegenEnv.cid_lookup ce name
    with Not_found ->
      let () = Printf.eprintf "A contract of name %s is unknown.\n%!" name in
      raise Not_found
  in
  let ce = append_instruction ce (PUSH32 (ConstructorCodeSize contract_id)) in
  let ce = append_instruction ce (PUSH32 (ConstructorInRuntimeCodeOffset contract_id)) in
  (* stack: [codesize, codeoffset] *)
  let ce = copy_from_code_to_memory ce in
  (* stack: [memory_size, memory_offset] *)
  let ce = copy_whole_current_code_to_memory ce in
  (* stack: [memory_size, memory_offset, memory_second_size, memory_second_offset] *)

  (* I still need to add the constructor arguments *)
  let ce = add_constructor_arguments_to_memory le ABIPacking ce new_exp.new_args in
  (* stack: [memory_size, memory_offset, memory_second_size, memory_second_offset, memory_args_size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [memory_size, memory_offset, memory_second_size, memory_args_size, memory_second_offset] *)
  let ce = append_instruction ce POP in
  (* stack: [memory_size, memory_offset, memory_second_size, memory_args_size] *)
  let ce = append_instruction ce ADD in
  (* stack: [memory_size, memory_offset, memory_second_args_size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [memory_size, memory_second_args_size, memory_offset] *)
  let ce = append_instruction ce SWAP2 in
  (* stack: [memory_offset, memory_second_args_size, memory_size] *)
  let ce = append_instruction ce ADD in
  (* stack: [memory_offset, memory_total_size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [memory_total_size, memory_offset] *)
  ce
and codegen_function_call_exp (le : LocationEnv.t) ce alignment (function_call : Syntax.typ Syntax.function_call) (rettyp : Syntax.typ) =
  if function_call.call_head = "pre_ecdsarecover" then
    let () = assert (alignment = RightAligned) in
    codegen_ecdsarecover le ce function_call.call_args rettyp (* XXX: need to pass alignment *)
  else if function_call.call_head = "keccak256" then
    let () = assert (alignment = RightAligned) in
    codegen_keccak256 le ce function_call.call_args rettyp (* XXX: need to pass alignment *)
  else if function_call.call_head = "iszero" then
    codegen_iszero le ce alignment function_call.call_args rettyp
  else
    failwith "codegen_function_call_exp: unknown function head."
and codegen_iszero le ce alignment args rettype =
  match args with
  | [arg] ->
     let () = assert (rettype = BoolType) in
     let ce = codegen_exp le ce alignment arg in
     let ce = append_instruction ce ISZERO in
     ce
  | _ ->
     failwith "codegen_iszero: seeing a wrong number of arguments"
and codegen_keccak256 le ce args rettyp =
  let original_stack_size = stack_size ce in
  let ce = peek_next_memory_allocation ce in
  (* stack: [..., offset] *)
  let ce = add_constructor_arguments_to_memory le TightPacking ce args in
  (* stack: [..., offset, size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack: [..., size, offset] *)
  let ce = append_instruction ce SHA3 in
  let () = assert(stack_size ce = original_stack_size + 1) in
  ce
and codegen_ecdsarecover le ce args rettyp =
  match args with
  | [h; v; r; s] ->
     (* stack: [] *)
     let original_stack_size = stack_size ce in
     let ce = append_instruction ce (PUSH1 (Int 32)) in
     (* stack: [out size] *)
     let ce = append_instruction ce DUP1 in
     (* stack: [out size, out size] *)
     let ce = push_allocated_memory ce in
     (* stack: [out size, out address] *)
     let ce = append_instruction ce DUP2 in
     (* stack: [out size, out address, out size] *)
     let ce = append_instruction ce DUP2 in
     (* stack: [out size, out address, out size, out address] *)
     let ce = peek_next_memory_allocation ce in
     let ce = add_constructor_arguments_to_memory le ABIPacking ce args in
     (* stack: [out size, out address, out size, out address, memory_offset, memory_total_size] *)
     let ce = append_instruction ce SWAP1 in
     (* stack: [out size, out address, out size, out address, in size, in offset] *)
     let ce = append_instruction ce (PUSH1 (Int 0)) in
     (* stack: [out size, out address, out size, out address, in size, in offset, value] *)
     let () = assert (stack_size ce = original_stack_size + 7) in
     let ce = append_instruction ce (PUSH1 (Int 1)) in
     (* stack: [out size, out address, out size, out address, in size, in offset, value, to] *)
     let ce = append_instruction ce (PUSH4 (Int 10000)) in
     (* stack: [out size, out address, out size, out offset, in size, in offset, value, to, gas] *)
     let ce = append_instruction ce CALL in
     let () = assert (stack_size ce = original_stack_size + 3) in
     (* stack: [out size, out address, success?] *)
     let ce = throw_if_zero ce in
     let ce = append_instruction ce POP in
     (* stack: [out size, out address] *)
     let () = assert (stack_size ce = original_stack_size + 2) in
     let ce = append_instruction ce SWAP1 in
     (* stack: [out address, out size] *)
     let ce = append_instruction ce POP in (* we know it's 32 *)
     (* stack: [out address] *)
     let ce = append_instruction ce MLOAD in
     let () = assert (stack_size ce = original_stack_size + 1) in
     (* stack: [output] *)
     ce
  | _ -> failwith "pre_ecdsarecover has a wrong number of arguments"
and codegen_new_exp (le : LocationEnv.t) ce (new_exp : Syntax.typ Syntax.new_exp) (contractname : string) =
  let original_stack_size = stack_size ce in
  (* assert that the reentrance info is throw *)
  let () = assert(is_throw_only new_exp.new_msg_info.message_reentrance_info)  in
  (* set up the reentrance guard *)
  let ce = swap_entrance_pc_with_zero ce in
  (* stack : [entrance_pc_bkp] *)
  let ce = produce_init_code_in_memory le ce new_exp in
  (* stack : [entrance_pc_bkp, size, offset] *)
  let ce =
    (match new_exp.new_msg_info.message_value_info with
     | None -> append_instruction ce (PUSH1 (Int 0)) (* no value info means value of zero *)
     | Some e -> codegen_exp le ce RightAligned e) in
  (* stack : [entrance_pc_bkp, size, offset, value] *)
  let ce = append_instruction ce CREATE in
  (* stack : [entrance_pc_bkp, create_result] *)
  (* check the return value, if zero, throw *)
  let ce = throw_if_zero ce in
  (* stack : [entrance_pc_bkp, create_result] *)
  let ce = append_instruction ce SWAP1 in
  (* stack : [create_result, entrance_pc_bkp] *)
  (* remove the reentrance guard *)
  let ce = restore_entrance_pc ce in
  (* stack : [create_result] *)
  let () = assert (stack_size ce = original_stack_size + 1) in
  ce

and generate_array_access_index le ce aa =
  let array = aa.array_access_array in
  let index = aa.array_access_index in
  let ce = codegen_exp le ce RightAligned index in
  let ce = codegen_exp le ce RightAligned array in
  let ce = keccak_cons le ce in
  ce

and codegen_array_access (le : LocationEnv.t) ce (aa : Syntax.typ Syntax.array_access) =
  let ce = generate_array_access_index le ce aa in
  let ce = append_instruction ce SLOAD in
  ce

(* if the stack top is zero, set up an array seed at aa, and replace the zero with the new seed *)
and setup_array_seed_at_array_access le ce aa =
  let shortcut_label = Label.new_label () in
  (* stack: [result, result] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [result, result] *)
  let ce = append_label ce shortcut_label in
  (* stack: [result, result, shortcut] *)
  let ce = append_instruction ce JUMPI in
  (* stack: [result] *)
  let ce = append_instruction ce POP in
  (* stack: [] *)
  let ce = generate_array_access_index le ce aa in
  (* stack: [storage_index] *)
  let ce = append_instruction ce (PUSH1 (Int 1)) in
  (* stack: [storage_index, 1] *)
  let ce = append_instruction ce SLOAD in
  (* stack: [storage_index, orig_seed] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [storage_index, orig_seed, orig_seed] *)
  let ce = increase_top ce 1 in
  (* stack: [storage_index, orig_seed, orig_seed + 1] *)
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 1)) in
  (* stack: [storage_index, orig_seed, orig_seed + 1, 1] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [storage_index, orig_seed] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [storage_index, orig_seed, orig_seed] *)
  let ce = append_instruction ce SWAP2 in
  (* stack: [orig_seed, orig_seed, storage_index] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [orig_seed] *)
  let ce = append_instruction ce (JUMPDEST shortcut_label) in
  (* stack: [result] *)
  ce

(* if the stack top is zero, set up an array seed at aa, and replace the zero with the new seed *)
and setup_array_seed_at_location le ce loc =
  let storage_idx =
    match loc with
    | Location.Storage str_range ->
       let () = assert (str_range.Location.storage_size = (Int 1)) in
       str_range.Location.storage_start
    | _ -> failwith "setup array seed at non-storage" in
  let shortcut_label = Label.new_label () in
  (* stack: [result, result] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [result, result] *)
  let ce = append_instruction ce (PUSH32 (DestLabel shortcut_label)) in
  (* stack: [result, result, shortcut] *)
  let ce = append_instruction ce JUMPI in
  (* stack: [result] *)
  let ce = append_instruction ce POP in
  (* stack: [] *)
  let ce = append_instruction ce (PUSH32 storage_idx) in
  (* stack: [storage_index] *)
  let ce = append_instruction ce (PUSH1 (Int 1)) in
  (* stack: [storage_index, 1] *)
  let ce = append_instruction ce SLOAD in
  (* stack: [storage_index, orig_seed] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [storage_index, orig_seed, orig_seed] *)
  let ce = increase_top ce 1 in
  (* stack: [storage_index, orig_seed, orig_seed + 1] *)
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 1)) in
  (* stack: [storage_index, orig_seed, orig_seed + 1, 1] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [storage_index, orig_seed] *)
  let ce = append_instruction ce DUP1 in
  (* stack: [storage_index, orig_seed, orig_seed] *)
  let ce = append_instruction ce SWAP2 in
  (* stack: [orig_seed, orig_seed, storage_index] *)
  let ce = append_instruction ce SSTORE in
  (* stack: [orig_seed] *)
  let ce = append_instruction ce (JUMPDEST shortcut_label) in
  (* stack: [result] *)
  ce

(* le is not updated here.  It can be only updated in
 * a variable initialization *)
and codegen_exp
      (le : LocationEnv.t)
      (ce : CodegenEnv.t)
      (alignment : alignment)
      ((e,t) : Syntax.typ Syntax.exp) :
      CodegenEnv.t =
  let ret =
  Syntax.
  (match e,t with
   | AddressExp ((c, ContractInstanceType _)as inner), AddressType ->
      let ce = codegen_exp le ce alignment inner in
      (* c is a contract instance.
       * The concrete representation of a contact instance is
       * already the address
       *)
      ce
   | AddressExp _, _ ->
      failwith "codegen_exp: AddressExp of unexpected type"
   | ValueExp,Uint256Type ->
      let ce = CodegenEnv.append_instruction ce CALLVALUE in
      ce
   | ValueExp,_ -> failwith "ValueExp of strange type"
   | SenderExp,AddressType ->
      let ce = CodegenEnv.append_instruction ce CALLER in
      let ce = align_address ce alignment in
      ce
   | SenderExp,_ -> failwith "codegen_exp: SenderExp of strange type"
   | ArrayAccessExp aa, typ ->
      let ce = codegen_array_access le ce (read_array_access aa) in
      let () = assert (alignment = RightAligned) in
      begin match typ with
      | MappingType _ ->
         setup_array_seed_at_array_access le ce (read_array_access aa)
      | _ -> ce
      end
   | ThisExp,_ ->
      let ce = CodegenEnv.append_instruction ce ADDRESS in
      let ce = align_address ce alignment in
      ce
   | IdentifierExp id, typ ->
      begin match LocationEnv.lookup le id with
      (** if things are just DUP'ed, location env should not be
       * updated.  If they are SLOADED, the location env should be
       * updated. *)
      | Some location ->
         let (le, ce) = copy_to_stack_top le ce alignment typ location in
         begin match typ with
         | MappingType _ ->
            setup_array_seed_at_location le ce location
         | _ -> ce
         end
      | None ->
         failwith ("codegen_exp: identifier's location not found: "^id)
      end
  | FalseExp,BoolType ->
     let ce = CodegenEnv.append_instruction
                ce (Evm.PUSH1 (Big Big_int.zero_big_int)) in
     let () = assert (alignment = RightAligned) in
     ce
  | FalseExp, _ -> failwith "codegen_exp: FalseExp of unexpected type"
  | TrueExp,BoolType ->
     let ce = append_instruction ce (PUSH1 (Big Big_int.unit_big_int)) in
     let () = assert (alignment = RightAligned) in
     ce
  | TrueExp, _ -> failwith "codegen_exp: TrueExp of unexpected type"
  | DecLit256Exp d, Uint256Type ->
     let ce = append_instruction ce (PUSH32 (Big d)) in
     let () = assert (alignment = RightAligned) in
     ce
  | DecLit256Exp d, _ ->
      failwith ("codegen_exp: DecLit256Exp of unexpected type: "^(Big_int.string_of_big_int d))
  | DecLit8Exp d, Uint8Type ->
     let ce = append_instruction ce (PUSH1 (Big d)) in
     let () = assert (alignment = RightAligned) in
     ce
  | DecLit8Exp d, _ ->
      failwith ("codegen_exp: DecLit8Exp of unexpected type: "^(Big_int.string_of_big_int d))
  | LandExp (l, r), BoolType ->
     let shortcut_label = Label.new_label () in
     let () = assert (alignment = RightAligned) in
     let ce = codegen_exp le ce RightAligned l in
     (* stack: [..., l] *)
     let ce = append_instruction ce DUP1 in
     (* stack: [..., l, l] *)
     let ce = append_instruction ce ISZERO in
     (* stack: [..., l, !l] *)
     let ce = append_label ce shortcut_label in
     (* stack: [..., l, !l, shortcut] *)
     let ce = append_instruction ce JUMPI in
     (* stack: [..., l] *)
     let ce = append_instruction ce POP in
     (* stack: [...] *)
     let ce = codegen_exp le ce RightAligned r in
     (* stack: [..., r] *)
     let ce = append_instruction ce (JUMPDEST shortcut_label) in
     let ce = append_instruction ce ISZERO in
     let ce = append_instruction ce ISZERO in
     ce
  | LandExp (_, _), _ ->
     failwith "codegen_exp: LandExp of unexpected type"
  | NotExp sub, BoolType ->
     let ce = codegen_exp le ce alignment sub in
     let ce = append_instruction ce ISZERO in
     let ce = align_boolean ce alignment in
     ce
  | NotExp sub, _ ->
     failwith "codegen_exp: NotExp of unexpected type"
  | NowExp,Uint256Type ->
     append_instruction ce TIMESTAMP
  | NowExp,_ -> failwith "codegen_exp: NowExp of unexpected type"
  | NeqExp (l, r), BoolType ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in (* l later because it should come at the top *)
     let ce = append_instruction ce EQ in
     let ce = append_instruction ce ISZERO in
     let ce = align_boolean ce alignment in
     ce
  | NeqExp _, _ ->
     failwith "codegen_exp: NeqExp of unexpected type"
  | LtExp (l, r), BoolType ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce LT in
     let ce = align_boolean ce alignment in
     ce
  | LtExp _, _ -> failwith "codegen_exp: LtExp of unexpected type"
  | PlusExp (l, r), Uint256Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce ADD in
     ce
  | PlusExp (l, r), Uint8Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce ADD in
     ce
  | PlusExp (l, r), _ ->
     failwith "codegen_exp PlusExp of unexpected type"
  | MinusExp (l, r), Uint256Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce SUB in
     ce
  | MinusExp (l, r), Uint8Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce SUB in
     ce
  | MinusExp (l, r), _ ->
     failwith "codegen_exp MinusExp of unexpected type"
  | MultExp (l, r), Uint256Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce MUL in
     ce
  | MultExp (l, r), Uint8Type ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce MUL in
     ce
  | MultExp (l, r), _ ->
     failwith "codegen_exp: MultExp of unexpected type"
  | GtExp (l, r), BoolType ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce GT in
     let ce = align_boolean ce alignment in (* XXX there should be some type system making sure this line exists *)
     ce
  | GtExp _, _ -> failwith "codegen_exp GtExp of unexpected type"
  | BalanceExp inner, Uint256Type ->
     let ce = codegen_exp le ce RightAligned inner in
     let ce = append_instruction ce BALANCE in
     ce
  | BalanceExp inner, _ ->
     failwith "codegen_exp: BalanceExp of unexpected type"
  | EqualityExp (l, r), BoolType ->
     let ce = codegen_exp le ce RightAligned r in
     let ce = codegen_exp le ce RightAligned l in
     let ce = append_instruction ce EQ in
     let ce = align_boolean ce alignment in
     ce
  | EqualityExp _, _ ->
     failwith "codegen_exp EqualityExp of unexpected type"
  | SendExp s, _ ->
     let () = assert (alignment = RightAligned) in
     codegen_send_exp le ce s
  | NewExp new_e, ContractInstanceType ctyp ->
     let () = assert (alignment = RightAligned) in
     codegen_new_exp le ce new_e ctyp
  | NewExp new_e, _ ->
     failwith "exp code gen for new expression with unexpected type"
  | FunctionCallExp function_call, rettyp ->
     codegen_function_call_exp le ce alignment function_call rettyp
  | ParenthExp _, _ ->
     failwith "ParenthExp not expected."
  | SingleDereferenceExp (reference, ref_typ), value_typ ->
     let () = assert (ref_typ = ReferenceType [value_typ]) in
     let size = Syntax.size_of_typ value_typ in
     let () = assert (size <= 32) in (* assuming word-size *)
     let ce = codegen_exp le ce RightAligned (reference, ref_typ) in (* pushes the pointer *)
     let ce = append_instruction ce MLOAD in
     let () = assert (alignment = RightAligned) in
     ce
  | TupleDereferenceExp _, _ ->
     failwith "code generation for TupleDereferenceExp should not happen.  Instead, try to decompose it into several assignments."
  ) in
  let () = assert (stack_size ret = stack_size ce + 1) in
  ret
(** [prepare_argument ce arg] places an argument in the memory, and increments the stack top position by the size of the argument. *)
and prepare_argument le ce arg =
  (* stack: (..., accum) *)
  let original_stack_size = stack_size ce in
  let size = Syntax.size_of_typ (snd arg) in
  let () = assert (size = 32) in
  let ce = append_instruction ce (PUSH1 (Int size)) in
  (* stack: (..., accum, size) *)
  let ce = codegen_exp le ce RightAligned arg in
  (* stack: (..., accum, size, val) *)
  let ce = append_instruction ce DUP2 in
  (* stack: (..., accum, size, val, size) *)
  let ce = push_allocated_memory ce in
  (* stack: (..., accum, size, val, offset) *)
  let ce = append_instruction ce MSTORE in
  (* stack: (..., accum, size) *)
  let ce = append_instruction ce ADD in
  (* stack: (..., new_accum) *)
  let () = assert (stack_size ce = original_stack_size) in
  ce
(** [prepare_arguments] prepares arguments in the memory.
 *  This leaves (..., args size) on the stack.
 *  Since this is called always immediately after allocating memory for the signature,
 *  the offset of the memory is not necessary.
 *  Also, when there are zero amount of memory desired, it's easy to just return zero.
 *)
and prepare_arguments le ce args =
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  let ce = List.fold_left
             (prepare_argument le) ce args in
  let () = assert (stack_size ce = original_stack_size + 1) in
  ce
(** [prepare_input_in_memory] prepares the input for CALL instruction in the memory.
 *  That leaves "..., in size, in offset" (top) on the stack.
 *)
and prepare_input_in_memory le ce s usual_header : CodegenEnv.t =
  let original_stack_size = stack_size ce in
  let ce = prepare_function_signature ce usual_header in
  (* stack : [signature size, signature offset] *)
  let args = s.send_args in
  let ce = prepare_arguments le ce args in (* this should leave only one number on the stack!! *)
  (* stack : [signature size, signature offset, args size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack : [signature size, args size, signature offset] *)
  let ce = append_instruction ce SWAP2 in
  (* stack : [signature offset, args size, signature size] *)
  let ce = append_instruction ce ADD in
  (* stack : [signature offset, total size] *)
  let ce = append_instruction ce SWAP1 in
  (* stack : [total size, signature offset] *)
  let () = assert (stack_size ce = original_stack_size + 2) in
  ce
(** [obtain_return_values_from_memory] assumes stack (..., out size, out offset),
    and copies the outputs onto the stack.  The first comes top-most. *)
(* XXX currently supports one-word output only *)
and obtain_return_values_from_memory ce =
  (* stack: out size, out offset *)
  let ce = append_instruction ce DUP2 in
  (* stack: out size, out offset, out size *)
  let ce = append_instruction ce (PUSH1 (Int 32)) in
  (* stack: out size, out offset, out size, 32 *)
  let ce = append_instruction ce EQ in
  (* stack: out size, out offset, out size = 32 *)
  let ce = append_instruction ce ISZERO in
  (* stack: out size, out offset, out size != 32 *)
  let ce = append_instruction ce (PUSH1 (Int 0)) in
  (* stack: out size, out offset, out size != 32, 0 *)
  let ce = append_instruction ce JUMPI in
  (* stack: out size, out offset *)
  let ce = append_instruction ce MLOAD in
  (* stack: out size, out *)
  let ce = append_instruction ce SWAP1 in
  (* stack: out, out size *)
  let ce = append_instruction ce POP in
  (* stack: out *)
  ce
and codegen_send_exp le ce (s : Syntax.typ Syntax.send_exp) =
  let original_stack_size = stack_size ce in
  let head_contract = s.send_head_contract in
  match snd head_contract with
  | ContractInstanceType contract_name ->
     let callee_contract_id =
       try CodegenEnv.cid_lookup ce contract_name
       with Not_found ->
         let () = Printf.eprintf "A contract of name %s is unknown.\n%!" contract_name in
         raise Not_found
     in
     let callee_contract : Syntax.typ Syntax.contract =
       CodegenEnv.contract_lookup ce callee_contract_id in
     let contract_lookup_by_name (name : string) : Syntax.typ Syntax.contract =
       let contract_id =
         begin try
           CodegenEnv.cid_lookup ce name
         with Not_found ->
           let () = Printf.eprintf "A contract of name %s is unknown.\n%!" contract_name in
           raise Not_found
         end
       in
       CodegenEnv.contract_lookup ce contract_id in
     begin match s.send_head_method with
     | None -> failwith "could not find the method name"
     | Some method_name ->
        let usual_header : usual_case_header =
          Syntax.lookup_usual_case_header callee_contract method_name contract_lookup_by_name in
        let () = assert(is_throw_only s.send_msg_info.message_reentrance_info)  in
        let ce = swap_entrance_pc_with_zero ce in
        (* stack : [entrance_pc_bkp] *)
        let return_typ = usual_header.case_return_typ in
        let return_size = Syntax.size_of_typs return_typ in
        (* stack : [entrance_bkp] *)
        let ce = append_instruction ce (PUSH1 (Int return_size)) in
        (* stack : [entrance_bkp, out size] *)
        let ce = append_instruction ce DUP1 in
        (* stack : [entrance_bkp, out size, out size] *)
        let () = assert (stack_size ce = original_stack_size + 3) in
        let ce = push_allocated_memory ce in
        (* stack : [entrance_bkp, out size, out offset] *)
        let ce = append_instruction ce DUP2 in
        (* stack : [entrance_bkp, out size, out offset, out size] *)
        let ce = append_instruction ce DUP2 in
        (* stack : [entrance_bkp, out size, out offset, out size, out offset] *)
        let ce = prepare_input_in_memory le ce s usual_header in
        (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset] *)
        let ce =
          (match s.send_msg_info.message_value_info with
           | None -> append_instruction ce (PUSH1 (Int 0)) (* no value info means value of zero *)
           | Some e ->
              codegen_exp le ce RightAligned e) in
        (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset, value] *)
        let ce = codegen_exp le ce RightAligned s.send_head_contract in
        let ce = append_instruction ce (PUSH4 (Int 3000)) in
        let ce = append_instruction ce GAS in
        let ce = append_instruction ce SUB in
        (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset, value, to, gas] *)
        let ce = append_instruction ce CALL in
        (* stack : [entrance_bkp, out size, out offset, success] *)
        let () = assert (stack_size ce = original_stack_size + 4) in
        let ce = append_instruction ce ISZERO in
        let ce = append_instruction ce (PUSH1 (Int 0)) in
        let ce = append_instruction ce JUMPI in
        (* stack : [entrance_bkp, out size, out offset] *)
        let () = assert (stack_size ce = original_stack_size + 3) in
        let ce = append_instruction ce SWAP2 in
        (* stack : [out offset, out size entrance_bkp] *)
        let ce = restore_entrance_pc ce in
        (* stack : [out offset, out size] *)
        let ce = append_instruction ce SWAP1 in
        (* stack : [out size, out offset] *)
        let ce = obtain_return_values_from_memory ce in
        (* stack : [outputs] *)
        ce
     end
  | AddressType ->
     let () = assert(is_throw_only s.send_msg_info.message_reentrance_info)  in
     let ce = swap_entrance_pc_with_zero ce in
     (* stack : [entrance_pc_bkp] *)
     let return_size = 0 in
     (* stack : [entrance_bkp] *)
     let ce = append_instruction ce (PUSH1 (Int return_size)) in
     (* stack : [entrance_bkp, 0] *)
     let ce = append_instruction ce DUP1 in
     (* stack : [entrance_bkp, 0, 0] *)
     let () = assert (stack_size ce = original_stack_size + 3) in
     let ce = append_instruction ce DUP2 in
     (* stack : [entrance_bkp, 0, 0, 0] *)
     let ce = append_instruction ce DUP2 in
     (* stack : [entrance_bkp, 0, 0, 0, 0] *)
     let ce = append_instruction ce DUP2 in
     (* stack : [entrance_bkp, 0, 0, 0, 0, 0] *)
     let ce = append_instruction ce DUP2 in
     (* stack : [entrance_bkp, 0,        0,          0,        0,          0,       0] *)
     (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset] *)
     let ce =
       (match s.send_msg_info.message_value_info with
        | None -> append_instruction ce (PUSH1 (Int 0)) (* no value info means value of zero *)
        | Some e -> codegen_exp le ce RightAligned e) in
     (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset, value] *)
     let ce = codegen_exp le ce RightAligned s.send_head_contract in
     let ce = append_instruction ce (PUSH4 (Int 3000)) in
     let ce = append_instruction ce GAS in
     let ce = append_instruction ce SUB in
     (* stack : [entrance_bkp, out size, out offset, out size, out offset, in size, in offset, value, to, gas] *)
     let ce = append_instruction ce CALL in
     (* stack : [entrance_bkp, out size, out offset, success] *)
     let () = assert (stack_size ce = original_stack_size + 4) in
     let ce = append_instruction ce ISZERO in
     let ce = append_instruction ce (PUSH1 (Int 0)) in
     let ce = append_instruction ce JUMPI in
     (* stack : [entrance_bkp, out size, out offset] *)
     let () = assert (stack_size ce = original_stack_size + 3) in
     let ce = append_instruction ce SWAP2 in
     (* stack : [out offset, out size entrance_bkp] *)
     let ce = restore_entrance_pc ce in
     (* stack : [0, 0] *)
     let ce = append_instruction ce POP in (* XXX: Some optimizations possible. *)
     (* stack : [0] *)
     ce
  | VoidType -> failwith "send expression with VoidType?"
  | Uint256Type -> failwith "send expression with Uint256Type?"
  | Uint8Type -> failwith "send expression with Uint8Type?"
  | _ -> failwith "send expression with unknown type"


let codegen_sentence
  (orig : CodegenEnv.t)
  (s : Syntax.typ Syntax.sentence)
  (* is this enough? also add sentence Id's around?
   * I think this is enough.
   *)
  : CodegenEnv.t = failwith "codegen_sentence"

let move_info_around
  (assumption : CodegenEnv.t)
  (goal : LocationEnv.t) :
      CodegenEnv.t = failwith "move_info_around"

let codegen_bytecode
  (src : Syntax.typ Syntax.contract) :
      PseudoImm.pseudo_imm Evm.program = failwith "codegen_bytecode"

(** [initialize_memory_allocator] initializes memory position 64 as 96 *)
let initialize_memory_allocator (ce : CodegenEnv.t) =
  let ce = append_instruction ce (PUSH1 (Int 96)) in
  let ce = append_instruction ce (PUSH1 (Int 64)) in
  let ce = append_instruction ce MSTORE in
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
      (le : LocationEnv.t)
      (ce : CodegenEnv.t)
      (contract : Syntax.typ Syntax.contract) :
      (CodegenEnv.t) =
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
  let ce = append_label ce jump_label_exit in
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
  let ce = append_label ce jump_label_continue in
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
             ce (PUSH32 (InitDataSize contract_id)) in
  let ce = append_instruction ce CODESIZE in
  let ce = append_instruction ce EQ in
  let ce = append_instruction ce ISZERO in
  let ce = append_instruction ce (PUSH1 (Int 2)) in
  let ce = append_instruction ce JUMPI in
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
  let ce = append_instruction ce (PUSH32 (RuntimeCodeOffset contract_id)) in
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
  let jump_label_skip = Label.new_label () in
  let original_stack_size = stack_size ce in
  let ce = append_instruction ce (PUSH4 (PseudoImm.Int loc)) in
  (* stack: [seed] *)
  let ce = append_label ce jump_label_skip in
  let ce = append_instruction ce JUMPI in
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
  let ce = append_instruction ce (JUMPDEST jump_label_skip) in
  (* stack: [] *)
  let () = assert (stack_size ce = original_stack_size) in
  (le, ce)

let setup_array_seed_counter_to_one_if_not_initialized ce =
  let original_stack_size = stack_size ce in
  let jump_label_skip = Label.new_label () in
  let ce = append_instruction ce (PUSH1 (Int 1)) in
  let ce = append_instruction ce SLOAD in
  let ce = append_label ce jump_label_skip in
  let ce = append_instruction ce JUMPI in
  (* the case where it has to be changed *)
  let ce = append_instruction ce (PUSH1 (Int 1)) in
  let ce = append_instruction ce DUP1 in
  let ce = append_instruction ce SSTORE in
  let ce = append_instruction ce (JUMPDEST jump_label_skip) in
  let () = assert (stack_size ce = original_stack_size) in
  ce

let setup_array_seeds le ce (contract: Syntax.typ Syntax.contract) : CodegenEnv.t =
  let ce = setup_array_seed_counter_to_one_if_not_initialized ce in
  let array_locations = LayoutInfo.array_locations contract in
  let (_, ce) =
    List.fold_left setup_seed (le, ce) array_locations in
  ce

let codegen_constructor_bytecode
      ((contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc),
       (contract_id : Assoc.contract_id))
    :
      (CodegenEnv.t (* containing the program *)
       ) =
  let le = LocationEnv.constructor_initial_env contract_id
                                               (Assoc.choose_contract contract_id contracts) in
  let ce = CodegenEnv.empty_env (cid_lookup_in_assoc contracts) contracts in
  let ce = initialize_memory_allocator ce in
  (* implement some kind of fold function over the argument list
   * each step generates new (le,ce) *)
  let ce = copy_arguments_from_code_to_memory le ce
             (Assoc.choose_contract contract_id contracts) in
  (* stack: [arg_mem_size, arg_mem_begin] *)
  let (ce: CodegenEnv.t) = copy_arguments_from_memory_to_storage le ce contract_id in
  (* stack: [] *)
  (* set up array seeds *)
  let (ce :CodegenEnv.t) = setup_array_seeds le ce (Assoc.choose_contract contract_id contracts) in
  let ce = set_contract_pc ce contract_id in
  (* stack: [] *)
  let ce = copy_runtime_code_to_memory ce contracts contract_id in
  (* stack: [code_length, code_start_on_memory] *)
  let ce = CodegenEnv.append_instruction ce RETURN in
  ce

type constructor_compiled =
  { constructor_codegen_env : CodegenEnv.t
  ; constructor_interface : Contract.contract_interface
  ; constructor_contract : Syntax.typ Syntax.contract
  }

type runtime_compiled =
  { runtime_codegen_env : CodegenEnv.t
  ; runtime_contract_offsets : int Assoc.contract_id_assoc
  (* what form should the constructor code be encoded?
     1. pseudo program.  easy
     2. pseudo codegen_env.  maybe uniform
   *)
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
  Assoc.pair_map (fun cid _ -> compile_constructor (contracts, cid)) contracts

let initial_runtime_compiled (cid_lookup : string -> Assoc.contract_id) layouts : runtime_compiled =
  let ce = CodegenEnv.empty_env cid_lookup layouts in
  let ce = get_contract_pc ce in
  let ce = append_instruction ce JUMP in
  { runtime_codegen_env = ce
  ; runtime_contract_offsets = []
  }

let push_destination_for (ce : CodegenEnv.t)
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
  (le, List.fold_right (fun arg ce' -> codegen_exp le ce' RightAligned arg) args ce)

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
  let cid =
    try
      cid_lookup ce head
    with Not_found ->
      let () = Printf.eprintf "contract of name %s not found\n%!" head in
      raise Not_found
  in
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
  let () = assert (size_of_typ typ <= 32) in
  (* ..., value *)
  let ce = append_instruction ce (PUSH1 (PseudoImm.Int 32)) in
  (* ..., value, 32 *)
  let ce = append_instruction ce DUP1 in
  (* ..., value, 32, 32 *)
  let ce = push_allocated_memory ce in
  (* ..., value, 32, addr *)
  let ce = append_instruction ce SWAP2 in
  (* ..., addr, 32, value *)
  let ce = append_instruction ce DUP3 in
  (* ..., addr, 32, value, addr *)
  let ce = append_instruction ce MSTORE in
  (* ..., addr, 32 *)
  let ce = append_instruction ce SWAP1 in
  (* ..., 32, addr *)
  ce

(*
 * after this, the stack contains
 * ..., size, offset_in_memory
 *)
let place_exp_in_memory le ce packing ((e, typ) : typ exp) =
  let original_stack_size = stack_size ce in
  let alignment = match packing with
    | ABIPacking -> RightAligned
    | TightPacking -> LeftAligned in
  let ce = codegen_exp le ce alignment (e, typ) in
  let () = assert (stack_size ce = 1 + original_stack_size) in
  (* the stack layout depends on typ *)
  let ce = move_stack_top_to_memory typ le ce in
  let () = assert (stack_size ce = 2 + original_stack_size) in
  le, ce

(*
 * When called on [a, b, c], a shoud occupy the smallest address, and c should occupy the largest address.
 * after this, the stack contains
 * ..., size, offset_in_memory
 *)
let rec place_exps_in_memory le ce packing (exps : typ exp list) =
  match exps with
  | [] ->
     let ce = append_instruction ce (PUSH1 (Int 0)) in
     let ce = append_instruction ce (PUSH1 (Int 0)) in
     le, ce
  | exp :: rest ->
     let le, ce = place_exp_in_memory le ce packing exp in
     (* stack : [size, offset] *)
     let ce = append_instruction ce SWAP1 in
     (* stack : [offset, size] *)
     let le, ce = place_exps_in_memory le ce packing rest in (* this recursion is a bit awkward *)
     (* stack : [offset, size, size', offset] *)
     let ce = append_instruction ce POP in
     (* stack : [offset, size, size'] *)
     let ce = append_instruction ce ADD in
     (* stack : [offset, size_sum] *)
     let ce = append_instruction ce SWAP1 in
     (* stack : [size_sum, offset] *)
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
  let ce = match e with
    | Some e ->
       let (le, ce) = place_exp_in_memory le ce ABIPacking e in
       return_mem_content le ce
    | None ->
       append_instruction ce STOP
  in
  let () = assert (stack_size ce = original_stack_size) in
  (le, ce)

let put_stacktop_into_array_access le ce layout (aa : Syntax.typ Syntax.array_access) =
  let array = aa.Syntax.array_access_array in
  let index = aa.Syntax.array_access_index in
  let ce = codegen_exp le ce RightAligned index in
  (* stack : [value, index] *)
  let ce = codegen_exp le ce RightAligned array in



  (* stack : [value, index, array_seed] *)
  let ce = keccak_cons le ce in
  (* stack : [value, kec(array_seed ^ index)] *)
  let ce = append_instruction ce SSTORE in
  ce

let put_stacktop_into_lexp le ce layout l =
  let original_stack_size = stack_size ce in
  let ce =
    match l with
    | ArrayAccessLExp aa -> put_stacktop_into_array_access le ce layout aa
    in
  let () = assert (original_stack_size = stack_size ce + 1) in
  ce

let add_assignment le ce layout l r =
  let original_stack_size = stack_size ce in
  (* produce r on the stack and then think about where to put that *)
  let ce = codegen_exp le ce RightAligned r in
  let () = assert (1 + original_stack_size = stack_size ce) in
  let ce = put_stacktop_into_lexp le ce layout l in
  let () = assert (original_stack_size = stack_size ce) in
  (le, ce)

let push_event_signature ce event =
  let hash = Ethereum.event_signature_hash event in
  let ce = append_instruction ce (PUSH4 (Big (Ethereum.hex_to_big_int hash))) in
  ce

let add_variable_init le ce layout i =
  let position = stack_size ce in
  let ce = codegen_exp le ce RightAligned i.Syntax.variable_init_value in
  let name = i.Syntax.variable_init_name in
  let loc = Location.Stack (position + 1) in
  let le = LocationEnv.add_pair le name loc in
  (le, ce)

let rec add_if_single le ce (layout : LayoutInfo.layout_info) cond body =
  let jump_label_skip = Label.new_label () in
  let original_stack_size = stack_size ce in
  let ce = codegen_exp le ce RightAligned cond in
  let ce = append_instruction ce ISZERO in
  let ce = append_label ce jump_label_skip in
  let ce = append_instruction ce JUMPI in
  let le, ce = add_sentences le ce layout body in
  let ce = append_instruction ce (JUMPDEST jump_label_skip) in
  let () = assert (original_stack_size = stack_size ce) in
  (le, ce)
and add_if le ce (layout : LayoutInfo.layout_info) cond bodyT bodyF =
  let jump_label_false = Label.new_label () in
  let jump_label_end = Label.new_label () in
  let original_stack_size = stack_size ce in
  let ce = codegen_exp le ce RightAligned cond in
  let ce = append_instruction ce ISZERO in
  let ce = append_label ce jump_label_false in
  let ce = append_instruction ce JUMPI in
  let _, ce = add_sentences le ce layout bodyT in (* location env needs to be discarded *)
  let ce = append_label ce jump_label_end in
  let ce = append_instruction ce JUMP in
  let ce = append_instruction ce (JUMPDEST jump_label_false) in
  let _, ce = add_sentences le ce layout bodyF in (* location env needs to be discarded *)
  let ce = append_instruction ce (JUMPDEST jump_label_end) in
  let () = assert (original_stack_size = stack_size ce) in
  (le, ce)
and add_sentences le ce layout ss =
  List.fold_left (fun (le, ce) s -> add_sentence le ce layout s) (le, ce) ss
and add_sentence le ce (layout : LayoutInfo.layout_info) sent =
  match sent with
  | AbortSentence -> (le, add_throw ce)
  | ReturnSentence ret -> add_return le ce layout ret
  | AssignmentSentence (l, r) -> add_assignment le ce layout l r
  | VariableInitSentence i -> add_variable_init le ce layout i
  | IfThenOnly (cond, body) -> add_if_single le ce layout cond body (* this is a special case of the next *)
  | IfThenElse (cond, bodyT, bodyF) ->
     add_if le ce layout cond bodyT bodyF
  | SelfdestructSentence exp -> add_self_destruct le ce layout exp
  | ExpSentence exp -> add_exp_sentence le ce layout exp
  | LogSentence (name, args, Some event) -> add_log_sentence le ce layout name args event
  | LogSentence (name, args, None) -> failwith "add_sentence: type check first"
and add_log_sentence le ce layout name (args : Syntax.typ Syntax.exp list) event =
  let orig_stack_size = stack_size ce in
  (* get the indexed *)
  let (indexed_args, non_indexed_args) = Syntax.split_event_args event args in
  (* prepare indexed arguments on the stack *)
  let (le, ce) = prepare_words_on_stack le ce indexed_args in
  (* prepare the event signature on the stack *)
  let ce = push_event_signature ce event in
  (* prepare non-indexed arguments in the memory *)
  let (le, ce) = place_exps_in_memory le ce ABIPacking non_indexed_args in
  (* stack : [..., size, offset] *)
  let n = List.length indexed_args + 1 in
  let ce = append_instruction ce (log n) in
  (* decide N in logN *)
  let () = assert (stack_size ce = orig_stack_size) in
  le, ce
and add_exp_sentence le ce layout exp =
  let ce = codegen_exp le ce RightAligned exp in
  let ce = append_instruction ce POP in
  le, ce
and add_self_destruct le ce layout exp =
  let ce = codegen_exp le ce RightAligned exp in
  let ce = append_instruction ce SUICIDE in
  le, ce

let add_case_argument_locations (le : LocationEnv.t) (case : Syntax.typ Syntax.case) =
  let additions : (string * Location.location) list = Ethereum.arguments_with_locations case in
  let ret = LocationEnv.add_pairs le additions in
  ret

let calldatasize_of_usual_header us =
  let args = us.case_arguments in
  4 (* for signature *) +
    try BatList.sum (List.map (fun x -> Ethereum.(interface_typ_size (interpret_interface_type x.arg_typ))) args) with
      Invalid_argument _ -> 0

let add_case_argument_length_check ce case_header =
  match case_header with
  | DefaultCaseHeader -> (* no check, the choice is arguable *) ce
  | UsualCaseHeader us ->
     let ce = append_instruction ce (PUSH4 (Int (calldatasize_of_usual_header us))) in
     let ce = append_instruction ce CALLDATASIZE in
     let ce = append_instruction ce EQ in
     let ce = append_instruction ce ISZERO in
     let ce = append_instruction ce (PUSH1 (Int 0)) in
     let ce = append_instruction ce JUMPI in
     ce

let add_case (le : LocationEnv.t) (ce : CodegenEnv.t) layout (cid : Assoc.contract_id) (case : Syntax.typ Syntax.case) =
  let ce = add_case_destination ce cid case.case_header in
  let ce = add_case_argument_length_check ce case.case_header in
  let le = LocationEnv.add_empty_block le in
  let le = add_case_argument_locations le case in
  let ((le : LocationEnv.t), ce) =
    List.fold_left
      (fun ((le : LocationEnv.t), ce) sent -> add_sentence le ce layout sent)
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
  { runtime_codegen_env = codegen_append_contract_bytecode (LocationEnv.runtime_initial_env contract) prev.runtime_codegen_env layout (cid, contract)
  ; runtime_contract_offsets = Assoc.insert cid (CodegenEnv.code_length prev.runtime_codegen_env) prev.runtime_contract_offsets
  }

let compile_runtime layout (contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc)
    : runtime_compiled =
  List.fold_left (append_runtime layout) (initial_runtime_compiled (cid_lookup_in_assoc contracts) contracts) contracts

let layout_info_from_constructor_compiled (cc : constructor_compiled) : LayoutInfo.contract_layout_info =
  LayoutInfo.layout_info_of_contract cc.constructor_contract (CodegenEnv.ce_program cc.constructor_codegen_env)

let sizes_of_constructors (constructors : constructor_compiled Assoc.contract_id_assoc) : int list =
  let lengths = Assoc.map (fun cc -> CodegenEnv.code_length cc.constructor_codegen_env) constructors in
  let lengths = List.sort (fun a b -> compare (fst a) (fst b)) lengths in
  List.map snd lengths

let rec calculate_offsets_inner ret current lst =
  match lst with
  | [] -> List.rev ret
  | hd::tl ->
     (* XXX: fix the append *)
     calculate_offsets_inner (current :: ret) (current + hd) tl

let calculate_offsets initial lst =
  calculate_offsets_inner [] initial lst

let layout_info_from_runtime_compiled (rc : runtime_compiled) (constructors : constructor_compiled Assoc.contract_id_assoc) : LayoutInfo.runtime_layout_info =
  let sizes_of_constructors = sizes_of_constructors constructors in
  let offsets_of_constructors = calculate_offsets (CodegenEnv.code_length rc.runtime_codegen_env) sizes_of_constructors in
  let sum_of_constructor_sizes = BatList.sum sizes_of_constructors in
  LayoutInfo.(
    { runtime_code_size = sum_of_constructor_sizes + CodegenEnv.code_length rc.runtime_codegen_env
    ; runtime_offset_of_contract_id = rc.runtime_contract_offsets
    ; runtime_size_of_constructor = Assoc.list_to_contract_id_assoc sizes_of_constructors
    ; runtime_offset_of_constructor = Assoc.list_to_contract_id_assoc offsets_of_constructors
    })

let programs_concat_reverse_order (programs : 'imm Evm.program list) =
  let rev_programs = List.rev programs in
  List.concat rev_programs

(** constructors_packed concatenates constructor code.
 *  Since the code is stored in the reverse order, the concatenation is also reversed.
 *)
let constructors_packed layout (constructors : constructor_compiled Assoc.contract_id_assoc) =
  let programs = Assoc.map (fun cc -> CodegenEnv.ce_program cc.constructor_codegen_env) constructors in
  let programs = List.sort (fun a b -> compare (fst a) (fst b)) programs in
  let programs = List.map snd programs in
  programs_concat_reverse_order programs

let compose_bytecode (constructors : constructor_compiled Assoc.contract_id_assoc)
                     (runtime : runtime_compiled) (cid : Assoc.contract_id)
    : Big_int.big_int Evm.program =
  let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
    List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
  let runtime_layout = layout_info_from_runtime_compiled runtime constructors in
  let layout = LayoutInfo.construct_post_layout_info contracts_layout_info runtime_layout in
  let pseudo_constructor = Assoc.choose_contract cid constructors in
  let imm_constructor = LayoutInfo.realize_pseudo_program layout cid (CodegenEnv.ce_program pseudo_constructor.constructor_codegen_env) in
  let pseudo_runtime_core = CodegenEnv.ce_program runtime.runtime_codegen_env in
  (* XXX: This part is somehow not modular. *)
  (* Sicne the code is stored in the reverse order, the concatenation is also reversed. *)
  let imm_runtime = LayoutInfo.realize_pseudo_program layout cid ((constructors_packed layout constructors)@pseudo_runtime_core) in
  (* the code is stored in the reverse order *)
  imm_runtime@imm_constructor

let compose_runtime_bytecode (constructors : constructor_compiled Assoc.contract_id_assoc)
                     (runtime : runtime_compiled)
    : Big_int.big_int Evm.program =
  let contracts_layout_info : (Assoc.contract_id * LayoutInfo.contract_layout_info) list =
    List.map (fun (id, const) -> (id, layout_info_from_constructor_compiled const)) constructors in
  let runtime_layout = layout_info_from_runtime_compiled runtime constructors in
  let layout = LayoutInfo.construct_post_layout_info contracts_layout_info runtime_layout in
  (* TODO: 0 in the next line is a bit ugly. *)
  let imm_runtime = LayoutInfo.realize_pseudo_program layout 0 ((constructors_packed layout constructors)@(CodegenEnv.ce_program runtime.runtime_codegen_env)) in
  imm_runtime
