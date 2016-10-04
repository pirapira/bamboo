(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | DestLabel of Label.label
  | ContractId of Syntax.contract_id (* an immediate value *)

  | StorageContractOffset
  (** TODO: what is the intention of this one? *)
  | StorageConstructorArgumentBegin of Syntax.contract_id
  | StorageConstructorArgumentsSize of Syntax.contract_id
  | MemoryStart
  (** TODO: what is the intention of this? *)
  | MemorySize
  (** TODO: what is the intention of this? *)
  | CodeSize
  (** TODO: is this the size of everything containing the constructor or just runtime code *)
  | ContractOffsetInRuntimeCode of Syntax.contract_id (* where in the runtime code does the contract start.  This index should be a JUMPDEST *)
  | CaseOffsetInRuntimeCode of Syntax.contract_id * Syntax.case_header
  | RuntimeCodeOffset
  | RuntimeCodeSize
  | Minus of pseudo_imm * pseudo_imm


val string_of_pseudo_imm : pseudo_imm -> string
