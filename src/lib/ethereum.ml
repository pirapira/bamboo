let word_bits = 256
let signature_bits = 32

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
  | TupleType _ -> failwith "interpret_interface_type: tuple types are not supported yet"
  | MappingType (_, _) -> failwith "interpret_interface_type: mapping type not supported"
  | ContractInstanceType _ -> failwith "contract instance type does not appear in the ABI"
  | ContractArchType _ -> failwith "contract arch-type does not appear in the ABI"
  | ReferenceType _ -> failwith "reference type does not appear in the ABI"
  )

let to_typ (ityp : interface_typ) =
  Syntax.
  ( match ityp with
    | InterfaceUint x ->
       let () = if (x < 0 || x > 256) then
                  failwith "too small or too big integer" in
       UintType
    | InterfaceBool -> BoolType
    | InterfaceAddress -> AddressType
  )

(* in bytes *)
let interface_typ_size (ityp : interface_typ) : int =
  match ityp with
  | InterfaceUint _ -> 32
  | InterfaceAddress -> 32
  | InterfaceBool -> 32

type function_signature =
  { sig_return : interface_typ list
  ; sig_name : string
  ; sig_args : interface_typ list
  }

let get_interface_typ (raw : Syntax.arg) : (string * interface_typ) option =
  match Syntax.(raw.arg_typ) with
  | Syntax.MappingType (_,_) -> None
  | _ -> Some (raw.Syntax.arg_ident, interpret_interface_type Syntax.(raw.arg_typ))

let get_interface_typs : Syntax.arg list -> (string * interface_typ) list =
    Misc.filter_map get_interface_typ

let constructor_arguments (contract : Syntax.typ Syntax.contract)
    : (string * interface_typ) list
  = get_interface_typs (contract.Syntax.contract_arguments)

let total_size_of_interface_args lst : int =
  Misc.int_sum (List.map interface_typ_size lst)
