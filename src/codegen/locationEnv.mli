type t

val empty_env : t
val forget_innermost : t -> t
val add_empty_block : t -> t

(** should maintain the uniqueless of [string] in the environment. *)
val add_pair : t -> string (* ?? *) ->
               Location.location -> t
val add_pairs : t -> (string * Location.location) list -> t
val lookup : t -> string ->
             Location.location option

(** [last_stack_element_recorded = 3] means the third deepest element of the
 * stack is kept track in the t structure.
 * The caller is free to pop anything shallower *)
val last_stack_element_recorded : t -> int

(** [update] returns [None] when the string is not in the environment. *)
val update : t -> string ->
             Location.location -> t option

(** [size l] returns the number of entries in [l] *)
val size : t -> int

(** Nothing similar to typeEnv.add_block.  Add elements one by one. *)


(** {2} concrete locationEnv instances *)

(** [constructor_initial_env contract]
 *  returns the location environment that contains
 *  the expected input arguments at the end of the
 *  bytecode *)
val constructor_initial_env :
  Assoc.contract_id -> Syntax.typ Syntax.contract -> t

(** [runtime_initial_env specifies
 * where the state variables should be found
 * when the runtie code starts.
 * The deployment bytecode must establish this.
 * Storage index 0 is used for contract dispatching.
 * The following indices are used to store the
 * state variables.
 *)
val runtime_initial_env :
  Syntax.typ Syntax.contract -> t

(** [constructor_args_locations constract] returns
 *  a location environment that only contains
 *  the constructor arguments appended at the end of
 *  the code. *)
val constructor_args_locations :
  Assoc.contract_id -> (string * Ethereum.interface_typ) list -> t
