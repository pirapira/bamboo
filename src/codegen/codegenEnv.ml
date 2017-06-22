type codegen_env =
  { ce_stack_size: int
  ; ce_program: PseudoImm.pseudo_imm Evm.program
  ; ce_cid_lookup : string -> Assoc.contract_id
  ; ce_layout : LayoutInfo.contract_layout_info Assoc.contract_id_assoc
  }

let ce_program m = m.ce_program

let empty_env cid_lookup =
  { ce_stack_size = 0
  ; ce_program = Evm.empty_program
  ; ce_cid_lookup = cid_lookup
  ; ce_layout = Assoc.empty
  }

let code_length ce =
  Evm.size_of_program ce.ce_program

let stack_size ce = ce.ce_stack_size

let set_stack_size ce i =
  { ce with ce_stack_size = i }

let append_instruction
  (orig : codegen_env) (i : PseudoImm.pseudo_imm Evm.instruction) : codegen_env =
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
    { ce_stack_size = new_stack_size
    ; ce_program = Evm.append_inst orig.ce_program i
    ; ce_cid_lookup = orig.ce_cid_lookup
    ; ce_layout = orig.ce_layout
    }

let cid_lookup ce = ce.ce_cid_lookup

let layout_lookup (ce : codegen_env) (cid : Assoc.contract_id) : LayoutInfo.contract_layout_info
  = Assoc.choose_contract cid ce.ce_layout
