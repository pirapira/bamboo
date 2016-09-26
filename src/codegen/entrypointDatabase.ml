type entrypoint =
  | Contract of Syntax.contract_id
  | Case of Syntax.contract_id * Ethereum.function_signature

let store : (entrypoint * Label.label) list ref = ref []

let register_entrypoint (k : entrypoint) (v : Label.label) : unit =
  store := (k, v) :: !store

let lookup_entrypoint (k : entrypoint) : Label.label =
  List.assoc k !store
