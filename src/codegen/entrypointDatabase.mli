type entrypoint =
  | Contract of Assoc.contract_id
  | Case of Assoc.contract_id * Syntax.case_header

val register_entrypoint : entrypoint -> Label.label -> unit
val lookup_entrypoint : entrypoint -> Label.label
