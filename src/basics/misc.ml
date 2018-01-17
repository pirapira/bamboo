#if BSB_BACKEND = "js" then
(* Js.Option.map expects the callback to be uncurried
https://bucklescript.github.io/bucklescript/api/Js.Option.html#VALmap
Explanation: https://bucklescript.github.io/docs/en/function.html#curry-uncurry *)
let append_head h = ((fun rest  -> h :: rest)[@bs ])
#else
let append_head h = (fun rest  -> h :: rest)
#end

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
       Wrap_option.map (append_head h)
                  (change_first f t)
     | Some n -> Some (n :: t)
     end
