(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | CodePos
  | StorageStart
  | StorageSize
  | StorageConstructorArgumentBegin of Syntax.contract_id
  | StorageConstructorArgumentsSize of Syntax.contract_id
  | MemoryStart
  | MemorySize
  | CodeSize
  | Minus of pseudo_imm * pseudo_imm
