let rec first_some f lst =
  match lst with
  | [] -> None
  | h :: t ->
     begin match f h with
     | None -> first_some f t
     | Some x -> Some x
     end
