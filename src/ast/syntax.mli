type typ =
  | VoidType (** the result of calling address.default() *)
  | Uint256Type
  | Uint8Type
  | Bytes32Type
  | AddressType
  | BoolType
  | ReferenceType of typ list (** pointer to [typ list] on memory *)
  | TupleType of typ list
  | MappingType of typ * typ
  | ContractArchType of string (* type of [bid(...)] where bid is a contract *)
  | ContractInstanceType of string (* type of [b] declared as [bid b] *)

type arg =
  { arg_typ : typ
  ; arg_ident : string
  ; arg_location : SideEffect.location option
  }

type event_arg =
  { event_arg_body : arg
  ; event_arg_indexed : bool
  }

type event =
  { event_name : string
  ; event_arguments : event_arg list
  }

type 'exp_annot function_call =
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
  ; send_head_method : string option (* None means default *)
  ; send_args : 'exp_annot exp list
  ; send_msg_info : 'exp_annot message_info
  }
and 'exp_annot exp = 'exp_annot exp_inner * 'exp_annot
and 'exp_annot exp_inner =
  | TrueExp
  | FalseExp
  | DecLit256Exp of Big_int.big_int
  | DecLit8Exp of Big_int.big_int
  | NowExp
  | FunctionCallExp of 'exp_annot function_call
  | IdentifierExp of string
  | ParenthExp of 'exp_annot exp
  | NewExp of 'exp_annot new_exp
  | SendExp of 'exp_annot send_exp
  | LandExp of 'exp_annot exp * 'exp_annot exp
  | LtExp of 'exp_annot exp * 'exp_annot exp
  | GtExp of 'exp_annot exp * 'exp_annot exp
  | NeqExp of 'exp_annot exp * 'exp_annot exp
  | EqualityExp of 'exp_annot exp * 'exp_annot exp
  | AddressExp of 'exp_annot exp
  | NotExp of 'exp_annot exp
  | ArrayAccessExp of 'exp_annot lexp
  | ValueExp
  | SenderExp
  | ThisExp
  | SingleDereferenceExp of 'exp_annot exp
  | TupleDereferenceExp of 'exp_annot exp
  | PlusExp of 'exp_annot exp * 'exp_annot exp
  | MinusExp of 'exp_annot exp * 'exp_annot exp
  | MultExp of 'exp_annot exp * 'exp_annot exp
  | BalanceExp of 'exp_annot exp
and 'exp_annot lexp =
  | ArrayAccessLExp of 'exp_annot array_access
and 'exp_annot array_access =
  { array_access_array : 'exp_annot exp
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
  | IfThenOnly of 'exp_annot exp * 'exp_annot sentence list
  | IfThenElse of 'exp_annot exp * 'exp_annot sentence list * 'exp_annot sentence list
  | SelfdestructSentence of 'exp_annot exp
  | ExpSentence of 'exp_annot exp
  | LogSentence of string * 'exp_annot exp list * event option
and 'exp_annot return =
  { return_exp : 'exp_annot exp option
  ; return_cont : 'exp_annot exp
  }

val read_array_access : 'exp_annot lexp -> 'exp_annot array_access

val event_arg_of_arg: arg -> bool -> event_arg
val arg_of_event_arg: event_arg -> arg

type 'exp_annot case_body =
  'exp_annot sentence list

type usual_case_header =
  { case_return_typ : typ list
  ; case_name : string
  ; case_arguments : arg list
  }

(** [split_event_args event args] returns [(indexed_args, unindexed_args)] *)
val split_event_args : event -> 'a exp list -> ('a exp list * 'a exp list)

type case_header =
  | UsualCaseHeader of usual_case_header
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

type 'exp_annot toplevel =
  | Contract of 'exp_annot contract
  | Event of event

val contract_name_of_return_cont : 'exp exp -> string option

val case_header_arg_list : case_header -> arg list

val contract_name_of_instance : (typ * 'x) exp -> string

val string_of_typ : typ -> string
val string_of_exp_inner : 'a exp_inner -> string

val is_mapping : typ -> bool
val count_plain_args : typ list -> int

val fits_in_one_storage_slot : typ -> bool
val calldata_size_of_arg : arg -> int

(** [size_of_typ typ] is the number of bytes that a value of [typ] occupies *)
val size_of_typ : typ -> int

(** [size_of_typs typs] is the sum of [size_of_typ]s *)
val size_of_typs : typ list -> int

val is_throw_only : typ sentence list -> bool

val non_mapping_arg : arg -> bool

(** [lookup_usual_case_header c name f] looks up a case called
    [name] in the contract [c].  [f] is a function that looks up a contract by its name. *)
val lookup_usual_case_header : typ contract -> string -> (string -> typ contract) -> usual_case_header

(** [might_become c] lists the name of the contracts that [c] might become, except [c] itself. *)
val might_become : typ contract -> string list

(** [acceptable_as wanted actual] is true when [actual] is acceptable as [wanted]. *)
val acceptable_as : typ -> typ -> bool
