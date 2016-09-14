type interface_typ =
  | InterfaceUint of int

type interface_arg = string * interface_typ

(** [interpret_interface_type] parses "uint" into InterfaceUint 256, etc. *)
val interpret_interface_type : string -> interface_typ

type function_signature =
  { return : interface_typ
  ; name : string
  ; args : interface_arg list
  }
