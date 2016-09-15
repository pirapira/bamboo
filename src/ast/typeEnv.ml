(** The first element is the context for the innermost block *)
type type_env = Syntax.arg list list

let empty_type_env : type_env = failwith "empty_type_env"
let forget_innermost : type_env -> type_env = failwith "forget_innermost"
let add_empty_block : type_env -> type_env = failwith "add_new_block"
let add_pair : type_env -> string -> Syntax.typ -> type_env = failwith "add_pair"
let lookup : type_env -> string -> Syntax.typ option = failwith "lookup"
let add_block : Syntax.arg list -> type_env -> type_env = failwith "add_block"
