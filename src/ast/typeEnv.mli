type type_env

val empty_type_env : type_env
val forget_innermost : type_env -> type_env
val add_empty_block : type_env -> type_env
val add_pair : type_env -> string -> Syntax.typ -> type_env
val lookup : type_env -> string -> Syntax.typ option
val add_block : Syntax.arg list -> type_env -> type_env
val lookup_event : type_env -> string -> Syntax.typ list
