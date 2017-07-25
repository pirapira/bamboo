(** The first element is the context for the innermost block *)
type type_env =
  { identifiers: Syntax.arg list list
  ; events: Syntax.event list
  }

let empty_type_env : type_env =
  { identifiers = []
  ; events = []
  }

let forget_innermost (orig : type_env) : type_env =
  { identifiers = List.tl (orig.identifiers)
  ; events = orig.events
  }

let add_empty_block (orig : type_env) : type_env =
  { identifiers = [] :: orig.identifiers
  ; events = orig.events
  }

let add_pair (orig : type_env) (ident : string) (typ : Syntax.typ) : type_env =
  match orig.identifiers with
  | h :: t ->
     { identifiers = (Syntax.{ arg_ident = ident; arg_typ = typ} :: h) :: t
     ; events = orig.events
     }
  | _ -> failwith "no current scope in type env"

let lookup_block (name : string) (block : Syntax.arg list) =
  Misc.first_some
    (fun (a : Syntax.arg) ->
      if a.Syntax.arg_ident = name then Some a.Syntax.arg_typ else None)
    block

let lookup (env : type_env) (name : string) : Syntax.typ option =
  Misc.first_some (lookup_block name) env.identifiers

let add_block (h : Syntax.arg list) (t : type_env) : type_env =
  { identifiers = h :: t.identifiers
  ; events = t.events
  }

let lookup_event (env : type_env) (name : string) : Syntax.typ list =
  try
    let event = BatList.find (fun e -> e.Syntax.event_name = name) env.events in
    List.map (fun ea -> Syntax.(ea.event_arg_body.arg_typ)) event.Syntax.event_arguments
  with Not_found ->
    let () = Printf.eprintf "event %s not found\n" name in
    raise Not_found

let add_events (events : Syntax.event Assoc.contract_id_assoc) (orig : type_env) : type_env =
  { identifiers = orig.identifiers
  ; events = (Assoc.values events) @ orig.events
  }
