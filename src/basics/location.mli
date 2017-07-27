(* This module annotates idents with the locations of the data *)

type 'imm memory_range =
  { memory_start : 'imm (* In byte as in EVM *)
  ; memory_size  : 'imm (* In byte *)
  }

type 'imm storage_range =
  { storage_start : 'imm (* In word as in EVM *)
  ; storage_size :  'imm (* In word *)
  }

type 'imm code_range =
  { code_start : 'imm (* In byte *)
  ; code_size  : 'imm
  }

type 'imm volatile_location =
  | Memory of 'imm memory_range
  | Stack of int
  (** [Stack 0] is the deepest element in the stack.
   * The stack usage should be known from the beginning of the
   * code generation.
   *)

type 'imm cached_storage =
  { cached_original: 'imm storage_range
  ; modified : bool (* if the cache has to be written again *)
  ; cache : 'imm volatile_location
  }

type calldata_range =
  { calldata_offset : int
  ; calldata_size : int
  }

type location =
  | Storage of PseudoImm.pseudo_imm storage_range
  | CachedStorage of PseudoImm.pseudo_imm cached_storage
  | Volatile of PseudoImm.pseudo_imm volatile_location
  | Code of PseudoImm.pseudo_imm code_range
  | Calldata of calldata_range
  | Stack of int

val as_string : location -> string
