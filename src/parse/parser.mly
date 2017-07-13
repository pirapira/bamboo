%token CONTRACT
%token <string> IDENT
%token ADDRESS
%token UINT
%token UINT8
%token BYTES32
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
%token BECOME
%token SEMICOLON
%token EQUALITY
%token NEQ
%token LT
%token GT
%token SINGLE_EQ
%token NEW
%token ALONG
%token REENTRANCE
%token ABORT
%token SELFDESTRUCT
%token NOT
%token VALUE
%token SENDER
%token MSG
%token THIS
%token NOW
%token BLOCK
%token EOF


%start <unit Syntax.contract list> file
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
    name = IDENT;
    LPAR;
    args = argument_list;
    RPAR;
    LBRACE;
    css = cases;
    RBRACE;
    { { Syntax.contract_cases = css
      ; contract_name = name
      ; contract_arguments = args} :: cs }
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
      { Syntax.case_header = ch
      ; Syntax.case_body = cb
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
  | DEFAULT { Syntax.DefaultCaseHeader }
  | CASE; LPAR;
    return_typ = typ;
    name = IDENT;
    LPAR;
    args = argument_list;
    RPAR;
    RPAR { Syntax.UsualCaseHeader
      { case_return_typ = [return_typ] (* multi returns not supported *)
      ; Syntax.case_name = name
      ; case_arguments = args
      }
    }
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
    { { Syntax.arg_typ = t
      ; Syntax.arg_ident = i
      }
    }

typ:
  | UINT { Syntax.UintType }
  | UINT8 { Syntax.Uint8Type }
  | BYTES32 { Syntax.Bytes32Type }
  | ADDRESS { Syntax.AddressType }
  | BOOL { Syntax.BoolType }
  | value = typ;
    LSQBR;
    key = typ;
    RSQBR;
    { Syntax.MappingType (key, value) }
  | s = IDENT { Syntax.ContractInstanceType s }

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
  | ABORT; SEMICOLON { Syntax.AbortSentence }
  | RETURN; value = exp; THEN; BECOME; cont = exp; SEMICOLON
    { Syntax.ReturnSentence { Syntax. return_exp = value; return_cont = cont} }
  | lhs = lexp; SINGLE_EQ; rhs = exp; SEMICOLON
    { Syntax.AssignmentSentence (lhs, rhs) }
  | t = typ;
    name = IDENT;
    SINGLE_EQ;
    value = exp;
    SEMICOLON { Syntax.VariableInitSentence
                { Syntax.variable_init_type = t
                ; variable_init_name = name
                ; variable_init_value = value
                }
              }
  | IF; LPAR; cond = exp; RPAR; body =sentence { Syntax.IfSingleSentence (cond, body) }
  | SELFDESTRUCT; e = exp; SEMICOLON { Syntax.SelfdestructSentence e }
  ;

exp:
  | TRUE { Syntax.TrueExp, () }
  | FALSE { Syntax.FalseExp, () }
  | VALUE LPAR MSG RPAR { Syntax.ValueExp, () }
  | SENDER LPAR MSG RPAR { Syntax.SenderExp, () }
  | NOW LPAR BLOCK RPAR { Syntax.NowExp, () }
  | lhs = exp; LT; rhs = exp { Syntax.LtExp (lhs, rhs), () }
  | lhs = exp; GT; rhs = exp { Syntax.GtExp (lhs, rhs), () }
  | lhs = exp; NEQ; rhs = exp { Syntax.NeqExp (lhs, rhs), () }
  | lhs = exp; EQUALITY; rhs = exp { Syntax.EqualityExp (lhs, rhs), () }
  | s = IDENT
    { Syntax.IdentifierExp s, () }
  | LPAR;
    e = exp;
    RPAR
    { Syntax.ParenthExp e, () }
  | s = IDENT; LPAR; RPAR { Syntax.FunctionCallExp { Syntax.call_head = s; call_args = [] }, () }
  | s = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR { Syntax.FunctionCallExp {
                                   Syntax.call_head = s; call_args = fst :: lst }, () }
  | NEW; s = IDENT; LPAR; RPAR; m = msg_info { Syntax.NewExp { Syntax.new_head = s; new_args = []; new_msg_info = m }, () }
  | NEW; s = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR; m = msg_info { Syntax.NewExp { Syntax.new_head = s; new_args = fst :: lst; new_msg_info = m }, () }
  | contr = exp; DOT; mtd = IDENT;
    LPAR; RPAR; m = msg_info
    { Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = mtd
                       ; send_args = []; send_msg_info = m }, () }
  | contr = exp; DOT; mtd = IDENT; LPAR; fst = exp;
    lst = comma_exp_list; RPAR; m = msg_info
    { Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = mtd
                       ; send_args = (fst :: lst); send_msg_info = m }, () }
  | ADDRESS; e = exp { Syntax.AddressExp e, () }
  | NOT; e = exp { Syntax.NotExp e, () }
  | THIS { Syntax.ThisExp, () }
  | s = IDENT;
    LSQBR;
    idx = exp;
    RSQBR
    { Syntax.ArrayAccessExp {
        Syntax.array_access_array = s; array_access_index = idx}, () }
  ;

msg_info:
  | v = value_info; r = reentrance_info { { Syntax.message_value_info = v;
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
  | s = IDENT { Syntax.IdentifierLExp s }
  | s = IDENT;
    LSQBR;
    idx = exp;
    RSQBR
    { Syntax.ArrayAccessLExp {
       Syntax.array_access_array = s; array_access_index = idx} }
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