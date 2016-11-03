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

