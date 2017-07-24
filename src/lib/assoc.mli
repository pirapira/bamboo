type contract_id = int
(* Currently, the location in [contracts] *)

type 'a contract_id_assoc = (contract_id * 'a) list

(** [list_to_contract_id_assoc] assignes a different contract_id for each element of the list.
 *  It starts with 0 until (length of list - 1).
 *)
val list_to_contract_id_assoc : 'a list -> 'a contract_id_assoc

val map : ('a -> 'b) -> 'a contract_id_assoc -> 'b contract_id_assoc
val pair_map : (contract_id -> 'a -> 'b) -> 'a contract_id_assoc -> 'b contract_id_assoc
val filter_map : ('a -> 'b option) -> 'a contract_id_assoc -> 'b contract_id_assoc

val choose_contract : contract_id -> 'x contract_id_assoc -> 'x

val print_int_for_cids : (contract_id -> int) -> contract_id list -> unit

val insert : contract_id -> 'x -> 'x contract_id_assoc -> 'x contract_id_assoc

val lookup_id : ('x -> bool) -> 'x contract_id_assoc -> contract_id

val empty : 'x contract_id_assoc

val cids : 'x contract_id_assoc -> contract_id list
