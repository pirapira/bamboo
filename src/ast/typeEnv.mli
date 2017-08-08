type type_env

val empty_type_env : type_env
val forget_innermost : type_env -> type_env
val add_empty_block : type_env -> type_env
val add_pair : type_env -> string -> Syntax.typ -> SideEffect.location option -> type_env
val lookup : type_env -> string -> (Syntax.typ * SideEffect.location option) option
val add_block : Syntax.arg list -> type_env -> type_env
val lookup_event : type_env -> string -> Syntax.event
val add_events : Syntax.event Assoc.contract_id_assoc -> type_env -> type_env
val remember_expected_returns : type_env -> (Syntax.typ option -> bool) -> type_env
val lookup_expected_returns : type_env -> (Syntax.typ option -> bool)
