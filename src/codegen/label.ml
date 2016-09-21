type label = int

(* internal data not accessible from outside of the module. *)
let next_fresh_label : int ref = ref 0
let store : (label * int) list ref = ref []

let new_label () =
  let ret = !next_fresh_label in
  let () = next_fresh_label := ret + 1 in
  ret

let register_value l i =
  store := (l, i) :: !store

let lookup_value l = List.assoc l !store
