type call =
  {  call_head : string
  ;  call_args : exp list
  }
and message_info =
  { message_value_info : exp option
  ; message_reentrance_info : sentence list
  }
and new_exp =
  { new_head : string
  ; new_args : exp list
  ; new_msg_info : message_info
  }
and exp =
  | TrueExp
  | CallExp of call
  | IdentifierExp of string
  | ParenthExp of exp
  | NewExp of new_exp
  | LtExp of exp * exp
and lexp =
  | IdentifierLExp of string
  | ArrayAccessLExp of array_access
and array_access =
  { array_access_array : string
  ; array_access_index : exp
  }
and variable_init =
  { variable_init_type : typ
  ; variable_init_name : string
  ; variable_init_value : exp
  }
and typ =
  | UintType
  | AddressType
  | BoolType
  | MappingType of typ * typ
  | IdentType of string
and sentence =
  | AbortSentence
  | ReturnSentence of return
  | AssignmentSentence of lexp * exp
  | VariableInitSentence of variable_init
  | IfSingleSentence of exp * sentence
and return =
  { return_value : exp
  ; return_cont : exp
  }

type arg =
  { arg_typ : typ
  ; arg_ident : string
  }



type case_body =
  sentence list

type case_header =
  | UsualCaseHeader
  | DefaultCaseHeader

type case =
  { case_header : case_header
  ; case_body : case_body
  }

type contract =
  { contract_cases : case list
  }
