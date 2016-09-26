type entrypoint =
  | Contract of Syntax.contract_id
  | Case of Syntax.contract_id * Ethereum.function_signature

val register_entrypoint : entrypoint -> Label.label -> unit
val lookup_entrypoint : entrypoint -> Label.label
