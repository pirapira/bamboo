(* pseudo immediate value *)

type pseudo_imm =
  | Big of Big_int.big_int
  | Int of int
  | CodePos
  | StorageStart
  | StorageSize
  | MemoryStart
  | MemorySize
  | CodeSize
  | Minus of pseudo_imm * pseudo_imm
