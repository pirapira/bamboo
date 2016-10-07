type hex

val empty_hex : hex
val concat_hex : hex -> hex -> hex

(** [length_of_hex h] returns the length of [h] as the number of the represented bytes.
 *  This implies [length_of_hex h] is always the half of the length of [string_of_hex h]. *)
val length_of_hex : hex -> int

(** [hex_of_big_int b l] returns the hex, which is zero-padded to [2 * l] characters.
 *  If [b] is too big, raises a failure.
 *)
val hex_of_big_int : Big_int.big_int -> int -> hex
val string_of_hex : ?prefix:string -> hex -> string
val print_hex : ?prefix:string -> hex -> unit
