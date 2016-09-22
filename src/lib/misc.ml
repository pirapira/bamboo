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

let rec change_first f lst =
  match lst with
  | [] -> None
  | h :: t ->
     begin match f h with
     | None ->
       option_map (fun rest -> h :: rest)
                  (change_first f t)
     | Some n -> Some (n :: t)
     end

let rec int_sum (lst : int list) =
  match lst with
  | [] -> 0
  | h :: t ->
     h + (int_sum t)

let rec filter_map f lst =
  match lst with
  | [] -> []
  | h :: t ->
     match f h with
     | Some h' -> h' :: (filter_map f t)
     | None -> filter_map f t
