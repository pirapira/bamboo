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
    (* |dispatcher that jumps into the stored pc|runtime code for contract A|runtime code for contract B|runtime code for contract C|
       |constructor code for contract A|constructor code for contract B|constructor code for contract C|
     *)

  ; constructor_in_runtime_code_offset : int Assoc.contract_id_assoc

    (* And then, the runtime code for a particular contract is organized like this: *)
                                          (* |dispatcher that jumps into a case|runtime code for case f|runtime code for case g| *)
  ; l : layout_info
  }


(* [Storage layout for arrays]
 * For each array argument of a contract, the storage contains a seed.
 * array[x][y] would be stored at the location sha3(sha3(seed_of(array), x), y).
 * There needs to be utility funcitons for computing this hash value and using it.
 * I think this comment should split out into its own module.
 *)

val print_layout_info : layout_info -> unit

type contract_layout_info =
  { contract_constructor_code_size : int
  (** the number of bytes that the constructor code occupies *)
  ; contract_argument_size : int
  (** the number of words that the contract arguments occupy *)
  ; contract_num_array_seeds : int
  (** the number of arguments that are arrays; todo: remove and create a function if needed *)
  ; contract_args : Syntax.typ list
  (** the list of argument types *)
  }

val realize_pseudo_instruction :
  post_layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm Evm.instruction -> Big_int.big_int Evm.instruction

val realize_pseudo_program :
  post_layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm Evm.program -> Big_int.big_int Evm.program

val layout_info_of_contract : Syntax.typ Syntax.contract -> PseudoImm.pseudo_imm Evm.program (* constructor *) -> contract_layout_info

val realize_pseudo_imm : post_layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm -> Big_int.big_int

type runtime_layout_info =
  { runtime_code_size : int
  ; runtime_offset_of_contract_id : int Assoc.contract_id_assoc
  ; runtime_offset_of_constructor : int Assoc.contract_id_assoc
  ; runtime_size_of_constructor : int Assoc.contract_id_assoc
  }

val construct_layout_info : (Assoc.contract_id * contract_layout_info) list -> layout_info

val construct_post_layout_info : (Assoc.contract_id * contract_layout_info) list -> runtime_layout_info -> post_layout_info

(** [arg_locations offset cl] returns the list of storage locations where the arguments are stored.
 *  [offset] should be the index of the first argument
 *)
val arg_locations : int -> Syntax.typ Syntax.contract -> Storage.storage_location list

(** [array_locations cr] returns the list of storage locations where the arrays are stored.
 *)
val array_locations : Syntax.typ Syntax.contract -> Storage.storage_location list
