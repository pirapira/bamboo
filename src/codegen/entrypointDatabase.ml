type entrypoint =
  | Contract of Assoc.contract_id
  | Case of Assoc.contract_id * Syntax.case_header

let store : (entrypoint * Label.label) list ref = ref []

let register_entrypoint (k : entrypoint) (v : Label.label) : unit =
  store := (k, v) :: !store

let lookup_entrypoint (k : entrypoint) : Label.label =
  List.assoc k !store
