open Syntax


let ident_lookup_type
      (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
      (tenv : TypeEnv.type_env) id : (typ * SideEffect.t list) exp =
  match TypeEnv.lookup tenv id with
  | Some (typ, Some loc) -> (IdentifierExp id, (typ, [loc, SideEffect.Read]))
  | Some (typ, None) -> (IdentifierExp id, (typ, []))
  | None -> failwith ("unknown identifier "^id)
  (* what should it return when it is a method name? *)

let is_known_contract contract_interfaces name =
  List.exists (fun (_, i) -> i.Contract.contract_interface_name = name) contract_interfaces

let rec is_known_type (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc) (t : typ) =
  Syntax.(
    match t with
    | Uint256Type -> true
    | Uint8Type -> true
    | Bytes32Type -> true
    | AddressType -> true
    | BoolType -> true
    | ReferenceType lst ->
       List.for_all (is_known_type contract_interfaces) lst
    | TupleType lst ->
       List.for_all (is_known_type contract_interfaces) lst
    | MappingType (a, b) ->
       is_known_type contract_interfaces a && is_known_type contract_interfaces b
    | ContractArchType contract ->
       is_known_contract contract_interfaces contract
    | ContractInstanceType contract ->
       is_known_contract contract_interfaces contract
    | VoidType -> true
  )

let arg_has_known_type contract_interfaces arg =
  let ret = is_known_type contract_interfaces arg.arg_typ in
  if not ret then Printf.eprintf "argument has an unknown type %s\n" (Syntax.string_of_typ arg.arg_typ);
  ret

let ret_type_is_known contract_interfaces header =
  List.for_all (is_known_type contract_interfaces) header.case_return_typ

let assign_type_case_header contract_interfaces header =
  match header with
  | UsualCaseHeader header ->
     let () = assert (List.for_all (arg_has_known_type contract_interfaces) header.case_arguments) in
     let () = assert (ret_type_is_known contract_interfaces header) in
     UsualCaseHeader header
  | DefaultCaseHeader ->
     DefaultCaseHeader

let call_arg_expectations (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc) mtd : typ list -> bool =
  match mtd with
  | "pre_ecdsarecover" ->
     (fun x -> x = [Bytes32Type; Uint8Type; Bytes32Type; Bytes32Type])
  | "keccak256" ->
     (fun _ -> true)
  | "iszero" ->
     (fun x -> x = [Bytes32Type] || x = [Uint8Type] || x = [Uint256Type] || x = [BoolType] || x = [AddressType])
  | name ->
     let cid = Assoc.lookup_id (fun c -> c.Contract.contract_interface_name = name) contract_interfaces in
     let interface : Contract.contract_interface = Assoc.choose_contract cid contract_interfaces in
     (fun x -> x = interface.Contract.contract_interface_args)

let type_check ((exp : typ), ((_,(t, _)) : (typ * 'a) exp)) =
  assert (exp = t)

let check_args_match (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc) (args : (typ * 'x) exp list) (call_head : string option) =
  let expectations : typ list -> bool =
    match call_head with
    | Some mtd ->
       call_arg_expectations contract_interfaces mtd
    | None ->
       (fun x -> x = [])
  in
  assert (expectations (List.map (fun x -> (fst (snd x))) args))

let typecheck_multiple (exps : typ list) (actual : (typ * 'a) exp list) =
  List.for_all2 (fun e (_, (a, _)) -> e = a) exps actual

let check_only_one_side_effect (llst : SideEffect.t list list)  =
  (* write-write *)
  if List.length (List.filter (fun x ->
                      List.exists (fun s -> snd s = SideEffect.Write) x
                    ) llst) > 1 then
    failwith "more than one sub-expressions have side-effects";
  (* read-write *)
  if List.length (List.filter (fun x ->
                      List.exists (fun s -> snd s = SideEffect.Write) x
                    ) llst) = 0 then ()
  else
  if List.length (List.filter (fun x ->
                      List.exists (fun s -> snd s = SideEffect.Read) x
                    ) llst) > 0 then
    failwith "some sub-expressions have write effects and some have read effects"

let has_no_side_effects (e : (typ * SideEffect.t list) exp) =
  snd (snd e) = []

let rec assign_type_call
      contract_interfaces
      cname
      venv (src : unit function_call) : ((typ * SideEffect.t list) function_call * (typ * SideEffect.t list)) =
  let args' = List.map (assign_type_exp contract_interfaces cname venv)
                       src.call_args in
  let () = check_args_match contract_interfaces args' (Some src.call_head) in
  let args_side_effects : SideEffect.t list list = List.map (fun (_, (_, s)) -> s) args' in
  let () = check_only_one_side_effect args_side_effects in
  let side_effects = (SideEffect.External, SideEffect.Write) :: List.concat args_side_effects in
  let ret_typ =
    match src.call_head with
    | "value" when true (* check the argument is 'msg' *) -> Uint256Type
    | "pre_ecdsarecover" -> AddressType
    | "keccak256" -> Bytes32Type
    | "iszero" -> (match args' with
                   | [arg] -> BoolType
                   | _ -> failwith "should not happen")
    | contract_name
      when true (* check the contract exists*) -> ContractArchType contract_name
    | _ -> failwith "assign_type_call: should not happen"
    in
  ({ call_head = src.call_head
     ; call_args = args' },
   (ret_typ, side_effects))
and assign_type_message_info contract_interfaces cname tenv
                             (orig : unit message_info) : (typ * SideEffect.t list) message_info =
  let v' = WrapOption.map (assign_type_exp contract_interfaces cname tenv)
                            orig.message_value_info in
  let block' = assign_type_sentences contract_interfaces cname tenv orig.message_reentrance_info in
  { message_value_info = v'
  ; message_reentrance_info = block'
  }
and assign_type_exp
      (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
      (cname : string)
      (venv : TypeEnv.type_env) ((exp_inner, ()) : unit exp) : (typ * SideEffect.t list) exp =
  match exp_inner with
  | ThisExp -> (ThisExp, (ContractInstanceType cname, []))
  | TrueExp -> (TrueExp, (BoolType, []))
  | FalseExp -> (FalseExp, (BoolType, []))
  | SenderExp -> (SenderExp, (AddressType, []))
  | NowExp -> (NowExp, (Uint256Type, []))
  | FunctionCallExp c ->
     let (c', typ) = assign_type_call contract_interfaces cname venv c in
     (FunctionCallExp c', typ)
  | DecLit256Exp d -> (DecLit256Exp d, (Uint256Type, []))
  | DecLit8Exp d -> (DecLit8Exp d, (Uint8Type, []))
  | IdentifierExp s ->
     (* Now something is strange. This might not need a type anyway. *)
     (* Maybe introduce a type called CallableType *)
     let () =
       if WrapString.starts_with s "pre_" then
         failwith "names that start with pre_ are reserved" in
     ident_lookup_type contract_interfaces venv s
  | ParenthExp e ->
     (* omit the parenthesis at this place, the tree already contains the structure *)
     assign_type_exp contract_interfaces cname venv e
  | NewExp n ->
     let (n', contract_name) = assign_type_new_exp contract_interfaces cname venv n in
     let () =
       if WrapString.starts_with contract_name "pre_" then
         failwith "names that start with pre_ are reserved" in
     (NewExp n', (ContractInstanceType contract_name, [SideEffect.External, SideEffect.Write]))
  | LandExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let () = type_check (BoolType, l) in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = type_check (BoolType, r) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     (LandExp (l, r), (BoolType, List.concat sides))
  | LtExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     let () = assert (fst (snd l) = fst (snd r)) in
     (LtExp (l, r), (BoolType, List.concat sides))
  | GtExp (l, r) ->
     let l' = assign_type_exp contract_interfaces cname venv l in
     let r' = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l') = fst (snd r')) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l'; r']) in
     let () = check_only_one_side_effect sides in
     (GtExp (l', r'), (BoolType, List.concat sides))
  | NeqExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l) = fst (snd r)) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     (NeqExp (l, r), (BoolType, List.concat sides))
  | EqualityExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l) = fst (snd r)) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     (EqualityExp (l, r), (BoolType, List.concat sides))
  | PlusExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l) = fst (snd r)) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     (PlusExp (l, r), (fst (snd l), List.concat sides))
  | MinusExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l) = fst (snd r)) in
     let sides = (List.map (fun (_, (_, x)) -> x) [l; r]) in
     let () = check_only_one_side_effect sides in
     (MinusExp (l, r), (fst (snd l), List.concat sides))
  | MultExp (l, r) ->
     let l = assign_type_exp contract_interfaces cname venv l in
     let r = assign_type_exp contract_interfaces cname venv r in
     let () = assert (fst (snd l) = fst (snd r)) in
     (MultExp (l, r), snd l)
  | NotExp negated ->
     let negated = assign_type_exp contract_interfaces cname venv negated in
     let () = assert (fst (snd negated) = BoolType) in
     (NotExp negated, (BoolType, snd (snd negated)))
  | AddressExp inner ->
     let inner' = assign_type_exp contract_interfaces cname venv inner in
     (AddressExp inner', (AddressType, snd (snd inner')))
  | BalanceExp inner ->
     let inner = assign_type_exp contract_interfaces cname venv inner in
     let () = assert (acceptable_as AddressType (fst (snd inner))) in
     let () = assert (snd (snd inner) = []) in
     (BalanceExp inner, (Uint256Type, [SideEffect.External, SideEffect.Read]))
  | ArrayAccessExp aa ->
     let atyped = assign_type_exp contract_interfaces cname venv (read_array_access aa).array_access_array in
     begin match fst (snd atyped) with
     | MappingType (key_type, value_type) ->
        let (idx', (idx_typ', idx_side')) = assign_type_exp contract_interfaces cname venv (read_array_access aa).array_access_index in
        let () = assert (acceptable_as key_type idx_typ') in
        let () = assert (List.for_all (fun x -> x = (SideEffect.Storage, SideEffect.Read)) idx_side') in
        (* TODO Check idx_typ' and key_type are somehow compatible *)
        (ArrayAccessExp (ArrayAccessLExp
           { array_access_array = atyped
           ; array_access_index = (idx', (idx_typ', idx_side'))
           }), (value_type, [SideEffect.Storage, SideEffect.Read]))
     | _ -> failwith "index access has to be on mappings"
     end
  | SendExp send ->
     let msg_info' = assign_type_message_info contract_interfaces cname venv
                                           send.send_msg_info in
     let contract' = assign_type_exp contract_interfaces cname venv send.send_head_contract in
     begin match send.send_head_method with
     | Some mtd ->
        let contract_name = Syntax.contract_name_of_instance contract' in
        let method_sig : Ethereum.function_signature = begin
            match Contract.find_method_signature
                    contract_interfaces contract_name mtd with
            | Some x -> x
            | None -> failwith ("method "^mtd^" not found")
          end
        in
        let types = Ethereum.(List.map to_typ (method_sig.sig_return)) in
        let args = List.map (assign_type_exp contract_interfaces cname venv)
                                     send.send_args in
        let () = assert (List.for_all has_no_side_effects args) in
        let reference : (Syntax.typ * SideEffect.t list) exp =
          ( SendExp
              { send_head_contract = contract'
              ; send_head_method = send.send_head_method
              ; send_args = args
              ; send_msg_info = msg_info'
              },
            (ReferenceType types, [SideEffect.External, SideEffect.Write])
          ) in
        (match types with
         | [single] -> (SingleDereferenceExp reference, (single, [SideEffect.External, SideEffect.Write]))
         | _ -> reference)
     | None ->
        let () = assert (send.send_args = []) in
        ( SendExp
            { send_head_contract = contract'
            ; send_head_method = None
            ; send_args = []
            ; send_msg_info = msg_info'
            }, (VoidType, [SideEffect.External, SideEffect.Write]) )
     end
  | ValueExp ->
     (ValueExp, (Uint256Type, []))
  | SingleDereferenceExp _
  | TupleDereferenceExp _ ->
     failwith "DereferenceExp not supposed to appear in the raw tree for now"
and assign_type_new_exp
      contract_interfaces
      (cname : string)
      (tenv : TypeEnv.type_env)
      (e : unit new_exp) : ((typ * SideEffect.t list) new_exp * string (* name of the contract just created *)) =
  let msg_info' = assign_type_message_info contract_interfaces
                                           cname tenv e.new_msg_info in
  let args' = List.map (assign_type_exp contract_interfaces cname tenv) e.new_args in
  let e' =
    { new_head = e.new_head
    ; new_args = args'
    ; new_msg_info = msg_info'
    }
  in
  (e',
   e.new_head
  )
and assign_type_lexp
      contract_interfaces
      (cname : string)
      venv (src : unit lexp) : (typ * SideEffect.t list) lexp =
  (* no need to type the left hand side? *)
  match src with
  | ArrayAccessLExp aa ->
     let atyped = assign_type_exp contract_interfaces cname venv aa.array_access_array in
     begin match fst (snd atyped) with
     | MappingType (key_type, value_type) ->
        let (idx', idx_typ') = assign_type_exp contract_interfaces
                                               cname venv
                                               aa.array_access_index in
        (* TODO Check idx_typ' and key_type are somehow compatible *)
        (ArrayAccessLExp
           { array_access_array = atyped
           ; array_access_index = (idx', idx_typ')})
     | _ -> failwith ("unknown array")
     end
and assign_type_return
      (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
      (cname : string)
      (tenv : TypeEnv.type_env)
      (src : unit return) : (typ * SideEffect.t list) return =
  let exps = WrapOption.map (assign_type_exp contract_interfaces
                                   cname tenv) src.return_exp in
  let f = TypeEnv.lookup_expected_returns tenv in
  let () = assert (f (WrapOption.map (fun x -> (fst (snd x))) exps)) in
  { return_exp = exps
  ; return_cont =  assign_type_exp contract_interfaces
                                   cname tenv src.return_cont
  }
and type_variable_init
      contract_interfaces cname tenv (vi : unit variable_init) :
      ((typ * SideEffect.t list) variable_init * TypeEnv.type_env) =
  (* This function has to enlarge the type environment *)
  let value' = assign_type_exp contract_interfaces
                               cname tenv vi.variable_init_value in
  let added_name = vi.variable_init_name in
  let () =
    if WrapString.starts_with added_name "pre_" then
      failwith "names that start with pre_ are reserved" in
  let added_typ = vi.variable_init_type in
  let () = assert (is_known_type contract_interfaces added_typ) in
  let new_env = TypeEnv.add_pair tenv added_name added_typ None in
  let new_init =
    { variable_init_type = added_typ
    ; variable_init_name = added_name
    ; variable_init_value = value'
    } in
  (new_init, new_env)
and assign_type_sentence
      (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
      (cname : string)
      (venv : TypeEnv.type_env)
      (src : unit sentence) :
      ((typ * SideEffect.t list) sentence * TypeEnv.type_env (* updated environment *)) =
  match src with
  | AbortSentence -> (AbortSentence, venv)
  | ReturnSentence r ->
     let r' =
       assign_type_return contract_interfaces cname venv r in
     (ReturnSentence r', venv)
  | AssignmentSentence (l, r) ->
     let l' = assign_type_lexp contract_interfaces cname venv l in
     let r' = assign_type_exp contract_interfaces cname venv r in
     (AssignmentSentence (l', r'), venv)
  | IfThenOnly (cond, ss) ->
     let cond' = assign_type_exp contract_interfaces cname venv cond in
     let ss'
       = assign_type_sentences
           contract_interfaces cname venv ss in
     (IfThenOnly (cond', ss'), venv)
  | IfThenElse (cond, sst, ssf) ->
     let cond' = assign_type_exp contract_interfaces cname venv cond in
     let sst' = assign_type_sentences contract_interfaces cname venv sst in
     let ssf' = assign_type_sentences contract_interfaces cname venv ssf in
     (IfThenElse (cond', sst', ssf'), venv)
  | SelfdestructSentence e ->
     let e' = assign_type_exp contract_interfaces cname venv e in
     (SelfdestructSentence e', venv)
  | VariableInitSentence vi ->
     let (vi', venv') =  type_variable_init contract_interfaces cname venv vi in
     (VariableInitSentence vi', venv')
  | ExpSentence exp ->
     let exp = assign_type_exp contract_interfaces cname venv exp in
     let () = assert (fst (snd exp) = VoidType) in
     let () = assert (List.exists (fun (_, x) -> x = SideEffect.Write) (snd (snd exp))) in
     (ExpSentence exp, venv)
  | LogSentence (name, args, _) ->
     let args = List.map (assign_type_exp contract_interfaces cname venv) args in
     let event = TypeEnv.lookup_event venv name in
     let type_expectations =
       List.map (fun ea -> Syntax.(ea.event_arg_body.arg_typ)) event.Syntax.event_arguments in
     let () = assert (typecheck_multiple type_expectations args) in
     let side_effects = List.map (fun (_, (_, a)) -> a) args in
     let () = check_only_one_side_effect side_effects in
     (LogSentence (name, args, Some event), venv)

and assign_type_sentences
          (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
          (cname : string)
          (type_environment : TypeEnv.type_env)
          (ss : unit sentence list) : (typ * SideEffect.t list) sentence list =
  match ss with
  | [] -> []
  | first_s :: rest_ss ->
     let (first_s', (updated_environment : TypeEnv.type_env)) =
       assign_type_sentence
         contract_interfaces cname type_environment first_s in
     first_s' :: assign_type_sentences contract_interfaces
                                       cname
                                       updated_environment
                                       rest_ss

type termination =
  RunAway | ReturnValues of int | JustStop

let rec is_terminating_sentence (s : unit sentence) : termination list =
  match s with
  | AbortSentence -> [JustStop]
  | ReturnSentence ret ->
     begin match ret.return_exp with
     | Some _ -> [ReturnValues 1]
     | None -> [ReturnValues 0]
     end
  | AssignmentSentence _ -> [RunAway]
  | VariableInitSentence _ -> [RunAway]
  | IfThenOnly (_, b) -> (are_terminating b) @ [RunAway] (* there is a continuation if the condition does not hold. *)
  | IfThenElse (_, bT, bF) -> are_terminating bT @ (are_terminating bF)
  | SelfdestructSentence _ -> [JustStop]
  | ExpSentence _ -> [RunAway]
  | LogSentence _ -> [RunAway]

(** [check_termination sentences] make sure that the last sentence in [sentences]
 *  cuts the continuation. *)
and are_terminating sentences =
  let last_sentence = WrapList.last sentences in
  is_terminating_sentence last_sentence

let case_is_returning_void (case : unit case) : bool =
  match case.case_header with
  | DefaultCaseHeader -> true
  | UsualCaseHeader u ->
     u.case_return_typ = []

let return_expectation_of_case (h : Syntax.case_header) (actual : Syntax.typ option) : bool =
  match h, actual with
  | DefaultCaseHeader, Some _ -> false
  | DefaultCaseHeader, None -> true
  | UsualCaseHeader u, _ ->
     begin match u.case_return_typ, actual with
     | _ :: _ :: _, _ -> false
     | [x], Some y -> Syntax.acceptable_as x y
     | [], None -> true
     | _, _ ->false
     end

let assign_type_case (contract_interfaces : Contract.contract_interface Assoc.contract_id_assoc)
                     (contract_name : string)
                     (venv : TypeEnv.type_env)
                     (case : unit case) =
  let () = assert (List.for_all (fun t ->
                       match t with
                       | RunAway -> false
                       | ReturnValues 0 ->
                          case_is_returning_void case
                       | ReturnValues 1 ->
                          not (case_is_returning_void case)
                       | ReturnValues _ ->
                          failwith "returning multiple values not supported yet"
                       | JustStop -> true
                     ) (are_terminating case.case_body)) in
  let case_arguments = case_header_arg_list case.case_header in
  let () =
    if List.exists (fun arg -> WrapString.starts_with arg.arg_ident "pre_") case_arguments then
      failwith "names that start with pre_ are reserved" in
  let returns : Syntax.typ option -> bool = return_expectation_of_case case.case_header in
  { case_header = assign_type_case_header contract_interfaces case.case_header
  ; case_body = assign_type_sentences
                  contract_interfaces
                  contract_name
                  (TypeEnv.remember_expected_returns (TypeEnv.add_block case_arguments venv) returns)
                  case.case_body
  }

let has_distinct_signatures (c : unit Syntax.contract) : bool =
  let cases = c.contract_cases in
  let signatures = List.map
                     (fun c ->
                       match c.case_header with
                       | UsualCaseHeader u -> Some (Ethereum.case_header_signature_string u)
                       | DefaultCaseHeader -> None) cases in
  let unique_sig = WrapList.unique signatures in
  List.length signatures = List.length unique_sig


let assign_type_contract (env : Contract.contract_interface Assoc.contract_id_assoc)
                         (events: event Assoc.contract_id_assoc)
      (raw : unit Syntax.contract) :
      (Syntax.typ * SideEffect.t list) Syntax.contract =
  let () = assert (List.for_all (arg_has_known_type env) raw.contract_arguments) in
  let () = assert (has_distinct_signatures raw) in
  let tenv = TypeEnv.(add_block raw.contract_arguments (add_events events empty_type_env)) in
  let () =
    if WrapString.starts_with raw.contract_name "pre_" then
      failwith "names that start with pre_ are reserved" in
  let () =
    if List.exists (fun arg -> WrapString.starts_with arg.arg_ident "pre_") raw.contract_arguments then
      failwith "names that start with pre_ are reserved" in
  { contract_name = raw.contract_name
  ; contract_arguments = raw.contract_arguments
  ; contract_cases =
      List.map (assign_type_case env raw.contract_name tenv) raw.contract_cases
  }

let assign_type_toplevel (interfaces : Contract.contract_interface Assoc.contract_id_assoc)
                         (events : event Assoc.contract_id_assoc)
                         (raw : unit Syntax.toplevel) :
      (Syntax.typ * SideEffect.t list) Syntax.toplevel =
  match raw with
  | Contract c ->
     Contract (assign_type_contract interfaces events c)
  | Event e ->
     Event e

(* XXX: these [strip_side_effects_X] should be generalized over any f : 'a -> 'b *)

let rec strip_side_effects_sentence (raw : (typ * 'a) sentence) : typ sentence =
  match raw with
  | AbortSentence -> AbortSentence
  | ReturnSentence ret -> ReturnSentence (strip_side_effects_return ret)
  | AssignmentSentence (l, r) ->
     AssignmentSentence (strip_side_effects_lexp l, strip_side_effects_exp r)
  | VariableInitSentence v ->
     VariableInitSentence (strip_side_effects_variable_init v)
  | IfThenOnly (e, block) ->
     IfThenOnly (strip_side_effects_exp e, strip_side_effects_case_body block)
  | IfThenElse (e, b0, b1) ->
     IfThenElse ((strip_side_effects_exp e), (strip_side_effects_case_body b0),
                 (strip_side_effects_case_body b1))
  | SelfdestructSentence e ->
     SelfdestructSentence (strip_side_effects_exp e)
  | ExpSentence e ->
     ExpSentence (strip_side_effects_exp e)
  | LogSentence (str, args, eopt) ->
     LogSentence (str, List.map strip_side_effects_exp args, eopt)
and strip_side_effects_variable_init v =
  { variable_init_type = v.variable_init_type
  ; variable_init_name = v.variable_init_name
  ; variable_init_value = strip_side_effects_exp v.variable_init_value
  }
and strip_side_effects_aa aa =
  { array_access_array = strip_side_effects_exp aa.array_access_array
  ; array_access_index = strip_side_effects_exp aa.array_access_index
  }
and strip_side_effects_lexp lexp =
  match lexp with
  | ArrayAccessLExp aa ->
     ArrayAccessLExp (strip_side_effects_aa aa)
and strip_side_effects_exp (i, (t, _)) =
  (strip_side_effects_exp_inner i, t)
and strip_side_effects_function_call fc =
  { call_head = fc.call_head
  ; call_args = List.map strip_side_effects_exp fc.call_args
  }
and strip_side_effects_msg_info m =
  { message_value_info = WrapOption.map strip_side_effects_exp m.message_value_info
  ; message_reentrance_info =
      List.map strip_side_effects_sentence m.message_reentrance_info
  }
and strip_side_effects_send s =
  { send_head_contract = strip_side_effects_exp s.send_head_contract
  ; send_head_method = s.send_head_method
  ; send_args = List.map strip_side_effects_exp s.send_args
  ; send_msg_info = strip_side_effects_msg_info s.send_msg_info
  }
and strip_side_effects_new_exp n =
  { new_head = n.new_head
  ; new_args = List.map strip_side_effects_exp n.new_args
  ; new_msg_info = strip_side_effects_msg_info n.new_msg_info
  }
and strip_side_effects_exp_inner i =
  match i with
  | TrueExp -> TrueExp
  | FalseExp -> FalseExp
  | DecLit256Exp d -> DecLit256Exp d
  | DecLit8Exp d -> DecLit8Exp d
  | NowExp -> NowExp
  | FunctionCallExp fc ->
     FunctionCallExp (strip_side_effects_function_call fc)
  | IdentifierExp str ->
     IdentifierExp str
  | ParenthExp e ->
     ParenthExp (strip_side_effects_exp e)
  | NewExp e ->
     NewExp (strip_side_effects_new_exp e)
  | SendExp send ->
     SendExp (strip_side_effects_send send)
  | LandExp (a, b) ->
     LandExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | LtExp (a, b) ->
     LtExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | GtExp (a, b) ->
     GtExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | NeqExp (a, b) ->
     NeqExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | EqualityExp (a, b) ->
     EqualityExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | AddressExp a ->
     AddressExp (strip_side_effects_exp a)
  | NotExp e ->
     NotExp (strip_side_effects_exp e)
  | ArrayAccessExp l ->
     ArrayAccessExp (strip_side_effects_lexp l)
  | ValueExp -> ValueExp
  | SenderExp -> SenderExp
  | ThisExp -> ThisExp
  | SingleDereferenceExp e ->
     SingleDereferenceExp (strip_side_effects_exp e)
  | TupleDereferenceExp e ->
     TupleDereferenceExp (strip_side_effects_exp e)
  | PlusExp (a, b) ->
     PlusExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | MinusExp (a, b) ->
     MinusExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | MultExp (a, b) ->
     MultExp (strip_side_effects_exp a, strip_side_effects_exp b)
  | BalanceExp e ->
     BalanceExp (strip_side_effects_exp e)
and strip_side_effects_return ret =
  { return_exp = WrapOption.map strip_side_effects_exp ret.return_exp
  ; return_cont = strip_side_effects_exp ret.return_cont
  }
and strip_side_effects_case_body (raw : (typ * 'a) case_body) : typ case_body =
  List.map strip_side_effects_sentence raw

let strip_side_effects_case (raw : (typ * 'a) case) : typ case =
  { case_header = raw.case_header
  ; case_body = strip_side_effects_case_body raw.case_body
  }

let strip_side_effects_contract (raw : (typ * 'a) contract) : typ contract =
  { contract_name = raw.contract_name
  ; contract_arguments = raw.contract_arguments
  ; contract_cases = List.map strip_side_effects_case raw.contract_cases
  }

let strip_side_effects (raw : (typ * 'a) Syntax.toplevel) : typ Syntax.toplevel =
  match raw with
  | Contract c ->
     Contract (strip_side_effects_contract c)
  | Event e -> Event e

let has_distinct_contract_names (contracts : unit Syntax.contract Assoc.contract_id_assoc) : bool =
  let contract_names = (List.map (fun (_, b) -> b.Syntax.contract_name) contracts) in
  List.length contracts = List.length (WrapList.unique contract_names)

let assign_types (raw : unit Syntax.toplevel Assoc.contract_id_assoc) :
      Syntax.typ Syntax.toplevel Assoc.contract_id_assoc =
  let raw_contracts : unit Syntax.contract Assoc.contract_id_assoc =
    Assoc.filter_map (fun x ->
                          match x with
                          | Contract c -> Some c
                          | _ -> None
                        ) raw in
  let () = assert(has_distinct_contract_names(raw_contracts)) in
  let interfaces = Assoc.map Contract.contract_interface_of raw_contracts in
  let events : event Assoc.contract_id_assoc =
    Assoc.filter_map (fun x ->
        match x with
        | Event e -> Some e
        | _ -> None) raw in
  Assoc.map strip_side_effects
    (Assoc.map (assign_type_toplevel interfaces events) raw)
