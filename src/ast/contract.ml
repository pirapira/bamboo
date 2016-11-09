type case_interface = Ethereum.function_signature

let case_interface_of (raw : unit Syntax.case) : case_interface =
  match Syntax.(raw.case_header) with
  | Syntax.UsualCaseHeader header ->
     { Ethereum.sig_return =
         List.map Ethereum.interpret_interface_type Syntax.(header.case_return_typ)
     ; sig_name = Syntax.(header.case_name)
     ; sig_args =
         List.map Ethereum.interpret_interface_type
                  Syntax.(List.map (fun x -> x.arg_typ) header.case_arguments)
     }
  | Syntax.DefaultCaseHeader ->
     { Ethereum.sig_return = []
     ; sig_name = "" (* is this a good choice? *)
     ; sig_args = []
     }

type contract_interface =
  { contract_interface_name : string
    (** [contract_interface_name] is the name of the contract. *)
  ; contract_interface_args : Syntax.typ list
    (* Since [contract_interface_args] contains bool[address] and such,
     * is's not appropriate to use the ABI signature here.
     * As a work around, at the time of deployment, these
     * arrays are zeroed out.
     *)
  ; contract_interface_cases : case_interface list
  ; contract_interface_continuations : string list
    (** [contract_interface_transitions] lists the names of contracts that
        this one can continue into *)
  }

let rec collect_continuation_in_sentence (raw : unit Syntax.sentence) : string list =
  Syntax.(
    match raw with
    | AbortSentence -> []
    | ReturnSentence r ->
       begin
         match contract_name_of_return_cont r.return_cont with
         | None -> []
         | Some name -> [name]
       end
    | AssignmentSentence (_, _) -> []
    | VariableInitSentence _ -> []
    | SelfdestructSentence _ -> []
    | IfSingleSentence (_, s) ->
       collect_continuation_in_sentence s
  )

let collect_continuation_in_case (raw : unit Syntax.case) : string list =
  List.concat Syntax.(List.map collect_continuation_in_sentence raw.case_body)

let collect_continuation_in_contract (raw : unit Syntax.contract) : string list =
  List.concat Syntax.(List.map collect_continuation_in_case raw.contract_cases)

let contract_interface_of (raw : unit Syntax.contract) : contract_interface =
  Syntax.
  { contract_interface_name = raw.contract_name
  ; contract_interface_args = List.map (fun x -> x.arg_typ) raw.contract_arguments
  ; contract_interface_cases = List.map case_interface_of raw.contract_cases
  ; contract_interface_continuations = collect_continuation_in_contract raw
  }

let find_method_sig_in_contract
      (method_name : string) (i : contract_interface)
    : case_interface option =
  Misc.first_some (fun case_inter ->
      if case_inter.Ethereum.sig_name = method_name then
        Some case_inter
      else None
    ) i.contract_interface_cases

let find_method_signature
  (interfaces : contract_interface Syntax.contract_id_assoc)
  (contract_name : string)
  (method_name : string) : case_interface option =
  Misc.first_some (find_method_sig_in_contract method_name) (List.map snd interfaces)
