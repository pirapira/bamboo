let word_bits = 256
let signature_bits = 32

type interface_typ =
  | InterfaceUint of int
  | InterfaceBytes of int
  | InterfaceAddress
  | InterfaceBool

type interface_arg = string * interface_typ

(** [interpret_interface_type] parses "uint" into InterfaceUint 256, etc. *)
let interpret_interface_type (str : Syntax.typ) : interface_typ =
  Syntax.
  (match str with
  | Uint256Type -> InterfaceUint 256
  | Uint8Type -> InterfaceUint 8
  | Bytes32Type -> InterfaceBytes 32
  | AddressType -> InterfaceAddress
  | BoolType -> InterfaceBool
  | TupleType _ -> failwith "interpret_interface_type: tuple types are not supported yet"
  | MappingType (_, _) -> failwith "interpret_interface_type: mapping type not supported"
  | ContractInstanceType _ -> InterfaceAddress
  | ContractArchType _ -> failwith "contract arch-type does not appear in the ABI"
  | ReferenceType _ -> failwith "reference type does not appear in the ABI"
  | VoidType -> failwith "VoidType should not appear in the ABI"
  )

let to_typ (ityp : interface_typ) =
  Syntax.
  ( match ityp with
    | InterfaceUint x ->
       let () = if (x < 0 || x > 256) then
                  failwith "too small or too big integer" in
       Uint256Type
    | InterfaceBytes x ->
       let () = assert (x = 32) in
       Bytes32Type
    | InterfaceBool -> BoolType
    | InterfaceAddress -> AddressType
  )

(* in bytes *)
let interface_typ_size (ityp : interface_typ) : int =
  match ityp with
  | InterfaceUint _ -> 32
  | InterfaceAddress -> 32
  | InterfaceBool -> 32
  | InterfaceBytes _ -> 32

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
  WrapList.filter_map get_interface_typ

let rec argument_sizes_to_positions_inner ret used sizes =
  match sizes with
  | [] -> List.rev ret
  | h :: t ->
     let () = assert (h > 0) in
     let () = assert (h <= 32) in (* XXX using div and mod, generalization is possible *)
     argument_sizes_to_positions_inner
       (used + 32 - h :: ret) (used + 32) t

let argument_sizes_to_positions sizes =
  argument_sizes_to_positions_inner [] 4 (* size of signature *) sizes

let print_arg_loc r =
  List.iter (fun (name, loc) ->
      Printf.printf "argument %s at %s\n" name (Location.as_string loc)
    ) r

let arguments_with_locations (c : Syntax.typ Syntax.case) : (string * Location.location) list =
  Syntax.(
    match c.case_header with
    | DefaultCaseHeader -> []
    | UsualCaseHeader h ->
       let sizes : int list = List.map calldata_size_of_arg h.Syntax.case_arguments in
       let positions : int list = argument_sizes_to_positions sizes in
       let size_pos : (int * int) list = List.combine positions sizes in
       let locations : Location.location list = List.map (fun (o, s) -> Location.(Calldata {calldata_offset = o; calldata_size = s})) size_pos in
       let names : string list = List.map (fun a -> a.Syntax.arg_ident) h.Syntax.case_arguments in
       let ret = List.combine names locations in
       ret
  )

let get_array (raw : Syntax.arg) : (string * Syntax.typ * Syntax.typ) option =
  match Syntax.(raw.arg_typ) with
  | Syntax.MappingType (k, v) -> Some (raw.Syntax.arg_ident, k, v)
  | _ -> None

let arrays_in_contract c : (string * Syntax.typ * Syntax.typ) list =
  WrapList.filter_map get_array (c.Syntax.contract_arguments)

let constructor_arguments (contract : Syntax.typ Syntax.contract)
    : (string * interface_typ) list
  = get_interface_typs (contract.Syntax.contract_arguments)

let total_size_of_interface_args lst : int =
  try WrapList.sum (List.map interface_typ_size lst) with
        Invalid_argument _ -> 0

let string_keccak = WrapCryptokit.string_keccak

let hex_keccak = WrapCryptokit.hex_keccak

let keccak_signature (str : string) : string =
  String.sub (string_keccak str) 0 8

let string_of_interface_type (i : interface_typ) : string =
  match i with
  | InterfaceUint x ->
     "uint"^(string_of_int x)
  | InterfaceBytes x ->
     "bytes"^(string_of_int x)
  | InterfaceAddress -> "address"
  | InterfaceBool -> "bool"

let case_header_signature_string (h : Syntax.usual_case_header) : string =
  let name_of_case = h.Syntax.case_name in
  let arguments = get_interface_typs h.Syntax.case_arguments in
  let arg_typs = List.map snd arguments in
  let list_of_types = List.map string_of_interface_type arg_typs in
  let args = String.concat "," list_of_types in
  name_of_case ^ "(" ^ args ^ ")"

