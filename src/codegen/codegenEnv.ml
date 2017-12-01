type t =
  { ce_stack_size: int
  ; ce_program: PseudoImm.pseudo_imm Evm.program
  ; ce_cid_lookup : string -> Assoc.contract_id
  ; ce_contracts : Syntax.typ Syntax.contract Assoc.contract_id_assoc
  }

let ce_program m = m.ce_program

let empty_env cid_lookup contracts =
  { ce_stack_size = 0
  ; ce_program = Evm.empty_program
  ; ce_cid_lookup = cid_lookup
  ; ce_contracts = contracts
  }

let code_length ce =
  Evm.size_of_program ce.ce_program

let stack_size ce = ce.ce_stack_size

let set_stack_size ce i =
  { ce with ce_stack_size = i }

let append_instruction
  (orig : t) (i : PseudoImm.pseudo_imm Evm.instruction) : t =
  if orig.ce_stack_size < Evm.stack_eaten i then
    failwith "stack underflow"
  else
    let () = (match i with
                Evm.JUMPDEST l ->
                begin
                  try ignore (Label.lookup_value l)
                  with Not_found ->
                       Label.register_value l (code_length orig)
                end
              | _ -> ()
             ) in
    let new_stack_size = orig.ce_stack_size - Evm.stack_eaten i + Evm.stack_pushed i in
    if new_stack_size > 1024 then
      failwith "stack overflow"
    else
    { ce_stack_size = new_stack_size
    ; ce_program = Evm.append_inst orig.ce_program i
    ; ce_cid_lookup = orig.ce_cid_lookup
    ; ce_contracts = orig.ce_contracts
    }

let cid_lookup ce = ce.ce_cid_lookup

let contract_lookup (ce : t) (cid : Assoc.contract_id) : Syntax.typ Syntax.contract
  =
  try Assoc.choose_contract cid ce.ce_contracts
  with e ->
    let () = Printf.eprintf "contract_lookup failed on %d\n%!" cid in
    let () = (Assoc.print_int_for_cids (fun x -> x) (Assoc.cids ce.ce_contracts)) in
    raise e
