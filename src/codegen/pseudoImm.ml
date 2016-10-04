(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | DestLabel of Label.label
  | ContractId of Syntax.contract_id (* an immediate value *)

  | StorageContractSwitcherIndex
  | StorageConstructorArgumentsBegin of Syntax.contract_id
  | StorageConstructorArgumentsSize of Syntax.contract_id (* the size is dependent on the contract id *)
  | InitDataSize of Syntax.contract_id
  | ContractOffsetInRuntimeCode of Syntax.contract_id (* where in the runtime code does the contract start.  This index should be a JUMPDEST *)
  | CaseOffsetInRuntimeCode of Syntax.contract_id * Syntax.case_header
  | RuntimeCodeOffset
  | RuntimeCodeSize
  | Minus of pseudo_imm * pseudo_imm

let rec string_of_pseudo_imm (p : pseudo_imm) : string =
  match p with
  | Big b -> "(Big "^(Big_int.string_of_big_int b)^")"
  | Int i -> "(Int "^(string_of_int i)^")"
  | DestLabel _ -> "DestLabel (print label here)"
  | ContractId _ -> "ContractId (print id here)"
  | StorageContractSwitcherIndex -> "StorageContractSwitcherIndex"
  | StorageConstructorArgumentsBegin _ -> "StorageConstructorArgumentBegin (print contract id)"
  | StorageConstructorArgumentsSize _ -> "StorageConstructorArgumentsSize (print contract id)"
  | InitDataSize cid -> "InitDataSize (print contract id here)"
  | ContractOffsetInRuntimeCode _ -> "ContractOffsetInRuntimeCode (print contact id)"
  | CaseOffsetInRuntimeCode (cid, header) -> "CaseOffsetInRuntimeCode (print contract id, case header)"
  | RuntimeCodeOffset -> "RuntimeCodeOffset"
  | RuntimeCodeSize -> "RuntimeCodeSize"
  | Minus (a, b) -> "(- "^(string_of_pseudo_imm a)^" "^(string_of_pseudo_imm b)^")"


type layout_info =
  { (* The initial data is organized like this: *)
    (* |constructor|runtime code|constructor arguments|  *)

    (* And then, the runtime code is organized like this: *)
    (* |dispatcher that jumps into a contract|runtime code for contract A|runtime code for contract B|runtime code for contract C| *)

    (* And then, the runtime code for a particular contract is organized like this: *)
    (* |dispatcher that jumps into somewhere|runtime code for case f|runtime code for case g| *)

    (* nubers about the storage *)
    storage_contract_switcher_index : int
  ; storage_constructor_arguments_begin : Syntax.contract_id -> int
  ; storage_constructor_arguments_size : Syntax.contract_id -> int
  }

let realize_pseudo_imm = failwith "realize_pseudo_imm"
