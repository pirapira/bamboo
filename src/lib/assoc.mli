type contract_id = int
(* Currently, the location in [contracts] *)

type 'a contract_id_assoc = (contract_id * 'a) list

(** [list_to_contract_id_assoc] assignes a different  [contract_id] for each element of the list. *)
val list_to_contract_id_assoc : 'a list -> 'a contract_id_assoc

val assoc_map : ('a -> 'b) -> 'a contract_id_assoc -> 'b contract_id_assoc
val assoc_pair_map : (contract_id -> 'a -> 'b) -> 'a contract_id_assoc -> 'b contract_id_assoc

val choose_contract : contract_id -> 'x contract_id_assoc -> 'x

val print_int_for_cids : (contract_id -> int) -> contract_id list -> unit

val insert : contract_id -> 'x -> 'x contract_id_assoc -> 'x contract_id_assoc

val lookup_id : ('x -> bool) -> 'x contract_id_assoc -> contract_id
