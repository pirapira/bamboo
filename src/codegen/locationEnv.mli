type location_env

val empty_location_env : location_env
val forget_innermost : location_env -> location_env
val add_empty_block : location_env -> location_env

(** should maintain the uniqueless of [string] in the environment. *)
val add_pair : location_env -> string (* ?? *) -> Location.location -> location_env
val lookup : location_env -> string -> Location.location option

(** [last_stack_element_recorded = 3] means the third deepest element of the
 * stack is kept track in the location_env structure.
 * The caller is free to pop anything shallower *)
val last_stack_element_recorded : location_env -> int

(** [update] returns [None] when the string is not in the environment. *)
val update : location_env -> string -> Location.location -> location_env option

(** Nothing similar to typeEnv.add_block.  Add elements one by one. *)


(** {2} concrete locationEnv instances *)

(** [constructor_initial_location_env contract]
 *  returns the location environment that contains
 *  the expected input arguments at the end of the
 *  bytecode *)
val constructor_initial_location_env :
  Syntax.typ Syntax.contract -> location_env
