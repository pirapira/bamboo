type location_env

val empty_location_env : location_env
val forget_innermost : location_env -> location_env * int (* the shallowest postiions used = the biggest number *)
val add_empty_block : location_env -> location_env
val add_pair : location_env -> string (* ?? *) -> Location.location -> location_env
val lookup : location_env -> string -> Location.location option

(** [update] throws when the string is not in the environment. *)
val update : location_env -> string -> Location.location -> location_env

(** Nothing similar to typeEnv.add_block.  Add elements one by one. *)
