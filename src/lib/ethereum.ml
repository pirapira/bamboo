type interface_typ =
  | InterfaceUint of int
  | InterfaceAddress
  | InterfaceBool

type interface_arg = string * interface_typ

(** [interpret_interface_type] parses "uint" into InterfaceUint 256, etc. *)
let interpret_interface_type (str : Syntax.typ) : interface_typ =
  Syntax.
  (match str with
  | UintType -> InterfaceUint 256
  | AddressType -> InterfaceAddress
  | BoolType -> InterfaceBool
  | MappingType (_, _) -> failwith "interpret_interface_type: mapping type not supported"
  | IdentType _ -> failwith "interpret_interface_type: custom type not supported in ABI"
  )

type function_signature =
  { sig_return : interface_typ list
  ; sig_name : string
  ; sig_args : interface_typ list
  }

let get_interface_typ (raw : Syntax.arg) : interface_typ =
  interpret_interface_type Syntax.(raw.arg_typ)

let get_interface_typs : Syntax.arg list -> interface_typ list =
  List.map get_interface_typ
