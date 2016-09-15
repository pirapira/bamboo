open Syntax

let assign_type_new_exp
      contract_interfaces
      venv
      e : (typ new_exp * string (* name of the contract just created *)) =
  failwith "atne"

let ident_lookup_type contract_interfaces s =
  failwith "ilt"

let type_variable_init
      contract_interfaces venv (vi : unit variable_init) :
      (typ variable_init * TypeEnv.type_env) =
  failwith "tvi"

let assign_type_lexp
      contract_interfaces
      venv (src : unit lexp) : typ lexp =
  failwith "atl"

let assign_type_call
      contract_interfaces
      venv (src : unit call) : (typ call * typ) =
  failwith "atc"

let assign_type_message_info contract_interfaces tenv :
      unit message_info -> typ message_info =
  failwith "not implemented"

let rec assign_type_exp
      (contract_interfaces : Contract.contract_interface list)
      (venv : TypeEnv.type_env) ((exp_inner, ()) : unit exp) : typ exp =
  match exp_inner with
  | TrueExp -> (TrueExp, BoolType)
  | FalseExp -> (FalseExp, BoolType)
  | CallExp c ->
     let (c', typ) = assign_type_call venv contract_interfaces c in
     (CallExp c', typ)
  | IdentifierExp s ->
     (* Now something is strange. This might not need a type anyway. *)
     (* Maybe introduce a type called CallableType *)
     ident_lookup_type contract_interfaces venv s
  | ParenthExp e ->
     let (e', typ) = assign_type_exp contract_interfaces venv e in
     ((ParenthExp (e', typ)), typ) (* with parentheses, or without, they receive the same type *)
  | NewExp n ->
     let (n', contract_name) = assign_type_new_exp contract_interfaces venv n in
     (NewExp n', ContractType contract_name)
  | LtExp (l, r) ->
     let l' = assign_type_exp contract_interfaces venv l in
     let r' = assign_type_exp contract_interfaces venv r in
     (LtExp (l', r'), BoolType)
  | GtExp (l, r) ->
     let l' = assign_type_exp contract_interfaces venv l in
     let r' = assign_type_exp contract_interfaces venv r in
     (GtExp (l', r'), BoolType)
  | NeqExp (l, r) ->
     let l' = assign_type_exp contract_interfaces venv l in
     let r' = assign_type_exp contract_interfaces venv r in
     (NeqExp (l', r'), BoolType)
  | EqualityExp (l, r) ->
     let l' = assign_type_exp contract_interfaces venv l in
     let r' = assign_type_exp contract_interfaces venv r in
     (EqualityExp (l', r'), BoolType)
  | NotExp negated ->
     let negated' = assign_type_exp contract_interfaces venv negated in
     (NotExp negated', BoolType)
  | AddressExp inner ->
     let inner' = assign_type_exp contract_interfaces venv inner in
     (AddressExp inner', AddressType)
  | ArrayAccessExp aa ->
     let atyp = TypeEnv.lookup venv aa.array_access_array in
     begin match atyp with
     | Some (MappingType (key_type, value_type)) ->
        let (idx', idx_typ') = assign_type_exp contract_interfaces venv aa.array_access_index in
        (* TODO Check idx_typ' and key_type are somehow compatible *)
        (ArrayAccessExp
           { array_access_array = aa.array_access_array
           ; array_access_index = (idx', idx_typ')
           }, value_type)
     | _ -> failwith "index access haa to be on mappings"
     end
  | SendExp send ->
     let msg_info' = assign_type_message_info contract_interfaces venv
                                           send.send_msg_info in
     let contract' = assign_type_exp contract_interfaces venv send.send_head_contract in
     let contract_name = Syntax.contract_name_of contract' in
     let method_sig : Ethereum.function_signature = begin
         match Contract.find_method_signature
                 contract_interfaces contract_name send.send_head_method with
         | Some x -> x
         | None -> failwith "method not found"
       end
     in
     ( SendExp
         { send_head_contract = contract'
         ; send_head_method = send.send_head_method
         ; send_args = List.map (assign_type_exp contract_interfaces venv)
                              send.send_args
         ; send_msg_info = msg_info'
         },
       Ethereum.to_typ (List.hd method_sig.Ethereum.sig_return)
     )

let assign_type_return
      (contract_interfaces : Contract.contract_interface list)
      (venv : TypeEnv.type_env)
      (src : unit return) : typ return =
  { return_value = assign_type_exp contract_interfaces venv src.return_value
  ; return_cont =  assign_type_exp contract_interfaces venv src.return_cont
  }

let rec assign_type_sentence
      (contract_interfaces : Contract.contract_interface list)
      (venv : TypeEnv.type_env)
      (src : unit sentence) :
      (typ sentence * TypeEnv.type_env (* updated environment *)) =
  match src with
  | AbortSentence -> (AbortSentence, venv)
  | ReturnSentence r ->
     let r' =
       assign_type_return contract_interfaces venv r in
     (ReturnSentence r', venv)
  | AssignmentSentence (l, r) ->
     let l' = assign_type_lexp contract_interfaces venv l in
     let r' = assign_type_exp contract_interfaces venv r in
     (AssignmentSentence (l', r'), venv)
  | IfSingleSentence (cond, s) ->
     let cond' = assign_type_exp contract_interfaces venv cond in
     let (s', _ (* new variable in the if-body does not affect the context*) )
       = assign_type_sentence
           contract_interfaces
           venv s in
     (IfSingleSentence (cond', s'), venv)
  | SelfdestructSentence e ->
     let e' = assign_type_exp contract_interfaces venv e in
     (SelfdestructSentence e', venv)
  | VariableInitSentence vi ->
     let (vi', venv') =  type_variable_init contract_interfaces venv vi in
     (VariableInitSentence vi', venv')

let rec assign_type_sentences
          (contract_interfaces : Contract.contract_interface list)
          (variable_environment : TypeEnv.type_env)
          (ss : unit sentence list) : typ sentence list =
  match ss with
  | [] -> []
  | first_s :: rest_ss ->
     let (first_s', (updated_environment : TypeEnv.type_env)) =
       assign_type_sentence
         contract_interfaces variable_environment first_s in
     first_s' :: assign_type_sentences contract_interfaces
                                       updated_environment
                                       rest_ss


let assign_type_case (contract_interfaces : Contract.contract_interface list)
                     (venv : TypeEnv.type_env)
                     (case : unit case) =
  let case_arguments = case_header_arg_list case.case_header in
  { case_header = case.case_header
  ; case_body = assign_type_sentences
                  contract_interfaces
                  (TypeEnv.add_block case_arguments venv)
                  case.case_body
  }


let assign_type_contract (env : Contract.contract_interface list)
      (raw : unit Syntax.contract) :
      Syntax.typ Syntax.contract =
  let tenv = TypeEnv.(add_block raw.contract_arguments empty_type_env) in
  { contract_name = raw.contract_name
  ; contract_arguments = raw.contract_arguments
  ; contract_cases =
      List.map (assign_type_case env tenv) raw.contract_cases
  }

let assign_types (raw : unit Syntax.contract list) :
      Syntax.typ Syntax.contract list =
  let interfaces = List.map Contract.contract_interface_of raw in
  List.map (assign_type_contract interfaces) raw
