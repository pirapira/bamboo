type codegenEnv =
  { ce_stack_size: int
  ; ce_program: PseudoImm.pseudo_imm Evm.program
  }

let empty_env =
  { ce_stack_size = 0
  ; ce_program = Evm.empty_program
  }

let codeLength ce =
  Evm.program_length ce.ce_program

let append_instruction
  (orig : codegenEnv) (i : PseudoImm.pseudo_imm Evm.instruction) : codegenEnv =
  if orig.ce_stack_size < Evm.stack_eaten i then
    failwith "stack underflow"
  else
    let new_stack_size = orig.ce_stack_size - Evm.stack_eaten i + Evm.stack_pushed i in
    { ce_stack_size = new_stack_size
    ; ce_program = Evm.append_inst orig.ce_program i
    }
