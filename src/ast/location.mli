(* This module annotates idents with the locations of the data *)

type memory_range =
  { memory_start : int (* In byte as in EVM *)
  ; memory_size  : int (* In byte *)
  }

type storage_range =
  { storage_start : int (* In word as in EVM *)
  ; storage_size :  int (* In word *)
  }

type volatile_location =
  | Memory of memory_range
  | Stack of int (* [Stack 0] is the deepest element in the stack *)

type cached_storage =
  { cached_original: storage_range
  ; modified : bool (* if the cache has to be written again *)
  ; cache : volatile_location
  }

type location =
  | Storage of storage_range
  | CachedStorage of cached_storage
  | Volatile of volatile_location
