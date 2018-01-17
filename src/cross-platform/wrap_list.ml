#if BSB_BACKEND = "js" then
  let range i j =
    let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
    aux j []
  let sum l =
    let rec s rest acc = match rest with | [] -> acc | h::t -> s t (acc + h) in
    s l 0
  let filter_map f l =
    let maybeAddHead filter head list =
      match filter head with
      | ((Some (v))[@explicit_arity ]) -> v :: list
      | None  -> list in
    let rec s rest acc =
      match rest with | [] -> List.rev acc | h::t -> s t (maybeAddHead f h acc) in
    s l []
#else
  let range i j = BatList.(range i `To j)
  let sum = BatList.sum
  let filter_map = BatList.filter_map
#end
