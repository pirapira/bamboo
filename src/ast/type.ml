open Syntax

let assign_type_lexp
      venv (src : unit lexp) : typ lexp =
  failwith "atl"

let assign_type_exp
      venv (src : unit exp) : typ exp =
  failwith "atl"

let assign_type_return
      contract_interfaces
      contract_arguments
      venv
      (src : unit return) : typ return =
  failwith "assign_type_return"

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
     let l' = assign_type_lexp venv l in
     let r' = assign_type_exp venv r in
     (AssignmentSentence (l', r'), venv)
  | IfSingleSentence (cond, s) ->
     let cond' = assign_type_exp venv cond in
     let (s', _ (* new variable in the if-body does not affect the context*) )
       = assign_type_sentence
           contract_interfaces
           contract_arguments
           venv s in
     (IfSingleSentence (cond', s'), venv)

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
