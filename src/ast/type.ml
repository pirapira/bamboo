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
      (typ variable_init * arg list) =
  failwith "tvi"

let assign_type_lexp
      contract_interfaces
      venv (src : unit lexp) : typ lexp =
  failwith "atl"

let assign_type_call
      contract_interfaces
      venv (src : unit call) : (typ call * typ) =
  failwith "atc"

let rec assign_type_exp
      contract_interfaces
      venv ((exp_inner, ()) : unit exp) : typ exp =
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

let assign_type_return
      contract_interfaces
      contract_arguments
      venv
      (src : unit return) : typ return =
  { return_value = assign_type_exp contract_interfaces venv src.return_value
  ; return_cont =  assign_type_exp contract_interfaces venv src.return_cont
  }

let rec assign_type_sentence
      contract_interfaces
      contract_arguments
      (venv : arg list)
      (src : unit sentence) :
      (typ sentence * arg list (* updated environment *)) =
  match src with
  | AbortSentence -> (AbortSentence, venv)
  | ReturnSentence r ->
     let r' =
       assign_type_return contract_interfaces contract_arguments venv r in
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
           contract_arguments
           venv s in
     (IfSingleSentence (cond', s'), venv)
  | SelfdestructSentence e ->
     let e' = assign_type_exp contract_interfaces venv e in
     (SelfdestructSentence e', venv)
  | VariableInitSentence vi ->
     let (vi', venv') =  type_variable_init contract_interfaces venv vi in
     (VariableInitSentence vi', venv')

let rec assign_type_sentences
          contract_interfaces
          contract_arguments
          (variable_environment : arg list)
          (ss : unit sentence list) : typ sentence list =
  match ss with
  | [] -> []
  | first_s :: rest_ss ->
     let (first_s', (updated_environment : arg list)) =
       assign_type_sentence
         contract_interfaces contract_arguments variable_environment first_s in
     first_s' :: assign_type_sentences contract_interfaces
                                       contract_arguments
                                       updated_environment
                                       rest_ss


let assign_type_case contract_interfaces contract_arguments
                     (case : unit case) =
  let case_arguments = case_header_arg_list case.case_header in
  { case_header = case.case_header
  ; case_body = assign_type_sentences
                  contract_interfaces
                  contract_arguments
                  case_arguments
                  case.case_body
  }


let assign_type_contract (env : Contract.contract_interface list)
      (raw : unit Syntax.contract) :
      Syntax.typ Syntax.contract =
  { contract_name = raw.contract_name
  ; contract_arguments = raw.contract_arguments
  ; contract_cases =
      List.map (assign_type_case env raw.contract_arguments) raw.contract_cases
  }

let assign_types (raw : unit Syntax.contract list) :
      Syntax.typ Syntax.contract list =
  let interfaces = List.map Contract.contract_interface_of raw in
  List.map (assign_type_contract interfaces) raw
