type label = int

let debug_label = false

(* internal data not accessible from outside of the module. *)
let next_fresh_label : int ref = ref 0
let store : (label * int) list ref = ref []

let new_label () =
  let ret = !next_fresh_label in
  let () = if debug_label then Printf.printf "label: generating label %d\n" ret else () in
  let () = next_fresh_label := ret + 1 in
  ret

let register_value l i =
  let () = if debug_label then Printf.printf "label: registering label %d %d\n%!" l i in
  store := (l, i) :: !store

let lookup_value l =
  try
    List.assoc l !store
  with Not_found ->
    let () = if debug_label then Printf.eprintf "label: %d not found\n%!" l in
    raise Not_found
