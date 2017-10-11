type typ =
  | VoidType
  | Uint256Type
  | Uint8Type
  | Bytes32Type
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
  | VoidType -> "void"
  | Uint256Type -> "uint256"
  | Uint8Type -> "uint8"
  | Bytes32Type -> "bytes32"
  | AddressType -> "address"
  | BoolType -> "bool"
  | MappingType (a, b) -> "mapping ("^string_of_typ a^" => "^string_of_typ b^")"
  | ContractArchType s -> "ContractArchType "^s
  | ContractInstanceType s -> "ContractInstanceType "^s
  | ReferenceType _ -> "pointer to ..."
  | TupleType _ -> "tuple"

type arg =
  { arg_typ : typ
  ; arg_ident : string
  ; arg_location : SideEffect.location option
  }

type event_arg =
  { event_arg_body : arg
  ; event_arg_indexed : bool
  }

type event =
  { event_name : string
  ; event_arguments : event_arg list
  }


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
  ; send_head_method : string option
  ; send_args : 'exp_annot exp list
  ; send_msg_info : 'exp_annot message_info
  }
and 'exp_annot exp = 'exp_annot exp_inner * 'exp_annot
and 'exp_annot exp_inner =
  | TrueExp
  | FalseExp
  | DecLit256Exp of Big_int.big_int
  | DecLit8Exp of Big_int.big_int
  | NowExp
  | FunctionCallExp of 'exp_annot function_call
  | IdentifierExp of string
  | ParenthExp of 'exp_annot exp
  | NewExp of 'exp_annot new_exp
  | SendExp of 'exp_annot send_exp
  | LandExp of 'exp_annot exp * 'exp_annot exp
  | LtExp of 'exp_annot exp * 'exp_annot exp
  | GtExp of 'exp_annot exp * 'exp_annot exp
  | NeqExp of 'exp_annot exp * 'exp_annot exp
  | EqualityExp of 'exp_annot exp * 'exp_annot exp
  | AddressExp of 'exp_annot exp
  | NotExp of 'exp_annot exp
  | ArrayAccessExp of 'exp_annot lexp
  | ValueExp
  | SenderExp
  | ThisExp
  | SingleDereferenceExp of 'exp_annot exp
  | TupleDereferenceExp of 'exp_annot exp
  | PlusExp of 'exp_annot exp * 'exp_annot exp
  | MinusExp of 'exp_annot exp * 'exp_annot exp
  | MultExp of 'exp_annot exp * 'exp_annot exp
  | BalanceExp of 'exp_annot exp
and 'exp_annot lexp =
  | ArrayAccessLExp of 'exp_annot array_access
