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
  | UintType -> InterfaceUint 256
  | Uint8Type -> InterfaceUint 8
  | Bytes32Type -> InterfaceBytes 32
  | AddressType -> InterfaceAddress
  | BoolType -> InterfaceBool
  | TupleType _ -> failwith "interpret_interface_type: tuple types are not supported yet"
  | MappingType (_, _) -> failwith "interpret_interface_type: mapping type not supported"
  | ContractInstanceType _ -> InterfaceAddress
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
  Misc.filter_map get_interface_typ

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
       let () = print_arg_loc ret in
       ret
  )

let get_array (raw : Syntax.arg) : (string * Syntax.typ * Syntax.typ) option =
  match Syntax.(raw.arg_typ) with
  | Syntax.MappingType (k, v) -> Some (raw.Syntax.arg_ident, k, v)
  | _ -> None

let arrays_in_contract c : (string * Syntax.typ * Syntax.typ) list =
  Misc.filter_map get_array (c.Syntax.contract_arguments)

let constructor_arguments (contract : Syntax.typ Syntax.contract)
    : (string * interface_typ) list
  = get_interface_typs (contract.Syntax.contract_arguments)

let total_size_of_interface_args lst : int =
  Misc.int_sum (List.map interface_typ_size lst)

module Hash = Cryptokit.Hash

let string_keccak str : string =
  let sha3_256 = Hash.keccak 256 in
  let () = sha3_256#add_string str in
  let ret = sha3_256#result in
  let tr = Cryptokit.Hexa.encode () in
  let () = tr#put_string ret in
  let () = tr#finish in
  let ret = tr#get_string in
  (* need to convert ret into hex *)
  ret

let strip_0x h =
  if BatString.starts_with h "0x" then
    BatString.tail h 2
  else
    h

let add_hex sha3_256 h =
  let h = strip_0x h in
  let add_byte c =
    sha3_256#add_char c in
  let chars = BatString.explode h in
  let rec work chars =
    match chars with
    | [] -> ()
    | [x] -> failwith "odd-length hex"
    | a :: b :: rest ->
       let () = add_byte (Hex.to_char a b) in
       work rest in
  work chars

let hex_keccak h : string =
  let sha3_256 = Hash.keccak 256 in
  let () = add_hex sha3_256 h in
  let ret = sha3_256#result in
  let tr = Cryptokit.Hexa.encode () in
  let () = tr#put_string ret in
  let () = tr#finish in
  let ret = tr#get_string in
  (* need to convert ret into hex *)
  ret

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

let case_header_signature_hash (h : Syntax.usual_case_header) : string =
  let sign = case_header_signature_string h in
  let () = Printf.printf "for signature %s\n" sign in
  keccak_signature sign

let hex_to_big_int h =
  BatBig_int.big_int_of_string ("0x"^h)
