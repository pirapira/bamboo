type codegen_env =
  { ce_stack_size: int
  ; ce_program: PseudoImm.pseudo_imm Evm.program
  }

let empty_env =
  { ce_stack_size = 0
  ; ce_program = Evm.empty_program
  }

let code_length ce =
  Evm.program_length ce.ce_program

let stack_size ce = ce.ce_stack_size

let set_stack_size ce i =
  { ce with ce_stack_size = i }

let append_instruction
  (orig : codegen_env) (i : PseudoImm.pseudo_imm Evm.instruction) : codegen_env =
  if orig.ce_stack_size < Evm.stack_eaten i then
    failwith "stack underflow"
  else
    let new_stack_size = orig.ce_stack_size - Evm.stack_eaten i + Evm.stack_pushed i in
    { ce_stack_size = new_stack_size
    ; ce_program = Evm.append_inst orig.ce_program i
    }
