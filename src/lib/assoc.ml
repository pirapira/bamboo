type contract_id = int

type 'a contract_id_assoc = (contract_id * 'a) list

let list_to_contract_id_assoc (lst : 'a list) =
  let x = ref 0 in
  let fresh_assoc () =
    let ret = !x in
    let () = x := ret + 1 in
    ret in
  List.map (fun x -> (fresh_assoc(), x)) lst

let assoc_map f lst =
  List.map (fun (id, x) -> (id, f x)) lst

let assoc_pair_map f lst =
  List.map (fun (id, x) -> (id, f id x)) lst

let choose_contract (id : contract_id) lst =
  try
    List.assoc id lst
  with Not_found ->
       let () = Printf.printf "not_found\n%!" in
       raise Not_found

let print_int_for_cids (f : contract_id -> int) (cids : contract_id list) : unit =
  List.iter (fun cid -> Printf.printf "%d |-> %d, " cid (f cid)) cids

let insert (id : contract_id) (a : 'x) (orig : 'x contract_id_assoc) : 'x contract_id_assoc =
  (id, a)::orig (* shall I sort it?  Maybe later at once. *)

let lookup_id (f : 'x -> bool) (lst : 'x contract_id_assoc) : contract_id =
  let (id, _) = List.find (fun (_, x) -> f x) lst in
  id

let empty = []
