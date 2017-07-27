(** If any element is mapped to [Some x], return the first such one. Otherwise return [None]. *)
val first_some : ('a -> 'b option) -> 'a list -> 'b option

(** If any element is mapped to [Some x], replace the first such element with [x].  Otherwise, return [None] *)
val change_first : ('a -> 'a option) -> 'a list -> 'a list option
