type entrypoint =
  | Contract of Assoc.contract_id
  | Case of Assoc.contract_id * Ethereum.function_signature

val register_entrypoint : entrypoint -> Label.label -> unit
val lookup_entrypoint : entrypoint -> Label.label
