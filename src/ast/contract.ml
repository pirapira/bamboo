type typ =
  | UintType
  | AddressType
  | MappingType of typ * typ

type arg =
  { arg_typ : typ
  ; arg_ident : string
  }

type sentence =
  | AbortSentence

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