and 'exp_annot array_access =
  { array_access_array : 'exp_annot exp
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
  | IfThenOnly of 'exp_annot exp * 'exp_annot sentence list
  | IfThenElse of 'exp_annot exp * 'exp_annot sentence list * 'exp_annot sentence list
  | SelfdestructSentence of 'exp_annot exp
  | ExpSentence of 'exp_annot exp
  | LogSentence of string * 'exp_annot exp list * event option
and 'exp_annot return =
  { return_exp : 'exp_annot exp option
  ; return_cont : 'exp_annot exp
  }

let read_array_access (l : 'a lexp) =
  match l with
  | ArrayAccessLExp a -> a

let event_arg_of_arg (a : arg) (indexed : bool) : event_arg =
  { event_arg_body = a
  ; event_arg_indexed = indexed
  }

let arg_of_event_arg e =
  e.event_arg_body

let split_event_args (e : event) (args : 'a exp list) =
  let indexed : bool list =
    List.map (fun (a : event_arg) ->
        a.event_arg_indexed) e.event_arguments in
  let combined : ('a exp * bool) list =
    List.combine args indexed in
  let (is, ns) = BatList.partition snd combined in
  (List.map fst is, List.map fst ns)

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

type 'exp_annot toplevel =
  | Contract of 'exp_annot contract
  | Event of event

let contract_name_of_return_cont ((r, _) : 'exp exp) : string option =
  match r with
  | FunctionCallExp c -> Some c.call_head
  | _ -> None

let case_header_arg_list (c : case_header) : arg list =
  match c with
  | UsualCaseHeader uch ->
     uch.case_arguments
  | DefaultCaseHeader -> []

let contract_name_of_instance ((_, (t, _)) : (typ * 'a) exp) =
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
  | SenderExp -> "sender"
  | TrueExp -> "true"
  | FalseExp -> "false"
  | DecLit256Exp d -> "declit "^(Big_int.string_of_big_int d)
  | DecLit8Exp d -> "declit "^(Big_int.string_of_big_int d)
  | NotExp _ -> "not"
  | NeqExp _ -> "neq"
  | LandExp _ -> "_ && _"
  | LtExp _ -> "lt"
  | GtExp _ -> "gt"
  | ValueExp -> "value"
  | EqualityExp _ -> "equality"
  | AddressExp _ -> "address"
  | SingleDereferenceExp _ -> "dereference of ..."
  | TupleDereferenceExp _ -> "dereference of tuple..."
  | PlusExp (a, b) -> "... + ..."
  | MinusExp (a, b) -> "... - ..."
  | MultExp (a, b) -> "... * ..."
  | BalanceExp _ -> "balance"

let is_mapping (typ : typ) =
  match typ with
  | Uint256Type
  | Uint8Type
  | Bytes32Type
  | AddressType
  | BoolType
  | ReferenceType _
  | TupleType _
  | ContractArchType _
  | ContractInstanceType _
  | VoidType
    -> false
  | MappingType _ -> true

let count_plain_args (typs : typ list) =
  List.length (List.filter (fun t -> not (is_mapping t)) typs)

let fits_in_one_storage_slot (typ : typ) =
  match typ with
  | Uint256Type
  | Uint8Type
  | Bytes32Type
  | AddressType
  | BoolType
  | ContractInstanceType _
  | MappingType _ -> true
  | ReferenceType _ -> false
  | TupleType _ -> false
  | ContractArchType _ -> false
  | VoidType -> false

let size_of_typ (* in bytes *) = function
  | Uint256Type -> 32
  | Uint8Type -> 1
  | Bytes32Type -> 32
  | AddressType -> 20
  | BoolType -> 32
  | ReferenceType _ -> 32
  | TupleType lst ->
     failwith "size_of_typ Tuple"
  | MappingType _ -> failwith "size_of_typ MappingType" (* XXX: this is just 32 I think *)
  | ContractArchType x -> failwith ("size_of_typ ContractArchType: "^x)
  | ContractInstanceType _ -> 20 (* address as word *)
  | VoidType -> failwith "size_of_typ VoidType should not be asked"

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

let non_mapping_arg (arg : arg) =
  match arg.arg_typ with
  | MappingType _ -> false
  | _ -> true

let rec functioncall_might_become f =
  List.concat (List.map exp_might_become f.call_args)
and new_exp_might_become n =
  List.concat (List.map exp_might_become n.new_args)@
    (msg_info_might_become n.new_msg_info)
and msg_info_might_become m =
  (match m.message_value_info with
   | None -> []
   | Some e -> exp_might_become e)@
    [(* TODO: message_reentrance_info should contain a continuation! *)]
and send_exp_might_become s =
  (exp_might_become s.send_head_contract)@
    (List.concat (List.map exp_might_become s.send_args))@
      (msg_info_might_become s.send_msg_info)
and array_access_might_become aa =
  exp_might_become aa.array_access_index
and exp_might_become e : string list =
  match fst e with
  | TrueExp -> []
  | FalseExp -> []
  | DecLit256Exp _ -> []
  | DecLit8Exp _ -> []
  | NowExp -> []
  | FunctionCallExp f ->
     functioncall_might_become f
  | IdentifierExp _ -> []
  | ParenthExp content ->
     exp_might_become content
  | NewExp n ->
     new_exp_might_become n
  | SendExp s ->
     send_exp_might_become s
  | LandExp (l, r) ->
     (exp_might_become l)@(exp_might_become r)
  | LtExp (l, r) ->
     (exp_might_become l)@(exp_might_become r)
  | GtExp (l, r) ->
     (exp_might_become l)@(exp_might_become r)
  | NeqExp (l, r) ->
     (exp_might_become l)@(exp_might_become r)
  | EqualityExp (l, r) ->
     (exp_might_become l)@(exp_might_become r)
  | AddressExp a ->
     (exp_might_become a)
  | NotExp n ->
     exp_might_become n
  | ArrayAccessExp aa ->
     lexp_might_become aa
  | ValueExp -> []
  | SenderExp -> []
  | ThisExp -> []
  | SingleDereferenceExp e ->
     exp_might_become e
  | TupleDereferenceExp e ->
     exp_might_become e
  | MinusExp (a, b)
  | MultExp (a, b)
  | PlusExp (a, b) ->
     (exp_might_become a)@(exp_might_become b)
  | BalanceExp a ->
     exp_might_become a
and lexp_might_become l =
  match l with
  | ArrayAccessLExp aa ->
     array_access_might_become aa

let variable_init_might_become v =
  exp_might_become v.variable_init_value

let rec sentence_might_become (s : typ sentence) : string list =
  match s with
  | AbortSentence -> []
  | ReturnSentence ret ->
     (match ret.return_exp with
      | Some e -> exp_might_become e
      | None -> []) @
       (exp_might_become ret.return_cont)@
         (match contract_name_of_return_cont ret.return_cont with
          | Some name -> [name]
          | None -> []
         )
  | AssignmentSentence (l, r) ->
     (lexp_might_become l)@
       (exp_might_become r)
  | VariableInitSentence v ->
     variable_init_might_become v
  | IfThenOnly (c, block) ->
     (exp_might_become c)@(sentences_might_become block)
  | IfThenElse (c, b0, b1) ->
     (exp_might_become c)@(sentences_might_become b0)@(sentences_might_become b1)
  | SelfdestructSentence e ->
     exp_might_become e
  | ExpSentence e ->
     exp_might_become e
  | LogSentence (_, lst, _) ->
     exps_might_become lst

and exps_might_become (lst : typ exp list) : string list =
  List.concat (List.map exp_might_become lst)

and sentences_might_become ss =
  List.concat (List.map sentence_might_become ss)


let case_might_become (case : typ case) : string list =
  let body = case.case_body in
  List.concat (List.map sentence_might_become body)

let might_become (c : typ contract) : string list =
  let cases = c.contract_cases in
  List.concat (List.map case_might_become cases)


let lookup_usual_case_in_single_contract c case_name =
  let cases = c.contract_cases in
  let cases = List.filter (fun c -> match c.case_header with
                                     | DefaultCaseHeader -> false
                                     | UsualCaseHeader uc ->
                                        uc.case_name = case_name) cases in
  let () = if (List.length cases = 0) then
             raise Not_found
           else if (List.length cases > 1) then
             let () = Printf.eprintf "case %s duplicated\n%!" case_name in
             failwith "case_lookup"
  in
  match cases with
  | [] -> raise Not_found
  | _ :: _ :: _ -> failwith "should not happen"
  | [a] ->
     begin match a.case_header with
     | UsualCaseHeader uc -> uc
     | DefaultCaseHeader -> failwith "lookup_usual_case_in_single_contract: default case found"
     end

let rec lookup_usual_case_header_inner (already_seen : typ contract list)
                                   (c : typ contract)
                                   (case_name : string) f : usual_case_header =
  if List.mem c already_seen then
    raise Not_found
  else
    try
      lookup_usual_case_in_single_contract c case_name
    with Not_found ->
         let already_seen = c :: already_seen in
         let becomes = List.map f (might_become c) in
         let rec try_becomes bs already_seen =
           (match bs with
            | [] -> raise Not_found
            | h :: tl ->
               (try
                  lookup_usual_case_header_inner already_seen h case_name f
                with Not_found ->
                     let already_seen = h :: already_seen in
                     try_becomes tl already_seen)) in
         try_becomes becomes already_seen

let lookup_usual_case_header (c : typ contract) (case_name : string) f : usual_case_header =
  lookup_usual_case_header_inner [] c case_name f

let size_of_typs (typs : typ list) =
  BatList.sum (List.map size_of_typ typs)

let acceptable_as t0 t1 =
  (t0 = t1) ||
    match t0, t1 with
    | AddressType, ContractInstanceType _ -> true
    | _, _ -> false
