type 'imm instruction =
  | PUSH1 of 'imm
  | PUSH32 of 'imm

type 'imm program = 'imm instruction list
let program_length = List.length

let empty_program = []

(** The program is stored in the reverse order *)
let append_inst orig i = i :: orig

let to_list (p : 'imm program) =
  List.rev p

let stack_eaten = function
  | PUSH1 _ -> 0
  | PUSH32 _ -> 0

let stack_pushed = function
  | PUSH1 _ -> 1
  | PUSH32 _ -> 1
