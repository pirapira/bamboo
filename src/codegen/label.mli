(* A label is typically put on a jump destination.
 *)

type label

(** [new label ()] returns a new label each time it is called. *)
val new_label : unit -> label

(** [register_value l i] registers a correspondence (l, i).
 *   If [register_location l j] is already called
 *   (even if j is equal to i), throws a failure *)
val register_value : label -> int -> unit

(** [lookup_value l] returns the value [i] with which
 * the correspondence [(l, i)] has been registered.
 * When such correspondence does not exist,
 * throws a failure.
 *)
val lookup_value : label -> int
