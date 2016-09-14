%token CONTRACT
%token <string> IDENT
%token ADDRESS
%token UINT
%token BOOL
%token LPAR
%token RPAR
%token COMMA
%token LSQBR
%token RSQBR
%token LBRACE
%token RBRACE
%token DOT
%token CASE
%token DEFAULT
%token IF
%token RETURN
%token FALSE
%token TRUE
%token THEN
%token SEMICOLON
%token EQUALITY
%token NEQ
%token LT
%token GT
%token SINGLE_EQ
%token NEW
%token ALONG
%token WITH
%token REENTRANCE
%token ABORT
%token HEIR
%token SELFDESTRUCT
%token NOT
%token EOF


%start <Contract.contract list> file
%%

file:
  | cs = contracts; EOF; { cs }
  ;

contracts:
  | cs = rev_contracts { List.rev cs }
  ;

rev_contracts:
  | (* empty *) { [] }
  | cs = rev_contracts;
    CONTRACT;
    IDENT;
    LPAR;
    argument_list;
    RPAR;
    LBRACE;
    css = cases;
    RBRACE;
    { { Contract.contract_cases = css; } :: cs }
  ;

cases:
  | css = rev_cases { List.rev css }
  ;

rev_cases:
  | (* empty *) { [] }
  | css = rev_cases;
    ch  = case_header;
    cb  = block;
    {
      { Contract.case_header = ch
      ; Contract.case_body = cb
      }
      :: css }
  ;

block:
  | LBRACE;
    scs = sentences;
    RBRACE
    { scs }
  ;

case_header:
  | DEFAULT { DefaultCaseHeader }
  | CASE; LPAR;
    typ;
    IDENT; (* function name *)
    LPAR;
    args = argument_list;
    RPAR;
    RPAR { UsualCaseHeader }
  ;

argument_list:
  | args = rev_argument_list { List.rev args }

rev_argument_list:
  | (* empty *) { [] }
  | args = non_empty_rev_argument_list;
    { args }
  ;

non_empty_rev_argument_list:
  | a = arg { [ a ] }
  | args = non_empty_rev_argument_list;
    COMMA;
    a = arg
    { a :: args }
  ;

arg:
  | t = typ;
    i = IDENT
    { { Contract.arg_typ = t
      ; Contract.arg_ident = i
      }
    }

typ:
  | UINT { Contract.UintType }
  | ADDRESS { Contract.AddressType }
  | BOOL { Contract.BoolType }
  | value = typ;
    LSQBR;
    key = typ;
    RSQBR;
    { Contract.MappingType (key, value) }
  | s = IDENT { Contract.IdentType s }

sentences:
  | scs = rev_sentences { List.rev scs }
  ;

rev_sentences:
  | (* empty *) { [] }
  | scs = rev_sentences;
    s = sentence;
    { s :: scs }
  ;

sentence :
  | ABORT; SEMICOLON { Contract.AbortSentence }
  | RETURN; value = exp; THEN; cont = exp; SEMICOLON
    { Contract.ReturnSentence { return_value = value; return_cont = cont} }
  | lhs = lexp; SINGLE_EQ; rhs = exp; SEMICOLON
    { Contract.AssignmentSentence (lhs, rhs) }
  | t = typ;
    name = IDENT;
    SINGLE_EQ;
    value = exp;
    SEMICOLON { Contract.VariableInitSentence
                { variable_init_type = t
                ; variable_init_name = name
                ; variable_init_value = value
                }
              }
  | IF; LPAR; cond = exp; RPAR; body =sentence { Contract.IfSingleSentence (cond, body) }
  | SELFDESTRUCT; e = exp; SEMICOLON { Contract.SelfdestructSentence e }
  ;

exp:
  | TRUE { Contract.TrueExp }
  | FALSE { Contract.FalseExp }
  | lhs = exp; LT; rhs = exp { Contract.LtExp (lhs, rhs) }
  | lhs = exp; GT; rhs = exp { Contract.GtExp (lhs, rhs) }
  | lhs = exp; NEQ; rhs = exp { Contract.NeqExp (lhs, rhs) }
  | lhs = exp; EQUALITY; rhs = exp { Contract.EqualityExp (lhs, rhs) }
  | s = IDENT
    { Contract.IdentifierExp s }
  | LPAR;
    e = exp;
    RPAR
    { Contract.ParenthExp e }
  | s = IDENT; LPAR; RPAR { Contract.CallExp { call_head = s; call_args = [] } }
  | s = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR { Contract.CallExp { call_head = s; call_args = fst :: lst } }
  | NEW; s = IDENT; LPAR; RPAR; m = msg_info { Contract.NewExp { new_head = s; new_args = []; new_msg_info = m } }
  | NEW; s = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR; m = msg_info { Contract.NewExp { new_head = s; new_args = fst :: lst; new_msg_info = m } }
  | contr = exp; DOT; mtd = IDENT;
    LPAR; RPAR; m = msg_info
    { Contract.SendExp { send_head_contract = contr; send_head_method = mtd
                       ; send_args = []; send_msg_info = m } }
  | contr = exp; DOT; mtd = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR; m = msg_info
    { Contract.SendExp { send_head_contract = contr; send_head_method = mtd
                       ; send_args = (fst :: lst); send_msg_info = m } }
  | ADDRESS; e = exp { Contract.AddressExp e }
  | NOT; e = exp { Contract.NotExp e }
  | s = IDENT;
    LSQBR;
    idx = exp;
    RSQBR
    { Contract.ArrayAccessExp {array_access_array = s; array_access_index = idx} }
  ;

msg_info:
  | v = value_info; r = reentrance_info { { Contract.message_value_info = v;
                                            message_reentrance_info = r } }
  ;

value_info:
  | (* empty *) { None }
  | ALONG; v = exp; { Some v }
  ;

reentrance_info:
  | REENTRANCE; b = block { b }
  ;

lexp:
  | s = IDENT { Contract.IdentifierLExp s }
  | s = IDENT;
    LSQBR;
    idx = exp;
    RSQBR
    { Contract.ArrayAccessLExp {array_access_array = s; array_access_index = idx} }
  ;

comma_exp_list:
  | lst = rev_comma_exp_list
    { List.rev lst }
  ;

rev_comma_exp_list:
  | (* empty *) { [] }
  | lst = rev_comma_exp_list;
    COMMA;
    e = exp
    { e :: lst }
  ;