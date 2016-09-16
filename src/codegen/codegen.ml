open PseudoImm
open CodegenEnv
open Evm

let copy_to_stack_top (l : Location.location) =
  failwith "copy_to_stack_top"

(* le is not updated here.  It can be only updated in
 * a variable initialization *)
let rec codegen_exp
      (le : LocationEnv.location_env)
      (ce : CodegenEnv.codegen_env)
      ((e,t) : Syntax.typ Syntax.exp) :
      CodegenEnv.codegen_env =
  let ret =
  Syntax.
  (match e,t with
   | ValueExp,UintType ->
      let ce = CodegenEnv.append_instruction ce CALLVALUE in
      ce
   | SenderExp,AddressType ->
      let ce = CodegenEnv.append_instruction ce CALLER in
      ce
   | ArrayAccessExp _, _ ->
      failwith "code gen array access"
   | ThisExp,_ ->
      let ce = CodegenEnv.append_instruction ce ADDRESS in
      ce
   | IdentifierExp id,_ ->
      begin match LocationEnv.lookup le id with
      (** if things are just DUP'ed, location env should not be
       * updated.  If they are SLOADED, the location env should be
       * updated. *)
      | Some location ->
         let (le, ce) = copy_to_stack_top location in
         ce
      | None -> failwith ("identifier's location not found: "^id)
      end
  | FalseExp,BoolType ->
     let ce = CodegenEnv.append_instruction
                ce (Evm.PUSH1 (Concrete Big_int.zero_big_int)) in
     ce
  | TrueExp,BoolType ->
     let ce = append_instruction ce (PUSH1 (Concrete Big_int.unit_big_int)) in
     ce
  | NotExp sub,BoolType ->
     let ce = codegen_exp le ce sub in
     let ce = append_instruction ce NOT in
     ce
  | NowExp,UintType ->
     append_instruction ce TIMESTAMP
  | NeqExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in (* l later because it should come at the top *)
     let ce = append_instruction ce NEQ in
     ce
  | LtExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce LT in
     ce
  | GtExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce GT in
     ce
  | EqualityExp (l, r), BoolType ->
     let ce = codegen_exp le ce r in
     let ce = codegen_exp le ce l in
     let ce = append_instruction ce EQ in
     ce
  | SendExp s, _ ->
     failwith "codegen for SendExp"
     (* argument order, gas, to, value, in offset in size out offset, out size *)
(*     let out_size = send_out_size t s in
     let out_offset = usual_memory_offset in (* new location should be allocated *)
     let in_size = sned_in_size s in
     let in_offset = usual_memory_offset in
     let ce = append_instruction ce (PUSH32 out_size) in
     let ce = append_instruction ce (PUSH32 out_offset) in
     let ce = append_instruction ce (PUSH32 in_size) in
     let ce = append_instruction ce (PUSH32 in_offset) in
     let ce = prepare_arguments_in_memory ce s in
     let ce = codegen_exp ce value_exp in
     let ce = codegen_exp ce to_exp in
     let ce = append_instruction ce GAS in
     let ce = append_instruction ce CALL in
     let ce = append_instruction ce ISZERO in
     let ce = append_instruction ce NOT in (* stack head should be true iff success *)
     let (ce, success_label) = generate_new_label ce in
     let ce = append_instruction ce (PUSH32 success_label) in (* jump destination in case of success *)
     let ce = append_instruction ce IJUMP in
     let ce = append_instruction ce (PUSH1 0) in
     let ce = append_instruction ce JUMP in
     let ce = append_instruction ce (JUMPDEST success_label) in
     ce *)
  | NewExp new_e, _ ->
     failwith "exp code gen for new expression"
  | FunctionCallExp _, _ ->
     (* TODO maybe the name callexp should be changed, the only instance is the newly created contract, for which the new_exp should be responsible *)
     failwith "exp code gen for callexp"
  | ParenthExp _, _ ->
     failwith "ParenthExp not expected."
  | AddressExp e, AddressType ->
     (* e is a contract instance.
      * The concrete representation of a contact instance is
      * already the address
      *)
     codegen_exp le ce e
  ) in
  let () = assert (stack_size ret = stack_size ce + 1) in
  ret

let codegen_sentence
  (orig : CodegenEnv.codegen_env)
  (s : Syntax.typ Syntax.sentence)
  (* is this enough? also add sentence Id's around?
   * I think this is enough.
   *)
  : CodegenEnv.codegen_env = failwith "codegen_sentence"

let move_info_around
  (assumption : CodegenEnv.codegen_env)
  (goal : LocationEnv.location_env) :
      CodegenEnv.codegen_env = failwith "move_info_around"
