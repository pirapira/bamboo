type location_env =
  (string * Location.location) list list

let empty_location_env = []

let forget_innermost = function
  | (_ :: older) -> older
  | [] -> failwith "forget_innermost: no blocks to forget"

(** [update_block [str] [new_loc] returns [None] when [str] is not found.
 *  Otherwise, it returns the updated block. *)
let update_block (str : string) (new_loc : Location.location)
                 (block : (string * Location.location) list) :
      (string * Location.location) list option
  = failwith "update_block"

let update (orig : location_env) (str : string) (new_loc : Location.location)
    : location_env option =
  Misc.change_first (update_block str new_loc) orig

let lookup_block (search : string) (lst : (string * Location.location) list)
    : Location.location option = failwith "lookup_block"

let lookup (le : location_env) (search : string) : Location.location option =
  Misc.first_some (lookup_block search) le

let add_pair (le : location_env) (key : string) (loc : Location.location)
             : location_env =
  match le with
  | [] -> failwith "add_pair: no block"
  | h :: t -> ((key, loc) :: h) :: t

let add_empty_block orig = [] :: orig

let stack_story_block (block : (string * Location.location) list) : int option =
  failwith "stack_story_block"

let last_stack_element_recorded (le : location_env) =
  match Misc.first_some stack_story_block le with
  | Some n -> n
  | None -> -1
