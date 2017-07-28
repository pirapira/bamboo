open PseudoImm

type t =
  (string * Location.location) list list

let size l =
  BatList.sum (List.map List.length l)

let empty_env = []

let forget_innermost = function
  | (_ :: older) -> older
  | [] -> failwith "forget_innermost: no blocks to forget"

(** [update_block [str] [new_loc] returns [None] when [str] is not found.
 *  Otherwise, it returns the updated block. *)
let update_block (str : string) (new_loc : Location.location)
                 (block : (string * Location.location) list) :
      (string * Location.location) list option
  = failwith "update_block"

let update (orig : t) (str : string) (new_loc : Location.location)
    : t option =
  Misc.change_first (update_block str new_loc) orig

let lookup_block (search : string) (lst : (string * Location.location) list)
    : Location.location option =
  try
    Some (List.assoc search lst)
  with
    Not_found -> None

let lookup (le : t) (search : string) : Location.location option =
  Misc.first_some (lookup_block search) le

let add_pair (le : t) (key : string) (loc : Location.location)
             : t =
  match le with
  | [] -> failwith "add_pair: no block"
  | h :: t -> ((key, loc) :: h) :: t

let add_pairs (le : t) (lst : (string * Location.location) list) : t =
  List.fold_left (fun le' (str, loc) -> add_pair le' str loc) le lst

let add_empty_block orig = [] :: orig

let stack_story_block (block : (string * Location.location) list) : int option =
  failwith "stack_story_block"

let last_stack_element_recorded (le : t) =
  match Misc.first_some stack_story_block le with
  | Some n -> n
  | None -> -1

let constructor_args_locations (cid : Assoc.contract_id) (args : (string * Ethereum.interface_typ) list)
    : t
  =
  let total = Ethereum.total_size_of_interface_args (List.map snd args) in
  let one_arg ((name : string), (offset : int), (size : int)) :
        string * Location.location
    =
    Location.(name,
     Code
      { code_start = PseudoImm.(Minus (InitDataSize cid, (Int (total - offset))))
      ; code_size =  Int size
      }) in
  let rec name_offset_size_list rev_acc offset (args : (string * Ethereum.interface_typ) list) =
    match args with
    | [] -> List.rev rev_acc
    | (h_name, h_typ) :: t ->
       name_offset_size_list ((h_name, offset, Ethereum.interface_typ_size h_typ) :: rev_acc)
                             (offset + Ethereum.interface_typ_size h_typ) t
  in
  [List.map one_arg (name_offset_size_list [] 0 args)]

let constructor_initial_env (cid : Assoc.contract_id)
                            (contract : Syntax.typ Syntax.contract) : t =
  let args = Ethereum.constructor_arguments contract in
  constructor_args_locations cid args

(** [runtime_initial_t contract]
 * is a location environment that contains
 * the constructor arguments
 * after StorageConstrutorArgumentBegin *)
let runtime_initial_env
      (contract : Syntax.typ Syntax.contract) : t =
  let plain = Ethereum.constructor_arguments contract in
  let init = add_empty_block empty_env in
  let f (lenv, word_idx) (name, typ) =
    let size_in_word = Ethereum.interface_typ_size typ / 32 in
    let loc = Location.(Storage {
                  storage_start = Int word_idx;
                  storage_size = Int size_in_word
                }) in
    let new_lenv = add_pair lenv name loc in
    (new_lenv, word_idx + size_in_word)
  in
  (* XXX: remove the hard coded 2 *)
  let (le, mid) = List.fold_left f (init, 2) plain in
  let arrays = Ethereum.arrays_in_contract contract in (* XXX: refactor the repetition *)
  let g (lenv, word_idx) (name, _, _) =
    let size_in_word = 1 in
    let loc = Location.(Storage {
                            storage_start = Int word_idx;
                            storage_size = Int size_in_word
              }) in
    let new_lenv = add_pair lenv name loc in
    (new_lenv, word_idx + size_in_word) in
  let (le, _) = List.fold_left g (le, mid) arrays in
  le
