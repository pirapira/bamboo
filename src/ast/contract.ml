type call =
  {  call_head : string
  ;  call_args : exp list
  }
and exp =
  | TrueExp
  | CallExp of call
  | IdentifierExp of string
  | ParenthExp of exp
and lexp =
  | IdentifierLExp of string

type typ =
  | UintType
  | AddressType
  | BoolType
  | MappingType of typ * typ

type arg =
  { arg_typ : typ
  ; arg_ident : string
  }

type return =
  { return_value : exp
  ; return_cont : exp
  }

type sentence =
  | AbortSentence
  | ReturnSentence of return
  | AssignmentSentence of lexp * exp

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
