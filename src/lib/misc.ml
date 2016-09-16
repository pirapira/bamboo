let rec first_some f lst =
  match lst with
  | [] -> None
  | h :: t ->
     begin match f h with
     | None -> first_some f t
     | Some x -> Some x
     end

let option_map f a =
  match a with
  | Some x -> Some (f x)
  | None -> None
