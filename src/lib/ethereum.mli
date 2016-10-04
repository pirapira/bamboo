val word_bits : int
val signature_bits : int

type interface_typ =
  | InterfaceUint of int
  | InterfaceAddress
  | InterfaceBool

val interface_typ_size : interface_typ -> int

type interface_arg = string * interface_typ

(** [interpret_interface_type] parses "uint" into InterfaceUint 256, etc. *)
val interpret_interface_type : Syntax.typ -> interface_typ

val to_typ : interface_typ -> Syntax.typ

type function_signature =
  { sig_return : interface_typ list
  ; sig_name : string
  ; sig_args : interface_typ list
  }

val get_interface_typs :
  Syntax.arg list -> (string * interface_typ) list

val constructor_arguments :
  Syntax.typ Syntax.contract -> (string * interface_typ) list

val total_size_of_interface_args :
  interface_typ list -> int

(** [string_keccak] returns the Keccak-256 hash of a string in
 * hex, without the prefix [0x]. *)
val string_keccak : string -> string

(** [keccak_short "pay(address)"] returns the
 * method signature code (which is commonly used in the ABI.
 *)
val keccak_signature : string -> string
