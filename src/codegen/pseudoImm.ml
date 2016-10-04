(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | DestLabel of Label.label
  | ContractId of Syntax.contract_id (* an immediate value *)

  | StorageStart
  | StorageSize
  | StorageContractOffset
  | StorageConstructorArgumentBegin of Syntax.contract_id
  | StorageConstructorArgumentsSize of Syntax.contract_id (* the size is dependent on the contract id *)
  | MemoryStart
  | MemorySize
  | CodeSize
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
  | StorageStart -> "StorageStart"
  | StorageSize -> "StorageSize"
  | StorageContractOffset -> "StorageContractOffset"
  | StorageConstructorArgumentBegin _ -> "StorageConstructorArgumentBegin (print contract id)"
  | StorageConstructorArgumentsSize _ -> "StorageConstructorArgumentsSize (print contract id)"
  | MemoryStart -> "MemoryStart"
  | MemorySize -> "MemorySize"
  | CodeSize -> "CodeSize"
  | ContractOffsetInRuntimeCode _ -> "ContractOffsetInRuntimeCode (print contact id)"
  | CaseOffsetInRuntimeCode (cid, header) -> "CaseOffsetInRuntimeCode (print contract id, case header)"
  | RuntimeCodeOffset -> "RuntimeCodeOffset"
  | RuntimeCodeSize -> "RuntimeCodeSize"
  | Minus (a, b) -> "(- "^(string_of_pseudo_imm a)^" "^(string_of_pseudo_imm b)^")"
