(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | DestLabel of Label.label
  | StorageProgramCounterIndex
  | StorageConstructorArgumentsBegin of Assoc.contract_id
  | StorageConstructorArgumentsSize of Assoc.contract_id
  | InitDataSize of Assoc.contract_id
  (** [InitDataSize cid] represents the size of the data sent to create the transaction.
   *  This data contains the initializing code plus runtime code plus the constructor
   *  argument data.  Since the constructor arguments differ from a contract to a contract,
   *  [InitDataSize] requires a contract id.
   *)
  | ContractOffsetInRuntimeCode of Assoc.contract_id (* where in the runtime code does the contract start.  This index should be a JUMPDEST *)
  | CaseOffsetInRuntimeCode of Assoc.contract_id * Syntax.case_header

  (* constructor code is the part of the init code before the runtime code as payload.  *)
  | ConstructorCodeSize of Assoc.contract_id
  (* for runtime code creation, the runtime code also contains the constructor code. *)
  | ConstructorInRuntimeCodeOffset of Assoc.contract_id

  | RuntimeCodeOffset of Assoc.contract_id
  | RuntimeCodeSize
  | Minus of pseudo_imm * pseudo_imm


val string_of_pseudo_imm : pseudo_imm -> string

val is_constant_big : Big_int.big_int -> pseudo_imm -> bool
val is_constant_int : int -> pseudo_imm -> bool
