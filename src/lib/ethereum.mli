type interface_typ =
  | InterfaceUint of int
  | InterfaceAddress
  | InterfaceBool

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
  Syntax.arg list -> interface_typ list
