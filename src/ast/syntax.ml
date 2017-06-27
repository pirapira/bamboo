type typ =
  | UintType
  | AddressType
  | BoolType
  | ReferenceType of
      typ list (** pointer to [typ list] on memory *)
  | TupleType of typ list
  | MappingType of typ * typ
  | ContractArchType of string (* type of [bid(...)] where bid is a contract *)
  | ContractInstanceType of string (* type of [b] declared as [bid b] *)

let rec string_of_typ t =
  match t with
  | UintType -> "uint"
  | AddressType -> "address"
  | BoolType -> "bool"
  | MappingType (a, b) -> "mapping ("^string_of_typ a^" => "^string_of_typ b^")"
  | ContractArchType s -> "ContractArchType "^s
  | ContractInstanceType s -> "ContractInstanceType "^s
  | ReferenceType _ -> "pointer to ..."
  | TupleType _ -> "tuple"

type 'exp_annot function_call =
  { call_head : string
  ; call_args : ('exp_annot exp) list
  }
and 'exp_annot message_info =
  { message_value_info : 'exp_annot exp option
  ; message_reentrance_info : 'exp_annot sentence list
  }
and 'exp_annot new_exp =
  { new_head : string
  ; new_args : 'exp_annot exp list
  ; new_msg_info : 'exp_annot message_info
  }
and 'exp_annot send_exp =
  { send_head_contract : 'exp_annot exp
  ; send_head_method : string
  ; send_args : 'exp_annot exp list
  ; send_msg_info : 'exp_annot message_info
  }
and 'exp_annot exp = 'exp_annot exp_inner * 'exp_annot
and 'exp_annot exp_inner =
  | TrueExp
  | FalseExp
  | NowExp
  | FunctionCallExp of 'exp_annot function_call
  | IdentifierExp of string
  | ParenthExp of 'exp_annot exp
  | NewExp of 'exp_annot new_exp
  | SendExp of 'exp_annot send_exp
  | LtExp of 'exp_annot exp * 'exp_annot exp
  | GtExp of 'exp_annot exp * 'exp_annot exp
  | NeqExp of 'exp_annot exp * 'exp_annot exp
  | EqualityExp of 'exp_annot exp * 'exp_annot exp
  | AddressExp of 'exp_annot exp
  | NotExp of 'exp_annot exp
  | ArrayAccessExp of 'exp_annot array_access
  | ValueExp
  | SenderExp
  | ThisExp
  | SingleDereferenceExp of 'exp_annot exp
  | TupleDereferenceExp of 'exp_annot exp
and 'exp_annot lexp =
  | IdentifierLExp of string
  | ArrayAccessLExp of 'exp_annot array_access
and 'exp_annot array_access =
  { array_access_array : string
  ; array_access_index : 'exp_annot exp
  }
and 'exp_annot variable_init =
  { variable_init_type : typ
  ; variable_init_name : string
  ; variable_init_value : 'exp_annot exp
  }
and 'exp_annot sentence =
  | AbortSentence
  | ReturnSentence of 'exp_annot return
  | AssignmentSentence of 'exp_annot lexp * 'exp_annot exp
  | VariableInitSentence of 'exp_annot variable_init
  | IfSingleSentence of 'exp_annot exp * 'exp_annot sentence
  | SelfdestructSentence of 'exp_annot exp
and 'exp_annot return =
  { return_exp : 'exp_annot exp
  ; return_cont : 'exp_annot exp
  }

type arg =
  { arg_typ : typ
  ; arg_ident : string
  }

type 'exp_annot case_body =
  'exp_annot sentence list

type usual_case_header =
  { case_return_typ : typ list
  ; case_name : string
  ; case_arguments : arg list
  }

type case_header =
  | UsualCaseHeader of usual_case_header
  | DefaultCaseHeader

type 'exp_annot case =
  { case_header : case_header
  ; case_body : 'exp_annot case_body
  }

type 'exp_annot contract =
  { contract_name : string
  ; contract_arguments : arg list
  ; contract_cases : 'exp_annot case list
  }

let contract_name_of_return_cont ((r, _) : 'exp exp) : string option =
  match r with
  | FunctionCallExp c -> Some c.call_head
  | _ -> None

let case_header_arg_list (c : case_header) : arg list =
  match c with
  | UsualCaseHeader uch ->
     uch.case_arguments
  | DefaultCaseHeader -> []

let contract_name_of_instance ((_, t) : typ exp) =
  match t with
  | ContractInstanceType s -> s
  | typ -> failwith
             ("seeking contract_name_of non-contract "^(string_of_typ typ))

let string_of_exp_inner e =
  match e with
  | ThisExp -> "this"
  | ArrayAccessExp _ -> "a[idx]"
  | SendExp _ -> "send"
  | NewExp _ -> "new"
  | ParenthExp _ -> "()"
  | IdentifierExp str -> "ident "^str
  | FunctionCallExp _ -> "call"
  | NowExp -> "now"
  | FalseExp -> "false"
  | SenderExp -> "sender"
  | TrueExp -> "true"
  | NotExp _ -> "not"
  | NeqExp _ -> "neq"
  | LtExp _ -> "lt"
  | GtExp _ -> "lt"
  | ValueExp -> "value"
  | EqualityExp _ -> "equality"
  | AddressExp _ -> "address"
  | SingleDereferenceExp _ -> "dereference of ..."
  | TupleDereferenceExp _ -> "dereference of tuple..."

let is_mapping (typ : typ) =
  match typ with
  | UintType
  | AddressType
  | BoolType
  | ReferenceType _
  | TupleType _
  | ContractArchType _
  | ContractInstanceType _
    -> false
  | MappingType _ -> true

let count_plain_args (typs : typ list) =
  List.length (List.filter (fun t -> not (is_mapping t)) typs)

let fits_in_one_storage_slot (typ : typ) =
  match typ with
  | UintType
  | AddressType
  | BoolType
  | ContractInstanceType _
  | MappingType _ -> true
  | ReferenceType _ -> false
  | TupleType _ -> false
  | ContractArchType _ -> false

let size_of_typ (* in bytes *) = function
  | UintType -> 32
  | AddressType -> 32 (* Though only 20 bytes are used *)
  | BoolType -> 32
  | ReferenceType _ -> 32
  | TupleType lst ->
     failwith "size_of_typ Tuple"
  | MappingType _ -> failwith "size_of_typ MappingType" (* XXX: this is just 32 I think *)
  | ContractArchType _ -> failwith "size_of_typ ContractArchType"
  | ContractInstanceType _ -> 32 (* address as word *)

let calldata_size_of_typ (typ : typ) =
  match typ with
  | MappingType _ -> failwith "mapping cannot be a case argument"
  | ReferenceType _ -> failwith "reference type cannot be a case argument"
  | TupleType _ -> failwith "tupletype not implemented"
  | ContractArchType _ -> failwith "ContractArchType cannot be a case argument"
  | _ -> size_of_typ typ

let calldata_size_of_arg (arg : arg) =
  calldata_size_of_typ arg.arg_typ

let is_throw_only (ss : typ sentence list) : bool =
  match ss with
  | [] -> false
  | [AbortSentence] -> true
  | _ -> false

let lookup_usual_case_header (c : 'annot contract) (case_name : string) : usual_case_header =
  let cases = c.contract_cases in
  let cases = List.filter (fun c -> match c.case_header with
                                     | DefaultCaseHeader -> false
                                     | UsualCaseHeader uc ->
                                        uc.case_name = case_name) cases in
  let () = assert (List.length cases = 1) in
  let [a] = cases in
  let UsualCaseHeader uc = a.case_header in
  uc

let size_of_typs (typs : typ list) =
  BatList.sum (List.map size_of_typ typs)
