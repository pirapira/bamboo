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
  let rec last = function
    | [] -> invalid_arg "Empty List"
    | x::[] -> x
    | _::t -> last t

  (* Copied from *)
  type 'a mut_list = {
    hd: 'a;
    mutable tl: 'a list;}
  external inj : 'a mut_list -> 'a list = "%identity"
  module Acc =
    struct
      let dummy () = { hd = (Obj.magic ()); tl = [] }
      let create x = { hd = x; tl = [] }
      let accum acc x = let cell = create x in acc.tl <- inj cell; cell
    end
  let unique ?(eq= (=))  l =
    let rec loop dst =
      function
      | [] -> ()
      | h::t ->
          (match List.exists (eq h) t with
          | true  -> loop dst t
          | false  -> loop (Acc.accum dst h) t) in
    let dummy = Acc.dummy () in loop dummy l; dummy.tl;;
#else
  let range i j = BatList.(range i `To j)
  let sum = BatList.sum
  let filter_map = BatList.filter_map
  let last = BatList.last
  let unique = BatList.unique
#end
