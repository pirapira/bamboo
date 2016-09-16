(** The first element is the context for the innermost block *)
type type_env = Syntax.arg list list

let empty_type_env : type_env = []

let forget_innermost : type_env -> type_env = List.tl

let add_empty_block (orig : type_env) : type_env = [] :: orig

let add_pair (orig : type_env) (ident : string) (typ : Syntax.typ) : type_env =
  match orig with
  | h :: t -> (Syntax.{ arg_ident = ident; arg_typ = typ} :: h) :: t
  | _ -> failwith "no current scope in type env"

let lookup_block (name : string) (block : Syntax.arg list) =
  Misc.first_some
    (fun (a : Syntax.arg) ->
      if a.Syntax.arg_ident = name then Some a.Syntax.arg_typ else None)
    block

let lookup (env : type_env) (name : string) : Syntax.typ option =
  Misc.first_some (lookup_block name) env

let add_block (h : Syntax.arg list) (t : type_env) : type_env =
  h :: t
