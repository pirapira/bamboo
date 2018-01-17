#if BSB_BACKEND = "js" then
(* Js.Option.map expects the callback to be uncurried
https://bucklescript.github.io/bucklescript/api/Js.Option.html#VALmap
Explanation: https://bucklescript.github.io/docs/en/function.html#curry-uncurry *)
let map_id id = ((fun ret -> (id, ret))[@bs ])
#else
let map_id id = (fun ret -> (id, ret))
#end

type contract_id = int

type 'a contract_id_assoc = (contract_id * 'a) list

let list_to_contract_id_assoc (lst : 'a list) =
  let ids =
    if lst = [] then
      []
    else
      Wrap_list.range 0 (List.length lst - 1) in
  List.combine ids lst

let map f lst =
  List.map (fun (id, x) -> (id, f x)) lst

let pair_map f lst =
  List.map (fun (id, x) -> (id, f id x)) lst

let filter_map f lst =
  Wrap_list.filter_map (
      fun (id, x) ->
      Wrap_option.map (map_id id) (f x)) lst

let choose_contract (id : contract_id) lst =
  try
    List.assoc id lst
  with Not_found ->
       let () = Printf.eprintf "choose_contract: not_found\n%!" in
       raise Not_found

let print_int_for_cids (f : contract_id -> int) (cids : contract_id list) : unit =
  List.iter (fun cid -> Printf.printf "%d |-> %d, " cid (f cid)) cids

let insert (id : contract_id) (a : 'x) (orig : 'x contract_id_assoc) : 'x contract_id_assoc =
  (id, a)::orig (* shall I sort it?  Maybe later at once. *)

let lookup_id (f : 'x -> bool) (lst : 'x contract_id_assoc) : contract_id =
  let (id, _) = List.find (fun (_, x) -> f x) lst in
  id

let empty = []

let cids lst = List.map fst lst

let values lst = List.map snd lst
