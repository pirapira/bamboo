type layout_info =
  { (* The initial data is organized like this: *)
    (* |constructor code|runtime code|constructor arguments|  *)
    init_data_size : Syntax.contract_id -> int
  ; constructor_code_size : Syntax.contract_id -> int
    (* runtime_coode_offset is equal to constructor_code_size *)
  ; runtime_code_size : int
  ; contract_offset_in_runtime_code : Syntax.contract_id -> int

    (* And then, the runtime code is organized like this: *)
    (* |dispatcher that jumps into a contract|runtime code for contract A|runtime code for contract B|runtime code for contract C| *)

    (* And then, the runtime code for a particular contract is organized like this: *)
    (* |dispatcher that jumps into somewhere|runtime code for case f|runtime code for case g| *)

    (* numbers about the storage *)
    (* The storage during the runtime looks like this: *)
    (* |current pc (might be entry_pc_of_current_contract)|pod contract argument0|pod contract argument1| *)
    (* In addition, array elements are placed at the same location as in Solidity *)

  ; storage_current_pc_index : int
  ; storage_constructor_arguments_begin : Syntax.contract_id -> int
  ; storage_constructor_arguments_size : Syntax.contract_id -> int
  }

type contract_layout_info =
  { contract_constructor_code_size : int
  (** the number of bytes that the constructor code occupies *)
  ; contract_runtime_code_size : int
  (** the number of bytes that the runtime code occupies *)
  ; contract_argument_size : int
  (** the number of words that the contract arguments occupy *)
  }

val realize_pseudo_instruction :
  layout_info -> Syntax.contract_id -> PseudoImm.pseudo_imm Evm.instruction -> Big_int.big_int Evm.instruction

val realize_pseudo_program :
  layout_info -> Syntax.contract_id -> PseudoImm.pseudo_imm Evm.program -> Big_int.big_int Evm.program

val layout_info_of_contract : Syntax.typ Syntax.contract -> PseudoImm.pseudo_imm Evm.program -> PseudoImm.pseudo_imm Evm.program -> contract_layout_info

val realize_pseudo_imm : layout_info -> Syntax.contract_id -> PseudoImm.pseudo_imm -> Big_int.big_int

val construct_layout_info : (Syntax.contract_id * contract_layout_info) list -> layout_info
