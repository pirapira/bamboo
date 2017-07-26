(** The first element is the context for the innermost block *)
type type_env =
  { identifiers: Syntax.arg list list
  ; events: Syntax.event list
  ; expected_returns : Syntax.typ list option
  }

let empty_type_env : type_env =
  { identifiers = []
  ; events = []
  ; expected_returns = None
  }

let forget_innermost (orig : type_env) : type_env =
  { orig with identifiers = List.tl (orig.identifiers) }

let add_empty_block (orig : type_env) : type_env =
  { orig with identifiers = [] :: orig.identifiers }

let add_pair (orig : type_env) (ident : string) (typ : Syntax.typ) : type_env =
  match orig.identifiers with
  | h :: t ->
     { orig with identifiers = (Syntax.{ arg_ident = ident; arg_typ = typ} :: h) :: t }
  | _ -> failwith "no current scope in type env"

let lookup_block (name : string) (block : Syntax.arg list) =
  Misc.first_some
    (fun (a : Syntax.arg) ->
      if a.Syntax.arg_ident = name then Some a.Syntax.arg_typ else None)
    block

let lookup (env : type_env) (name : string) : Syntax.typ option =
  Misc.first_some (lookup_block name) env.identifiers

let add_block (h : Syntax.arg list) (orig : type_env) : type_env =
  { orig with identifiers = h :: orig.identifiers }

let lookup_event (env : type_env) (name : string) : Syntax.event =
  try
    BatList.find (fun e -> e.Syntax.event_name = name) env.events
  with Not_found ->
    let () = Printf.eprintf "event %s not found\n" name in
    raise Not_found

let add_events (events : Syntax.event Assoc.contract_id_assoc) (orig : type_env) : type_env =
  { orig with events = (Assoc.values events) @ orig.events }

let remember_expected_returns (orig : type_env) (lst : Syntax.typ list) =
  match orig.expected_returns with
  | Some _ -> failwith "Trying to overwrite the expectations about the return values"
  | None -> { orig with expected_returns = Some lst }

let lookup_expected_returns t =
  t.expected_returns
