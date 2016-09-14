type case_interface = Ethereum.function_signature

let case_interface_of (raw : unit Syntax.case) : case_interface =
  failwith "case_inter not implemented"

type contract_interface =
  { contract_interface_name : string
    (** [contract_interface_name] is the name of the contract. *)
  ; contract_interface_args : Ethereum.interface_typ list
  ; contract_interface_cases : case_interface list
  ; contract_interface_continuations : string list
    (** [contract_interface_transitions] lists the names of contracts that
        this one can continue into *)
  }

let collect_continuation_in_contract (raw : unit Syntax.contract) : string list =
  failwith "colelct_cont not implemented"

let contract_interface_of (raw : unit Syntax.contract) : contract_interface =
  Syntax.
  { contract_interface_name = raw.contract_name
  ; contract_interface_args = Ethereum.get_interface_typs raw.contract_arguments
  ; contract_interface_cases = List.map case_interface_of raw.contract_cases
  ; contract_interface_continuations = collect_continuation_in_contract raw
  }
