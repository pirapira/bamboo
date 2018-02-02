(* pseudo immediate value *)

type pseudo_imm =
  | Big of WrapBn.t
  | Int of int
  | DestLabel of Label.label
  | StorageProgramCounterIndex
  | StorageConstructorArgumentsBegin of Assoc.contract_id
  | StorageConstructorArgumentsSize of Assoc.contract_id (* the size is dependent on the contract id *)
  | InitDataSize of Assoc.contract_id
  | ContractOffsetInRuntimeCode of Assoc.contract_id (* where in the runtime code does the contract start.  This index should be a JUMPDEST *)
  | CaseOffsetInRuntimeCode of Assoc.contract_id * Syntax.case_header
  | ConstructorCodeSize of Assoc.contract_id
  | ConstructorInRuntimeCodeOffset of Assoc.contract_id
  | RuntimeCodeOffset of Assoc.contract_id
  | RuntimeCodeSize
  | Minus of pseudo_imm * pseudo_imm

let rec string_of_pseudo_imm (p : pseudo_imm) : string =
  match p with
  | Big b -> "(Big "^(WrapBn.string_of_big_int b)^")"
  | Int i -> "(Int "^(string_of_int i)^")"
  | DestLabel _ -> "DestLabel (print label here)"
  | StorageProgramCounterIndex -> "StorageProgramCounterIndex"
  | StorageConstructorArgumentsBegin _ -> "StorageConstructorArgumentBegin (print contract id)"
  | StorageConstructorArgumentsSize _ -> "StorageConstructorArgumentsSize (print contract id)"
  | InitDataSize cid -> "InitDataSize (print contract id here)"
  | ContractOffsetInRuntimeCode _ -> "ContractOffsetInRuntimeCode (print contact id)"
  | CaseOffsetInRuntimeCode (cid, header) -> "CaseOffsetInRuntimeCode (print contract id, case header)"
  | ConstructorCodeSize cid -> "ConstructorCodeSize (print contract id)"
  | ConstructorInRuntimeCodeOffset cid -> "ConstructorInRuntimeCodeOffset (print contract id)"
  | RuntimeCodeOffset cid -> "RuntimeCodeOffset (print contract id)"
  | RuntimeCodeSize -> "RuntimeCodeSize"
  | Minus (a, b) -> "(- "^(string_of_pseudo_imm a)^" "^(string_of_pseudo_imm b)^")"

let is_constant_big (b : WrapBn.t) (p : pseudo_imm) : bool =
  match p with
  | Big b' -> WrapBn.eq_big_int b b'
  | Int i  -> WrapBn.(eq_big_int (big_int_of_int i) b)
  | _ -> false (* XXX: very rough approximation *)

let is_constant_int (i : int) =
  is_constant_big (WrapBn.big_int_of_int i)
