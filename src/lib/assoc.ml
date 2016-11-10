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

let choose_contract (id : contract_id) lst =
  List.assoc id lst

let print_int_for_cids (f : contract_id -> int) (cids : contract_id list) : unit =
  List.iter (fun cid -> Printf.printf "%d |-> %d, " cid (f cid)) cids
