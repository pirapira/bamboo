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
%token CASE
%token DEFAULT
%token IF
%token RETURN
%token FALSE
%token TRUE
%token THEN
%token SEMICOLON
%token EQUQLITY
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
    IDENT; LPAR; RPAR;
    LBRACE;
    cases;
    opt_default;
    RBRACE;
    { () :: cs }
  ;

opt_default:
  | DEFAULT;
    case_body;
    {}
  | {}
  ;

cases:
  | css = rev_cases { }
  ;

rev_cases:
  | (* empty *) { }
  | css = rev_cases;
    case_body;
    { }
  ;

case_body:
  | LBRACE;
    sentences;
    RBRACE;
    { }
  ;

sentences:
  | scs = rev_sentences { }
  ;

rev_sentences:
  | (* empty *) { }
  | rev_sentences;
    ABORT;
    SEMICOLON;
    { }
  ;
