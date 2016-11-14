type layout_info =
  { contract_ids : Assoc.contract_id list
    (* The initial data is organized like this: *)
    (* |constructor code|runtime code|constructor arguments|  *)
  ; init_data_size : Assoc.contract_id -> int
  ; constructor_code_size : Assoc.contract_id -> int
    (* runtime_coode_offset is equal to constructor_code_size *)
  ; runtime_code_size : int
  ; contract_offset_in_runtime_code : int Assoc.contract_id_assoc

    (* And then, the runtime code is organized like this: *)
    (* |dispatcher that jumps into the stored pc|runtime code for contract A|runtime code for contract B|runtime code for contract C| *)

    (* And then, the runtime code for a particular contract is organized like this: *)
    (* |dispatcher that jumps into a case|runtime code for case f|runtime code for case g| *)

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
  }

val realize_pseudo_instruction :
  layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm Evm.instruction -> Big_int.big_int Evm.instruction

val realize_pseudo_program :
  layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm Evm.program -> Big_int.big_int Evm.program

val layout_info_of_contract : Syntax.typ Syntax.contract -> PseudoImm.pseudo_imm Evm.program (* constructor *) -> contract_layout_info

val realize_pseudo_imm : layout_info -> Assoc.contract_id -> PseudoImm.pseudo_imm -> Big_int.big_int

type runtime_layout_info =
  { runtime_code_size : int
  ; runtime_offset_of_contract_id : int Assoc.contract_id_assoc
  }

val construct_layout_info : (Assoc.contract_id * contract_layout_info) list -> runtime_layout_info -> layout_info
