let rec first_some f lst =
  match lst with
  | [] -> None
  | h :: t ->
     begin match f h with
     | None -> first_some f t
     | Some x -> Some x
     end

let rec change_first f lst =
  match lst with
  | [] -> None
  | h :: t ->
     begin match f h with
     | None ->
       BatOption.map (fun rest -> h :: rest)
                  (change_first f t)
     | Some n -> Some (n :: t)
     end