(* XXX: refactor with the above function *)
let event_signature_string (e : Syntax.event) : string =
  (* do I consider indexed no? *)
  let name = e.Syntax.event_name in
  let arguments = get_interface_typs (List.map Syntax.arg_of_event_arg e.Syntax.event_arguments) in
  let arg_typs = List.map snd arguments in
  let list_of_types = List.map string_of_interface_type arg_typs in
  let args = String.concat "," list_of_types in
  name ^ "(" ^ args ^ ")"

let case_header_signature_hash (h : Syntax.usual_case_header) : string =
  let sign = case_header_signature_string h in
  keccak_signature sign

let event_signature_hash (e : Syntax.event) : string =
  let sign = event_signature_string e in
  keccak_signature sign

let compute_signature_hash (signature : string) : string =
  String.sub (string_keccak signature) 0 8

let print_default_header =
  "{\"type\":\"fallback\",\"inputs\": [],\"outputs\": [],\"payable\": true}"

let print_input_abi (arg : Syntax.arg) : string =
  Printf.sprintf "{\"name\": \"%s\", \"type\": \"%s\"}"
                 (arg.Syntax.arg_ident)
                 (string_of_interface_type (interpret_interface_type arg.Syntax.arg_typ))

let print_inputs_abi (args : Syntax.arg list) : string =
  let strings = List.map print_input_abi args in
  String.concat "," strings

let print_output_abi (typ : Syntax.typ) : string =
  Printf.sprintf "{\"name\": \"\", \"type\": \"%s\"}"
                 (string_of_interface_type (interpret_interface_type typ))

let print_outputs_abi (typs : Syntax.typ list) : string =
  let strings = List.map print_output_abi typs in
  String.concat "," strings

let print_usual_case_abi u =
  Printf.sprintf
    "{\"type\":\"function\",\"name\":\"%s\",\"inputs\": [%s],\"outputs\": [%s],\"payable\": true}"
    (u.Syntax.case_name)
    (print_inputs_abi u.Syntax.case_arguments)
    (print_outputs_abi u.Syntax.case_return_typ)

let print_case_abi (c : Syntax.typ Syntax.case) : string =
  match c.Syntax.case_header with
  | Syntax.UsualCaseHeader u ->
     print_usual_case_abi u
  | Syntax.DefaultCaseHeader ->
     print_default_header

let print_constructor_abi (c : Syntax.typ Syntax.contract) : string =
  Printf.sprintf
    "{\"type\": \"constructor\", \"inputs\":[%s], \"name\": \"%s\", \"outputs\":[], \"payable\": true}"
    (print_inputs_abi (List.filter Syntax.non_mapping_arg c.Syntax.contract_arguments))
    (c.Syntax.contract_name)

let print_contract_abi seen_constructor (c : Syntax.typ Syntax.contract) : string =
  let cases = c.Syntax.contract_cases in
  let strings : string list = List.map print_case_abi cases in
  let strings = if !seen_constructor then strings
                else (print_constructor_abi c) :: strings in
  let () = (seen_constructor := true) in
  String.concat "," strings

let print_event_arg (a : Syntax.event_arg) : string =
  Printf.sprintf "{\"name\":\"%s\",\"type\":\"%s\",\"indexed\":%s}"
                 Syntax.(a.event_arg_body.arg_ident)
                 (string_of_interface_type (interpret_interface_type Syntax.(a.event_arg_body.arg_typ)))
                 (string_of_bool a.Syntax.event_arg_indexed)

let print_event_inputs (is : Syntax.event_arg list) : string =
  let strings : string list = List.map print_event_arg is in
  String.concat "," strings

let print_event_abi (e : Syntax.event) : string =
  Printf.sprintf
    "{\"type\":\"event\",\"inputs\":[%s],\"name\":\"%s\"}"
    (print_event_inputs e.Syntax.event_arguments)
    (e.Syntax.event_name)

let print_toplevel_abi seen_constructor (t : Syntax.typ Syntax.toplevel) : string =
  match t with
  | Syntax.Contract c ->
     print_contract_abi seen_constructor c
  | Syntax.Event e ->
     print_event_abi e

let print_abi (tops : Syntax.typ Syntax.toplevel Assoc.contract_id_assoc) : unit =
  let seen_constructor = ref false in
  let () = Printf.printf "[" in
  let strings : string list = List.filter (fun s -> (String.length s) != 0) (List.map (print_toplevel_abi seen_constructor) (Assoc.values tops)) in
  let () = Printf.printf "%s" (String.concat "," strings) in
  Printf.printf "]"
