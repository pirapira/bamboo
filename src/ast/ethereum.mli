val word_bits : int
val signature_bits : int

type interface_typ =
  | InterfaceUint of int
  | InterfaceBytes of int
  | InterfaceAddress
  | InterfaceBool

(** size of values of the interface type in bytes *)
val interface_typ_size : interface_typ -> int

type interface_arg = string * interface_typ

(** [interpret_interface_type] parses "uint" into InterfaceUint 256, etc. *)
val interpret_interface_type : Syntax.typ -> interface_typ

val to_typ : interface_typ -> Syntax.typ

(** [string_of_interface_type t] is a string that is used to compute the
 * method signatures.  Addresses are "address", uint is "uint256". *)
val string_of_interface_type : interface_typ -> string

type function_signature =
  { sig_return : interface_typ list
  ; sig_name : string
  ; sig_args : interface_typ list
  }

val get_interface_typs :
  Syntax.arg list -> (string * interface_typ) list

val arguments_with_locations :
  Syntax.typ Syntax.case -> (string * Location.location) list

val constructor_arguments :
  Syntax.typ Syntax.contract -> (string * interface_typ) list

val arrays_in_contract :
  Syntax.typ Syntax.contract -> (string * Syntax.typ * Syntax.typ) list

val total_size_of_interface_args :
  interface_typ list -> int

(** [string_keccak] returns the Keccak-256 hash of a string in
 * hex, without the prefix [0x]. *)
val string_keccak : string -> string

(** [hex_keccak] expects a hex string and returns the Keccak-256 hash of the
 *  represented byte sequence, without the prefix [0x]. *)
val hex_keccak : string -> string

(** [keccak_short "pay(address)"] returns the
 * method signature code (which is commonly used in the ABI.
 *)
val keccak_signature : string -> string

(** [case_heaer_signature_string h] returns the
 * signature of a fucntion as used for creating the
 * function hash.  Like "pay(address)"
 * TODO: cite some document here.
 *)
val case_header_signature_string : Syntax.usual_case_header -> string

(** [compute_singature_hash] takes a string like `f(uint8,address)` and
 returns a 4byte signature hash commonly used in Ethereum ABI. *)
val compute_signature_hash : string -> string

(** [case_header_signature_hash h] returns the
 * method signature used in the common ABI.
 * The hex hash comes without 0x
 *)
val case_header_signature_hash :
  Syntax.usual_case_header -> string

val event_signature_hash :
  Syntax.event -> string

val print_abi : Syntax.typ Syntax.toplevel Assoc.contract_id_assoc -> unit
