(* pseudo immediate value *)

type pseudo_imm =
  | Concrete of Big_int.big_int
  | CodePos
  | StorageStart
  | StorageSize
  | MemoryStart
  | MemorySize
