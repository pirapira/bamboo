type typ =
  | UintType
  | AddressType
  | BoolType
  | MappingType of typ * typ
  | IdentType of string

type 'exp_annot call =
  {  call_head : string
  ;  call_args : ('exp_annot exp) list
  }
and 'exp_annot message_info =
  { message_value_info : 'exp_annot exp option
  ; message_reentrance_info : 'exp_annot sentence list
  }
and 'exp_annot new_exp =
  { new_head : string
  ; new_args : 'exp_annot exp list
  ; new_msg_info : 'exp_annot message_info
  }
and 'exp_annot send_exp =
  { send_head_contract : 'exp_annot exp
  ; send_head_method : string
  ; send_args : 'exp_annot exp list
  ; send_msg_info : 'exp_annot message_info
  }
and 'exp_annot exp = 'exp_annot exp_inner * 'exp_annot
and 'exp_annot exp_inner =
  | TrueExp
  | FalseExp
  | CallExp of 'exp_annot call
  | IdentifierExp of string
  | ParenthExp of 'exp_annot exp
  | NewExp of 'exp_annot new_exp
  | SendExp of 'exp_annot send_exp
  | LtExp of 'exp_annot exp * 'exp_annot exp
  | GtExp of 'exp_annot exp * 'exp_annot exp
  | NeqExp of 'exp_annot exp * 'exp_annot exp
  | EqualityExp of 'exp_annot exp * 'exp_annot exp
  | AddressExp of 'exp_annot exp
  | NotExp of 'exp_annot exp
  | ArrayAccessExp of 'exp_annot array_access
and 'exp_annot lexp =
  | IdentifierLExp of string
  | ArrayAccessLExp of 'exp_annot array_access
and 'exp_annot array_access =
  { array_access_array : string
  ; array_access_index : 'exp_annot exp
  }
and 'exp_annot variable_init =
  { variable_init_type : typ
  ; variable_init_name : string
  ; variable_init_value : 'exp_annot exp
  }
and 'exp_annot sentence =
  | AbortSentence
  | ReturnSentence of 'exp_annot return
  | AssignmentSentence of 'exp_annot lexp * 'exp_annot exp
  | VariableInitSentence of 'exp_annot variable_init
  | IfSingleSentence of 'exp_annot exp * 'exp_annot sentence
  | SelfdestructSentence of 'exp_annot exp
and 'exp_annot return =
  { return_value : 'exp_annot exp
  ; return_cont : 'exp_annot exp
  }

type arg =
  { arg_typ : typ
  ; arg_ident : string
  }

type 'exp_annot case_body =
  'exp_annot sentence list

type case_header =
  | UsualCaseHeader
  | DefaultCaseHeader

type 'exp_annot case =
  { case_header : case_header
  ; case_body : 'exp_annot case_body
  }

type 'exp_annot contract =
  { contract_name : string
  ; contract_arguments : arg list
  ; contract_cases : 'exp_annot case list
  }


let contract_name_of_return_cont ((r, _) : 'exp exp) : string option =
  match r with
  | CallExp c -> Some c.call_head
  | _ -> None
