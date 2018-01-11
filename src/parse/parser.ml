
module Basics = struct
  
  exception Error
  
  type token = 
    | VOID
    | VALUE
    | UINT8
    | UINT256
    | TRUE
    | THIS
    | THEN
    | SINGLE_EQ
    | SENDER
    | SEMICOLON
    | SELFDESTRUCT
    | RSQBR
    | RPAR
    | RETURN
    | REENTRANCE
    | RBRACE
    | RARROW
    | PLUS
    | NOW
    | NOT
    | NEQ
    | MULT
    | MSG
    | MINUS
    | LT
    | LSQBR
    | LPAR
    | LOG
    | LBRACE
    | LAND
    | INDEXED
    | IF
    | IDENT of (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 43 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
  )
    | GT
    | FALSE
    | EVENT
    | EQUALITY
    | EOF
    | ELSE
    | DOT
    | DEPLOY
    | DEFAULT
    | DECLIT8 of (
# 4 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (Big_int.big_int)
# 57 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
  )
    | DECLIT256 of (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (Big_int.big_int)
# 62 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
  )
    | CONTRACT
    | COMMA
    | CASE
    | BYTES32
    | BOOL
    | BLOCK
    | BECOME
    | BALANCE
    | ALONG
    | ADDRESS
    | ABORT
  
end

include Basics

let _eRR =
  Error

module Tables = struct
  
  include Basics
  
  let token2terminal : token -> int =
    fun _tok ->
      match _tok with
      | ABORT ->
          55
      | ADDRESS ->
          54
      | ALONG ->
          53
      | BALANCE ->
          52
      | BECOME ->
          51
      | BLOCK ->
          50
      | BOOL ->
          49
      | BYTES32 ->
          48
      | CASE ->
          47
      | COMMA ->
          46
      | CONTRACT ->
          45
      | DECLIT256 _ ->
          44
      | DECLIT8 _ ->
          43
      | DEFAULT ->
          42
      | DEPLOY ->
          41
      | DOT ->
          40
      | ELSE ->
          39
      | EOF ->
          38
      | EQUALITY ->
          37
      | EVENT ->
          36
      | FALSE ->
          35
      | GT ->
          34
      | IDENT _ ->
          33
      | IF ->
          32
      | INDEXED ->
          31
      | LAND ->
          30
      | LBRACE ->
          29
      | LOG ->
          28
      | LPAR ->
          27
      | LSQBR ->
          26
      | LT ->
          25
      | MINUS ->
          24
      | MSG ->
          23
      | MULT ->
          22
      | NEQ ->
          21
      | NOT ->
          20
      | NOW ->
          19
      | PLUS ->
          18
      | RARROW ->
          17
      | RBRACE ->
          16
      | REENTRANCE ->
          15
      | RETURN ->
          14
      | RPAR ->
          13
      | RSQBR ->
          12
      | SELFDESTRUCT ->
          11
      | SEMICOLON ->
          10
      | SENDER ->
          9
      | SINGLE_EQ ->
          8
      | THEN ->
          7
      | THIS ->
          6
      | TRUE ->
          5
      | UINT256 ->
          4
      | UINT8 ->
          3
      | VALUE ->
          2
      | VOID ->
          1
  
  and error_terminal =
    0
  
  and token2value : token -> Obj.t =
    fun _tok ->
      match _tok with
      | ABORT ->
          Obj.repr ()
      | ADDRESS ->
          Obj.repr ()
      | ALONG ->
          Obj.repr ()
      | BALANCE ->
          Obj.repr ()
      | BECOME ->
          Obj.repr ()
      | BLOCK ->
          Obj.repr ()
      | BOOL ->
          Obj.repr ()
      | BYTES32 ->
          Obj.repr ()
      | CASE ->
          Obj.repr ()
      | COMMA ->
          Obj.repr ()
      | CONTRACT ->
          Obj.repr ()
      | DECLIT256 _v ->
          Obj.repr _v
      | DECLIT8 _v ->
          Obj.repr _v
      | DEFAULT ->
          Obj.repr ()
      | DEPLOY ->
          Obj.repr ()
      | DOT ->
          Obj.repr ()
      | ELSE ->
          Obj.repr ()
      | EOF ->
          Obj.repr ()
      | EQUALITY ->
          Obj.repr ()
      | EVENT ->
          Obj.repr ()
      | FALSE ->
          Obj.repr ()
      | GT ->
          Obj.repr ()
      | IDENT _v ->
          Obj.repr _v
      | IF ->
          Obj.repr ()
      | INDEXED ->
          Obj.repr ()
      | LAND ->
          Obj.repr ()
      | LBRACE ->
          Obj.repr ()
      | LOG ->
          Obj.repr ()
      | LPAR ->
          Obj.repr ()
      | LSQBR ->
          Obj.repr ()
      | LT ->
          Obj.repr ()
      | MINUS ->
          Obj.repr ()
      | MSG ->
          Obj.repr ()
      | MULT ->
          Obj.repr ()
      | NEQ ->
          Obj.repr ()
      | NOT ->
          Obj.repr ()
      | NOW ->
          Obj.repr ()
      | PLUS ->
          Obj.repr ()
      | RARROW ->
          Obj.repr ()
      | RBRACE ->
          Obj.repr ()
      | REENTRANCE ->
          Obj.repr ()
      | RETURN ->
          Obj.repr ()
      | RPAR ->
          Obj.repr ()
      | RSQBR ->
          Obj.repr ()
      | SELFDESTRUCT ->
          Obj.repr ()
      | SEMICOLON ->
          Obj.repr ()
      | SENDER ->
          Obj.repr ()
      | SINGLE_EQ ->
          Obj.repr ()
      | THEN ->
          Obj.repr ()
      | THIS ->
          Obj.repr ()
      | TRUE ->
          Obj.repr ()
      | UINT256 ->
          Obj.repr ()
      | UINT8 ->
          Obj.repr ()
      | VALUE ->
          Obj.repr ()
      | VOID ->
          Obj.repr ()
  
  and default_reduction =
    (8, "\000\000\000\000LKQMON\000\000\000\000\011\0021\000\000\t\000\000H\n\000\000\000\000/\000\000\000\005\000\000\000\000\000\000\000\007\000\000F\000\000\000\000\000\006\000\b\000\000\000\000\000\000\000\017\r$\000\000\000\018\000\000\000\020\000\000\000\000\014\000\000\000\016\015\000\000\000\000%\000\"\000\000\000\000\000\000'\000\000\000\000\000\000\0003\000\000\000\000\000\000\000\000\000\000\000\000\000\00074!\000\000J\000\000\000 \000\019\000\000\031\000\030\000\029\000\000<\000\000D\000\000\000\000\0009\000\000\000\000\000\000C\000\000\000\000\000\000\0008\000\000\000\000;\000\000=\000\000\000:\000>\000\000?@\000-\000\003\004\000)\000&\001\000+")
  
  and error =
    (56, "\000\000\000\000\n\004\000\000\000\000\000@\000\000\000\000\000\016\000\000\000\024\004\000\000@\000\194\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000@\001@\000\000\024\000\000\000@\000\194\000\000@\001@\000\000\000\000\000\000@\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000 \000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\002\000\024\000\000\000@\000\194\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000@\000\000\000\000\000\016\000\000\000\024\004\000\000@\000\194\000\000@\000@\000\000\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\000\000\004\000\000\000\000\000\128\000\000!\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000X\000\000\000@\000\194\000\000\000\000@\000\000\000\000\000\016\000\000\000\024\004\000\000@\000\194\000\004\000\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000\002\000\024\000\000\000@\000\194\000\000\000\000\000\000\000\000\000@\000@\000\000\000\000\000\016\000\000\000\024\004\000\000@\000\194\000\004\000\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\004\000\000\000~R\152\024\208X\203\000\128\000\000\000\000\000&@\024\016PX\n\000\000\000\016\000\000\000\000\000\001\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000\000\000\001\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000\000\000\000\000\000\000 \000\004\000\000\000\000\000\000\000\000\000\000\000\000&@\024\016PX\n&@\024\016PX\n\001-&\242$\130\000&D\024\016PX\n\000\000\000\000\000\000\000\000\000\000\000@\000\000\000\000\000\016\000\000\000&D\024\016PX\n\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000&@\024\016PX\n\000\000\000\016\000\000\000&@\024\016PX\n\000\000\000\000\000\000\000\000\004&\226$\128\000\000\000\000\000\000\000\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\000\b&\226$\128\000\000\000\000\000\000\000\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\001-&\226$\130\000\000\000\000\000@ \000\000\000\000\016\000\000\000&D\024\016PX\n\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\001\000\000\000\000\004&@\024\016PX\n\000\001&\226$\128\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\001-&\226$\130\000&@\024\016PX\n\001-&\226$\130\000\000\001\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\004&\226$\130\000&@\024\016PX\n\000\000\000\000\000\000\000\000\000\000\016\000\000\000\000\004\000\000\000\000\000\000\001\000\000\000\000\004\000\000\000\000\000\000\000\000\004&\226$\128\000\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\001\000\000\000\000\004\000\000\000\000\000\000\000\000\004\000\000\000\000\000\000\000\000\000\000\000\000\000\004&\226$\128\000\000\000\000\000\000\000\000\001-&\226$\130\000\000 &\226$\128\000\000\000\000\000\000\000\000&@\024\016PX\n\000 &\226$\128\000\000\000\000\000\000\000\000'@\024\016PX\n\001\000\000\000\000\000\000\000\000\000\000\000\000\016&@\024\016PX\n\000 &\226$\128\000\000\000\000\000\000\000\000\001\000&\226$\128\000\000\000\000\000@\000\000\000\000\000\016\000\000\000&D\024\016PX\n\000\004\000\000\000\000\000\000 \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\016\000\000\000&@\024\016PX\n\000\004&\226$\128\000~R\024\028\208X\203\000\000f\242d\128\000\000\000@\016@\000\000\000 \000\000\000\000\000\000\000\000\000\000\000\000\000\000@\000@\000\000\000\128\000\000\000\000\000&@\024\016PX\n\000 &\226$\128\000\000\000\000\000\000\000\000~R\152\024\209X\203~R\024\028\208X\203\000\000\000\000\000\000\000\000\128&\226$\128\000&@\024\016PX\n\000 &\226$\128\000\000\000\000\000\000\000\000\000\000&\226$\128\000\000\000\000\000\000\000\000~R\152\024\209X\203~R\024\028\208X\203\000\000\000\000\000\000\000\000\000\000\000\000\000\000~R\152\024\208X\203\000\000\000\000\000\000\000\000\000\128\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\128\000\000!\000\000\000\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\n\004\000\000\000\000\000\000\000\000")
  
  and start =
    1
  
  and action =
    ((16, "\000\017\0005\000\011\004\206\000\000\000\000\000\000\000\000\000\000\000\000\000\136\004\178\000\246\000\004\000\000\000\000\000\000\000t\000\146\000\000\000\006\004\178\000\000\000\000\000v\000\138\004\212\000:\000\000\000\182\000\152\001D\000\000\000\160\004\178\000\168\000\198\004\212\001\b\001\012\000\000\000>\004\178\000\000\000\230\000\248\004\212\001&\0012\000\000\0018\000\000\000\218\000\218\001L\002\170\0018\001B\001Z\000\000\000\000\000\000\001F\001\\\001r\000\000\001Z\001<\001\138\000\000\002\170\002\170\0016\002\170\000\000\001f\001t\002\170\000\000\000\000\001z\002\170\001\028\002\170\000\000\003t\000\000\002\170\000\003\002\170\000l\002\170\002\170\000\000\002\170\000\218\002\170\001j\000\016\001\136\002\170\000\000\001\166\000J\002\170\002\170\002\170\001\158\002\170\001\210\002\170\002\006\002\170\002:\001\166\000\218\000\000\000\000\000\000\002\250\002\170\000\000\001\150\001\186\000J\000\000\003\156\000\000\001\188\000J\000\000\001\190\000\000\003\196\000\000\002n\002\250\000\000\002\170\003\230\000\000\002\250\001\206\001x\002\170\004\b\000\000\003\156\001\162\001\188\002\170\001\218\001\228\000\000\001\202\002\170\0040\000\218\003F\001\028\001\244\000\000\0014\001\250\002\170\004R\000\000\000\003\000\218\000\000\004z\002\170\004\156\000\000\002n\000\000\000l\000\218\000\000\000\000\000\218\000\000\001\236\000\000\000\000\001D\000\000\001\196\000\000\000\000\000\017\000\000"), (16, "\001\001\001\001\001\001\001\001\001\001\001\001\000Q\000\n\001\001\000Q\001\001\000Q\000Q\001\001\000Q\001\001\001\025\000Q\001\001\001\001\000Q\001f\000\014\000Q\000Q\001n\001\001\001\001\000\006\000Q\000\165\001\001\001\001\000Q\001\001\000:\000Q\000b\002\162\001\138\001\001\001\142\001\001\001\001\001\017\000Q\000.\001\001\001\001\000V\001\234\001\001\001E\001\001\001\001\001\005\001\005\001\005\001\005\001\005\001\005\000Y\000>\001\005\000Y\001\005\000Y\000Y\001\005\000Y\001\005\000J\000Y\001\005\001\005\000Y\000Y\000\170\000Y\000Y\001n\001\005\001\005\000N\000Y\000.\001\005\001\005\000Y\001\005\001\162\000Y\000f\002\198\001\138\001\005\000j\001\005\001\005\0006\000Y\000>\001\005\001\005\000z\000~\001\005\000\138\001\005\001\005\000\218\000\226\000\018\000\022\000\242\000\246\000e\000\146\000\250\000e\002*\000e\000e\0026\000e\000\173\000\150\001^\001\n\001\026\000e\001f\000.\001\130\000e\001n\001\030\002R\000\214\000e\000.\002j\002z\000e\001*\000\158\000e\000\162\000\182\001\138\001.\000\186\001:\001>\001=\000e\001=\000\030\000\"\0015\000\194\001B\000m\002~\002\130\000m\000\198\000m\000m\001N\000m\000.\000\206\000m\000\222\0015\000m\000m\000\157\000m\000m\000m\001&\000\230\000\234\000m\000\238\002\142\000U\000m\000\254\000U\000m\000U\000U\000m\000U\001\002\001\006\000U\001\014\000m\000U\001f\000\130\000U\000U\001n\001\018\000\134\001\022\000U\0012\0016\000]\000U\001F\000]\000U\000]\000]\001\138\000]\001\146\001\158\001^\001\206\000U\000]\001f\001\238\001\130\000]\001n\001\242\002\006\002\018\000]\002>\002B\000-\000]\002V\000-\000]\000-\000-\001\138\000-\002Z\002b\001^\002f\000]\001z\001f\002n\001\130\001\170\001n\002\134\002\146\002\222\000-\002\243\000\000\000a\001\186\000\000\000a\001\194\000a\000a\001\138\000a\000\000\000\000\001^\000\000\000-\000a\001f\000\000\001\130\000a\001n\000\000\000\000\000\000\000a\000\000\000\000\000i\000a\000\000\000i\000a\000i\000i\001\138\000i\000\000\000\000\001^\000\000\000a\000i\001f\000\000\001\130\000i\001n\000\000\000\000\000\000\000i\000\000\000\000\000\137\000i\000\000\000\137\000i\000\137\000\137\001\138\000\137\000\000\000\000\001^\000\000\000i\001z\001f\000\000\001\130\001\170\001n\000\000\000\000\000\000\001\178\000\000\000\226\000\000\001\186\000\242\000\246\001\194\000\000\000\250\001\138\000\000\001v\000\197\000\000\001I\000\137\000\000\001^\001\n\001\026\001z\001f\000\000\001\130\001\170\001n\001\030\000\000\000\000\001\178\000\000\000\000\001\"\001\186\001*\000\000\001\194\000\000\000\000\001\138\001.\000\226\001:\001>\000\242\000\246\000\209\000\000\000\250\002&\000\000\001B\001!\001J\000\000\000\000\000\000\001^\001\n\001\026\001z\001f\000\000\001\130\001\170\001n\001\030\000\000\000\000\001\178\000\000\000\000\001\"\001\186\001*\000\000\001\194\000\000\000\000\001\138\001.\000\000\001:\001>\000\000\001\226\000\000\000\000\000\000\000\000\000\000\001B\000\000\001J\001A\000m\000\000\000\000\000m\000m\000\000\000m\000m\000m\001&\000\000\000\000\000m\000\000\000\000\001A\000m\000\000\001Z\000m\000\000\000\000\000m\001^\000\000\000\000\001z\001f\000\000\001\130\001\170\001n\000\213\000\000\000\000\001\178\000\000\000\000\001\254\001\186\000\000\000\000\001\194\001^\000\000\001\138\001z\001f\000\000\001\130\001\170\001n\000\000\000\000\000\000\001\178\000\000\000\000\002\026\001\186\000\000\000\000\001\194\001^\000\000\001\138\001z\001f\000\000\001\130\001\170\001n\0022\000\000\000\000\001\178\000\000\000\000\000\000\001\186\001^\000\000\001\194\001z\001f\001\138\001\130\001\170\001n\002J\000\000\000\000\001\178\000\000\000\000\000\000\001\186\001^\000\000\001\194\001z\001f\001\138\001\130\001\170\001n\000\000\000\000\000\000\001\178\000\000\000\000\002v\001\186\000\000\000\000\001\194\001^\000\000\001\138\001z\001f\000\000\001\130\001\170\001n\002\154\000\000\000\000\001\178\000\000\000\000\000\000\001\186\001^\000\000\001\194\001z\001f\001\138\001\130\001\170\001n\000\000\002\174\000\000\001\178\000\000\000\000\000\000\001\186\000\000\000\000\001\194\000\145\000\000\001\138\000\145\000\145\000\000\000\145\000\145\000\145\002\182\000\000\000\142\000\145\000\018\000\022\000\000\000\145\001^\000\000\000\145\001z\001f\000\145\001\130\001\170\001n\000\000\000\018\000\022\001\178\000\018\000\022\000\000\001\186\000\000\000\000\001\194\000\189\000\000\001\138\000\181\000\000\000\000\000\026\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\026\000\030\000\"\000\026\000\000\000\000\000\000\000&\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\030\000\"\000\000\000\030\000\"\000\000\000&\000\000\000\000\000&"))
  
  and lhs =
    (8, "\000\024\023\022\021\021\021\020\020\019\019\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\018\017\016\015\015\014\014\r\r\012\012\011\011\n\n\t\b\b\007\006\006\006\006\006\006\006\006\006\006\006\006\006\005\005\004\004\003\003\002\002\002\002\002\002\002\001\001")
  
  and goto =
    ((8, "\003\000\000\005\000\000\000\000\000\000\000\006\000\000\000\000\000\000\000\000\000@\000\000\000\000<\000\000\000\000v\000\0002\000\000L\000\000\000\000\146\000\000\000V\000\000\000\000\000:\004\000\031\000\000\000\000\000\000\000\000\000\000\000\000\000\000V\134\000d\000\000\000l\000\000\000\150\000\160\000\000\000\166\000\168\000\174\000\000\176\000\182\000\000\000n\000\000:\184\000\190\000\192\000\198\000\200\000p~\000\000\000\000\148\000\000\000\236\000\000\000\000\238\000\000\000\000\000\000\000\000\210\000\000\142\000\000\212\000\000\000\000\000\132\000\000\000\000\226\000\n\000\000\000\000\000\000\228\000\000\000\016\000\000\234\000\000\000\000\000.\000\000>\000\000\000\000\146\000\000\000\000\017\000"), (8, "\011U\017\137\163\r\192\163\181\018\163\168\191\188\170\183\190\021\171\191\175\171\024\175\171\163\175-\177\179s\176\028\163\011\029\023\181w\171\028\175\030\029\182\028\180\171\029\175'\021\185f*0\024ffU\132\136*v\129gU*xfUUxx3\028\152z,\1435\186UUx\134uU\187\148UUx\1275\186U*VUUY[UU]`UUbjUUlnUUprssUU\140\146\000\000~\131UU\157\166U\000\173"))
  
  and semantic_action =
    [|
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = i;
          MenhirLib.EngineTypes.startp = _startpos_i_;
          MenhirLib.EngineTypes.endp = _endpos_i_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = t;
            MenhirLib.EngineTypes.startp = _startpos_t_;
            MenhirLib.EngineTypes.endp = _endpos_t_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let i : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 355 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic i in
        let t : 'tv_typ = Obj.magic t in
        let _startpos = _startpos_t_ in
        let _endpos = _endpos_i_ in
        let _v : 'tv_arg = 
# 139 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( { Syntax.arg_typ = t
      ; Syntax.arg_ident = i
      ; Syntax.arg_location = None
      }
    )
# 367 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = scs;
            MenhirLib.EngineTypes.startp = _startpos_scs_;
            MenhirLib.EngineTypes.endp = _endpos_scs_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let scs : 'tv_list_sentence_ = Obj.magic scs in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : 'tv_block = 
# 109 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( scs )
# 403 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = cb;
          MenhirLib.EngineTypes.startp = _startpos_cb_;
          MenhirLib.EngineTypes.endp = _endpos_cb_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = ch;
            MenhirLib.EngineTypes.startp = _startpos_ch_;
            MenhirLib.EngineTypes.endp = _endpos_ch_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let cb : 'tv_block = Obj.magic cb in
        let ch : 'tv_case_header = Obj.magic ch in
        let _startpos = _startpos_ch_ in
        let _endpos = _endpos_cb_ in
        let _v : 'tv_case = 
# 98 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    (
      { Syntax.case_header = ch
      ; Syntax.case_body = cb
      }
     )
# 437 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_case_header = 
# 113 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.DefaultCaseHeader )
# 461 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _300;
            MenhirLib.EngineTypes.startp = _startpos__300_;
            MenhirLib.EngineTypes.endp = _endpos__300_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs000;
              MenhirLib.EngineTypes.startp = _startpos_xs000_;
              MenhirLib.EngineTypes.endp = _endpos_xs000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _100;
                MenhirLib.EngineTypes.startp = _startpos__100_;
                MenhirLib.EngineTypes.endp = _endpos__100_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = name;
                  MenhirLib.EngineTypes.startp = _startpos_name_;
                  MenhirLib.EngineTypes.endp = _endpos_name_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = return_typ;
                    MenhirLib.EngineTypes.startp = _startpos_return_typ_;
                    MenhirLib.EngineTypes.endp = _endpos_return_typ_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.semv = _2;
                      MenhirLib.EngineTypes.startp = _startpos__2_;
                      MenhirLib.EngineTypes.endp = _endpos__2_;
                      MenhirLib.EngineTypes.next = {
                        MenhirLib.EngineTypes.state = _menhir_s;
                        MenhirLib.EngineTypes.semv = _1;
                        MenhirLib.EngineTypes.startp = _startpos__1_;
                        MenhirLib.EngineTypes.endp = _endpos__1_;
                        MenhirLib.EngineTypes.next = _menhir_stack;
                      };
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let _300 : unit = Obj.magic _300 in
        let xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__ = Obj.magic xs000 in
        let _100 : unit = Obj.magic _100 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 521 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let return_typ : 'tv_typ = Obj.magic return_typ in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v : 'tv_case_header = let args =
          let _30 = _300 in
          let xs00 = xs000 in
          let _10 = _100 in
          let xs =
            let _3 = _30 in
            let xs0 = xs00 in
            let _1 = _10 in
            let x =
              let xs = xs0 in
              
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 541 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 547 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 553 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 118 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.UsualCaseHeader
      { case_return_typ = [return_typ] (* multi returns not supported *)
      ; Syntax.case_name = name
      ; case_arguments = args
      }
    )
# 564 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _300;
            MenhirLib.EngineTypes.startp = _startpos__300_;
            MenhirLib.EngineTypes.endp = _endpos__300_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs000;
              MenhirLib.EngineTypes.startp = _startpos_xs000_;
              MenhirLib.EngineTypes.endp = _endpos_xs000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _100;
                MenhirLib.EngineTypes.startp = _startpos__100_;
                MenhirLib.EngineTypes.endp = _endpos__100_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = name;
                  MenhirLib.EngineTypes.startp = _startpos_name_;
                  MenhirLib.EngineTypes.endp = _endpos_name_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _3;
                    MenhirLib.EngineTypes.startp = _startpos__3_;
                    MenhirLib.EngineTypes.endp = _endpos__3_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.semv = _2;
                      MenhirLib.EngineTypes.startp = _startpos__2_;
                      MenhirLib.EngineTypes.endp = _endpos__2_;
                      MenhirLib.EngineTypes.next = {
                        MenhirLib.EngineTypes.state = _menhir_s;
                        MenhirLib.EngineTypes.semv = _1;
                        MenhirLib.EngineTypes.startp = _startpos__1_;
                        MenhirLib.EngineTypes.endp = _endpos__1_;
                        MenhirLib.EngineTypes.next = _menhir_stack;
                      };
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let _300 : unit = Obj.magic _300 in
        let xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__ = Obj.magic xs000 in
        let _100 : unit = Obj.magic _100 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 624 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v : 'tv_case_header = let args =
          let _30 = _300 in
          let xs00 = xs000 in
          let _10 = _100 in
          let xs =
            let _3 = _30 in
            let xs0 = xs00 in
            let _1 = _10 in
            let x =
              let xs = xs0 in
              
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 644 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 650 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 656 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 128 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.UsualCaseHeader
      { case_return_typ = []
      ; Syntax.case_name = name
      ; case_arguments = args
      }
    )
# 667 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = css;
            MenhirLib.EngineTypes.startp = _startpos_css_;
            MenhirLib.EngineTypes.endp = _endpos_css_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _4;
              MenhirLib.EngineTypes.startp = _startpos__4_;
              MenhirLib.EngineTypes.endp = _endpos__4_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _300;
                MenhirLib.EngineTypes.startp = _startpos__300_;
                MenhirLib.EngineTypes.endp = _endpos__300_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = xs000;
                  MenhirLib.EngineTypes.startp = _startpos_xs000_;
                  MenhirLib.EngineTypes.endp = _endpos_xs000_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _100;
                    MenhirLib.EngineTypes.startp = _startpos__100_;
                    MenhirLib.EngineTypes.endp = _endpos__100_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.semv = name;
                      MenhirLib.EngineTypes.startp = _startpos_name_;
                      MenhirLib.EngineTypes.endp = _endpos_name_;
                      MenhirLib.EngineTypes.next = {
                        MenhirLib.EngineTypes.state = _menhir_s;
                        MenhirLib.EngineTypes.semv = _1;
                        MenhirLib.EngineTypes.startp = _startpos__1_;
                        MenhirLib.EngineTypes.endp = _endpos__1_;
                        MenhirLib.EngineTypes.next = _menhir_stack;
                      };
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let css : 'tv_list_case_ = Obj.magic css in
        let _4 : unit = Obj.magic _4 in
        let _300 : unit = Obj.magic _300 in
        let xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__ = Obj.magic xs000 in
        let _100 : unit = Obj.magic _100 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 729 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v : 'tv_contract = let args =
          let _30 = _300 in
          let xs00 = xs000 in
          let _10 = _100 in
          let xs =
            let _3 = _30 in
            let xs0 = xs00 in
            let _1 = _10 in
            let x =
              let xs = xs0 in
              
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 747 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 753 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 759 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 82 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.Contract
      ({ Syntax.contract_cases = css
       ; contract_name = name
       ; contract_arguments = args}) )
# 768 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _300;
            MenhirLib.EngineTypes.startp = _startpos__300_;
            MenhirLib.EngineTypes.endp = _endpos__300_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs000;
              MenhirLib.EngineTypes.startp = _startpos_xs000_;
              MenhirLib.EngineTypes.endp = _endpos_xs000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _100;
                MenhirLib.EngineTypes.startp = _startpos__100_;
                MenhirLib.EngineTypes.endp = _endpos__100_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = name;
                  MenhirLib.EngineTypes.startp = _startpos_name_;
                  MenhirLib.EngineTypes.endp = _endpos_name_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let _300 : unit = Obj.magic _300 in
        let xs000 : 'tv_loption_separated_nonempty_list_COMMA_event_arg__ = Obj.magic xs000 in
        let _100 : unit = Obj.magic _100 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 818 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_contract = let args =
          let _30 = _300 in
          let xs00 = xs000 in
          let _10 = _100 in
          let xs =
            let _3 = _30 in
            let xs0 = xs00 in
            let _1 = _10 in
            let x =
              let xs = xs0 in
              
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 836 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 842 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 848 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 90 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.Event { Syntax.event_arguments = args
      ; event_name = name
      })
# 856 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = a;
          MenhirLib.EngineTypes.startp = _startpos_a_;
          MenhirLib.EngineTypes.endp = _endpos_a_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let a : 'tv_arg = Obj.magic a in
        let _startpos = _startpos_a_ in
        let _endpos = _endpos_a_ in
        let _v : 'tv_event_arg = 
# 147 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.event_arg_of_arg a false )
# 880 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = i;
          MenhirLib.EngineTypes.startp = _startpos_i_;
          MenhirLib.EngineTypes.endp = _endpos_i_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = t;
              MenhirLib.EngineTypes.startp = _startpos_t_;
              MenhirLib.EngineTypes.endp = _endpos_t_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let i : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 911 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic i in
        let _2 : unit = Obj.magic _2 in
        let t : 'tv_typ = Obj.magic t in
        let _startpos = _startpos_t_ in
        let _endpos = _endpos_i_ in
        let _v : 'tv_event_arg = 
# 151 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( { Syntax.event_arg_body =
        { Syntax.arg_typ = t
        ; Syntax.arg_ident = i
        ; Syntax.arg_location = None
        }
      ; Syntax.event_arg_indexed = true
      }
    )
# 927 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _2 : unit = Obj.magic _2 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = 
# 214 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                               ( Syntax.LandExp (lhs, rhs), () )
# 963 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_exp = 
# 215 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.TrueExp, () )
# 987 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_exp = 
# 216 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          ( Syntax.FalseExp, () )
# 1011 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = d;
          MenhirLib.EngineTypes.startp = _startpos_d_;
          MenhirLib.EngineTypes.endp = _endpos_d_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let d : (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (Big_int.big_int)
# 1032 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic d in
        let _startpos = _startpos_d_ in
        let _endpos = _endpos_d_ in
        let _v : 'tv_exp = 
# 217 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                  ( Syntax.DecLit256Exp d, ())
# 1039 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = d;
          MenhirLib.EngineTypes.startp = _startpos_d_;
          MenhirLib.EngineTypes.endp = _endpos_d_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let d : (
# 4 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (Big_int.big_int)
# 1060 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic d in
        let _startpos = _startpos_d_ in
        let _endpos = _endpos_d_ in
        let _v : 'tv_exp = 
# 218 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                ( Syntax.DecLit8Exp d, ())
# 1067 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_exp = 
# 219 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                        ( Syntax.ValueExp, () )
# 1109 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_exp = 
# 220 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                         ( Syntax.SenderExp, () )
# 1151 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let e : 'tv_exp = Obj.magic e in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_exp = 
# 221 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( Syntax.BalanceExp e, () )
# 1193 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3;
            MenhirLib.EngineTypes.startp = _startpos__3_;
            MenhirLib.EngineTypes.endp = _endpos__3_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_exp = 
# 222 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                        ( Syntax.NowExp, () )
# 1235 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 204 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         (fun (l, r) -> Syntax.PlusExp(l, r))
# 1273 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1279 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 205 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          (fun (l, r)  -> Syntax.MinusExp(l, r))
# 1317 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1323 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 206 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         (fun (l, r) -> Syntax.MultExp(l, r))
# 1361 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1367 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 207 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (fun (l, r) -> Syntax.LtExp(l, r))
# 1405 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1411 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 208 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (fun (l, r) -> Syntax.GtExp(l, r))
# 1449 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1455 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 209 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
        (fun (l, r) -> Syntax.NeqExp(l, r))
# 1493 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1499 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = rhs;
          MenhirLib.EngineTypes.startp = _startpos_rhs_;
          MenhirLib.EngineTypes.endp = _endpos_rhs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _10;
            MenhirLib.EngineTypes.startp = _startpos__10_;
            MenhirLib.EngineTypes.endp = _endpos__10_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = lhs;
              MenhirLib.EngineTypes.startp = _startpos_lhs_;
              MenhirLib.EngineTypes.endp = _endpos_lhs_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _10 : unit = Obj.magic _10 in
        let lhs : 'tv_exp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos_rhs_ in
        let _v : 'tv_exp = let o =
          let _1 = _10 in
          
# 210 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
             (fun (l, r) -> Syntax.EqualityExp(l, r))
# 1537 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 1543 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1564 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic s in
        let _startpos = _startpos_s_ in
        let _endpos = _endpos_s_ in
        let _v : 'tv_exp = 
# 225 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.IdentifierExp s, () )
# 1571 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let e : 'tv_exp = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : 'tv_exp = 
# 229 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ParenthExp e, () )
# 1607 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _3000;
          MenhirLib.EngineTypes.startp = _startpos__3000_;
          MenhirLib.EngineTypes.endp = _endpos__3000_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = xs0000;
            MenhirLib.EngineTypes.startp = _startpos_xs0000_;
            MenhirLib.EngineTypes.endp = _endpos_xs0000_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _1000;
              MenhirLib.EngineTypes.startp = _startpos__1000_;
              MenhirLib.EngineTypes.endp = _endpos__1000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = s;
                MenhirLib.EngineTypes.startp = _startpos_s_;
                MenhirLib.EngineTypes.endp = _endpos_s_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _3000 : unit = Obj.magic _3000 in
        let xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__ = Obj.magic xs0000 in
        let _1000 : unit = Obj.magic _1000 in
        let s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1646 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic s in
        let _startpos = _startpos_s_ in
        let _endpos = _endpos__3000_ in
        let _v : 'tv_exp = let lst =
          let _300 = _3000 in
          let xs000 = xs0000 in
          let _100 = _1000 in
          let lst =
            let _30 = _300 in
            let xs00 = xs000 in
            let _10 = _100 in
            let xs =
              let _3 = _30 in
              let xs0 = xs00 in
              let _1 = _10 in
              let x =
                let xs = xs0 in
                
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 1667 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 1673 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 1679 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 1685 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 230 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                              ( Syntax.FunctionCallExp {Syntax.call_head = s; call_args = lst }, () )
# 1691 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = m;
          MenhirLib.EngineTypes.startp = _startpos_m_;
          MenhirLib.EngineTypes.endp = _endpos_m_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3000;
            MenhirLib.EngineTypes.startp = _startpos__3000_;
            MenhirLib.EngineTypes.endp = _endpos__3000_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs0000;
              MenhirLib.EngineTypes.startp = _startpos_xs0000_;
              MenhirLib.EngineTypes.endp = _endpos_xs0000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _1000;
                MenhirLib.EngineTypes.startp = _startpos__1000_;
                MenhirLib.EngineTypes.endp = _endpos__1000_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = s;
                  MenhirLib.EngineTypes.startp = _startpos_s_;
                  MenhirLib.EngineTypes.endp = _endpos_s_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let m : 'tv_msg_info = Obj.magic m in
        let _3000 : unit = Obj.magic _3000 in
        let xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__ = Obj.magic xs0000 in
        let _1000 : unit = Obj.magic _1000 in
        let s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1741 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic s in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_m_ in
        let _v : 'tv_exp = let lst =
          let _300 = _3000 in
          let xs000 = xs0000 in
          let _100 = _1000 in
          let lst =
            let _30 = _300 in
            let xs00 = xs000 in
            let _10 = _100 in
            let xs =
              let _3 = _30 in
              let xs0 = xs00 in
              let _1 = _10 in
              let x =
                let xs = xs0 in
                
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 1763 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 1769 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 1775 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 1781 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 231 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                    ( Syntax.NewExp { Syntax.new_head = s; new_args = lst; new_msg_info = m }, () )
# 1787 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = m;
          MenhirLib.EngineTypes.startp = _startpos_m_;
          MenhirLib.EngineTypes.endp = _endpos_m_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _5;
            MenhirLib.EngineTypes.startp = _startpos__5_;
            MenhirLib.EngineTypes.endp = _endpos__5_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _4;
              MenhirLib.EngineTypes.startp = _startpos__4_;
              MenhirLib.EngineTypes.endp = _endpos__4_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = _2;
                  MenhirLib.EngineTypes.startp = _startpos__2_;
                  MenhirLib.EngineTypes.endp = _endpos__2_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = contr;
                    MenhirLib.EngineTypes.startp = _startpos_contr_;
                    MenhirLib.EngineTypes.endp = _endpos_contr_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let m : 'tv_msg_info = Obj.magic m in
        let _5 : unit = Obj.magic _5 in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let _2 : unit = Obj.magic _2 in
        let contr : 'tv_exp = Obj.magic contr in
        let _startpos = _startpos_contr_ in
        let _endpos = _endpos_m_ in
        let _v : 'tv_exp = 
# 234 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = None
                       ; send_args = []; send_msg_info = m }, () )
# 1842 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = m;
          MenhirLib.EngineTypes.startp = _startpos_m_;
          MenhirLib.EngineTypes.endp = _endpos_m_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3000;
            MenhirLib.EngineTypes.startp = _startpos__3000_;
            MenhirLib.EngineTypes.endp = _endpos__3000_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs0000;
              MenhirLib.EngineTypes.startp = _startpos_xs0000_;
              MenhirLib.EngineTypes.endp = _endpos_xs0000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _1000;
                MenhirLib.EngineTypes.startp = _startpos__1000_;
                MenhirLib.EngineTypes.endp = _endpos__1000_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = mtd;
                  MenhirLib.EngineTypes.startp = _startpos_mtd_;
                  MenhirLib.EngineTypes.endp = _endpos_mtd_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _2;
                    MenhirLib.EngineTypes.startp = _startpos__2_;
                    MenhirLib.EngineTypes.endp = _endpos__2_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = contr;
                      MenhirLib.EngineTypes.startp = _startpos_contr_;
                      MenhirLib.EngineTypes.endp = _endpos_contr_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let m : 'tv_msg_info = Obj.magic m in
        let _3000 : unit = Obj.magic _3000 in
        let xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__ = Obj.magic xs0000 in
        let _1000 : unit = Obj.magic _1000 in
        let mtd : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1897 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic mtd in
        let _2 : unit = Obj.magic _2 in
        let contr : 'tv_exp = Obj.magic contr in
        let _startpos = _startpos_contr_ in
        let _endpos = _endpos_m_ in
        let _v : 'tv_exp = let lst =
          let _300 = _3000 in
          let xs000 = xs0000 in
          let _100 = _1000 in
          let lst =
            let _30 = _300 in
            let xs00 = xs000 in
            let _10 = _100 in
            let xs =
              let _3 = _30 in
              let xs0 = xs00 in
              let _1 = _10 in
              let x =
                let xs = xs0 in
                
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 1920 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 1926 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 1932 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 1938 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 237 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = Some mtd
                       ; send_args = (lst); send_msg_info = m }, () )
# 1945 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let e : 'tv_exp = Obj.magic e in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_exp = 
# 239 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( Syntax.AddressExp e, () )
# 1987 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = e;
          MenhirLib.EngineTypes.startp = _startpos_e_;
          MenhirLib.EngineTypes.endp = _endpos_e_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let e : 'tv_exp = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_e_ in
        let _v : 'tv_exp = 
# 240 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ( Syntax.NotExp e, () )
# 2017 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_exp = 
# 241 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.ThisExp, () )
# 2041 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = l;
          MenhirLib.EngineTypes.startp = _startpos_l_;
          MenhirLib.EngineTypes.endp = _endpos_l_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let l : 'tv_lexp = Obj.magic l in
        let _startpos = _startpos_l_ in
        let _endpos = _endpos_l_ in
        let _v : 'tv_exp = 
# 243 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ArrayAccessExp l, () )
# 2065 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = cs;
            MenhirLib.EngineTypes.startp = _startpos_cs_;
            MenhirLib.EngineTypes.endp = _endpos_cs_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let cs : 'tv_list_contract_ = Obj.magic cs in
        let _startpos = _startpos_cs_ in
        let _endpos = _endpos__2_ in
        let _v : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 2095 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = 
# 72 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                              ( cs )
# 2099 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = idx;
            MenhirLib.EngineTypes.startp = _startpos_idx_;
            MenhirLib.EngineTypes.endp = _endpos_idx_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = s;
                MenhirLib.EngineTypes.startp = _startpos_s_;
                MenhirLib.EngineTypes.endp = _endpos_s_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let idx : 'tv_exp = Obj.magic idx in
        let _2 : unit = Obj.magic _2 in
        let s : 'tv_exp = Obj.magic s in
        let _startpos = _startpos_s_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_lexp = 
# 269 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ArrayAccessLExp {
       Syntax.array_access_array = s; array_access_index = idx} )
# 2142 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_list_case_ = 
# 186 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2162 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = x;
            MenhirLib.EngineTypes.startp = _startpos_x_;
            MenhirLib.EngineTypes.endp = _endpos_x_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let xs : 'tv_list_case_ = Obj.magic xs in
        let x : 'tv_case = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_list_case_ = 
# 188 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 2192 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_list_contract_ = 
# 186 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2212 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = x;
            MenhirLib.EngineTypes.startp = _startpos_x_;
            MenhirLib.EngineTypes.endp = _endpos_x_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let xs : 'tv_list_contract_ = Obj.magic xs in
        let x : 'tv_contract = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_list_contract_ = 
# 188 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 2242 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_list_sentence_ = 
# 186 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2262 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = x;
            MenhirLib.EngineTypes.startp = _startpos_x_;
            MenhirLib.EngineTypes.endp = _endpos_x_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let xs : 'tv_list_sentence_ = Obj.magic xs in
        let x : 'tv_sentence = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_list_sentence_ = 
# 188 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 2292 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_arg__ = 
# 129 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2312 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_separated_nonempty_list_COMMA_arg_ = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_arg__ = 
# 131 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 2336 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_event_arg__ = 
# 129 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2356 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_separated_nonempty_list_COMMA_event_arg_ = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_event_arg__ = 
# 131 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 2380 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_exp__ = 
# 129 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2400 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_separated_nonempty_list_COMMA_exp_ = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_loption_separated_nonempty_list_COMMA_exp__ = 
# 131 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 2424 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = r;
          MenhirLib.EngineTypes.startp = _startpos_r_;
          MenhirLib.EngineTypes.endp = _endpos_r_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = v;
            MenhirLib.EngineTypes.startp = _startpos_v_;
            MenhirLib.EngineTypes.endp = _endpos_v_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let r : 'tv_reentrance_info = Obj.magic r in
        let v : 'tv_value_info = Obj.magic v in
        let _startpos = _startpos_v_ in
        let _endpos = _endpos_r_ in
        let _v : 'tv_msg_info = 
# 251 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                        ( { Syntax.message_value_info = v;
                                            message_reentrance_info = r } )
# 2455 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_option_exp_ = 
# 101 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( None )
# 2475 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_exp = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_option_exp_ = 
# 103 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( Some x )
# 2499 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = b;
          MenhirLib.EngineTypes.startp = _startpos_b_;
          MenhirLib.EngineTypes.endp = _endpos_b_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let b : 'tv_block = Obj.magic b in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_b_ in
        let _v : 'tv_reentrance_info = 
# 261 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                          ( b )
# 2529 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _2;
          MenhirLib.EngineTypes.startp = _startpos__2_;
          MenhirLib.EngineTypes.endp = _endpos__2_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__2_ in
        let _v : 'tv_sentence = 
# 180 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                     ( Syntax.AbortSentence )
# 2559 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _6;
          MenhirLib.EngineTypes.startp = _startpos__6_;
          MenhirLib.EngineTypes.endp = _endpos__6_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = cont;
            MenhirLib.EngineTypes.startp = _startpos_cont_;
            MenhirLib.EngineTypes.endp = _endpos_cont_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _4;
              MenhirLib.EngineTypes.startp = _startpos__4_;
              MenhirLib.EngineTypes.endp = _endpos__4_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _3;
                MenhirLib.EngineTypes.startp = _startpos__3_;
                MenhirLib.EngineTypes.endp = _endpos__3_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = value;
                  MenhirLib.EngineTypes.startp = _startpos_value_;
                  MenhirLib.EngineTypes.endp = _endpos_value_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _6 : unit = Obj.magic _6 in
        let cont : 'tv_exp = Obj.magic cont in
        let _4 : unit = Obj.magic _4 in
        let _3 : unit = Obj.magic _3 in
        let value : 'tv_option_exp_ = Obj.magic value in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__6_ in
        let _v : 'tv_sentence = 
# 182 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ReturnSentence { Syntax. return_exp = value; return_cont = cont} )
# 2613 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = rhs;
            MenhirLib.EngineTypes.startp = _startpos_rhs_;
            MenhirLib.EngineTypes.endp = _endpos_rhs_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = lhs;
                MenhirLib.EngineTypes.startp = _startpos_lhs_;
                MenhirLib.EngineTypes.endp = _endpos_lhs_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let rhs : 'tv_exp = Obj.magic rhs in
        let _2 : unit = Obj.magic _2 in
        let lhs : 'tv_lexp = Obj.magic lhs in
        let _startpos = _startpos_lhs_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_sentence = 
# 184 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.AssignmentSentence (lhs, rhs) )
# 2655 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _5;
          MenhirLib.EngineTypes.startp = _startpos__5_;
          MenhirLib.EngineTypes.endp = _endpos__5_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = value;
            MenhirLib.EngineTypes.startp = _startpos_value_;
            MenhirLib.EngineTypes.endp = _endpos_value_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _3;
              MenhirLib.EngineTypes.startp = _startpos__3_;
              MenhirLib.EngineTypes.endp = _endpos__3_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = name;
                MenhirLib.EngineTypes.startp = _startpos_name_;
                MenhirLib.EngineTypes.endp = _endpos_name_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = t;
                  MenhirLib.EngineTypes.startp = _startpos_t_;
                  MenhirLib.EngineTypes.endp = _endpos_t_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let _5 : unit = Obj.magic _5 in
        let value : 'tv_exp = Obj.magic value in
        let _3 : unit = Obj.magic _3 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2699 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let t : 'tv_typ = Obj.magic t in
        let _startpos = _startpos_t_ in
        let _endpos = _endpos__5_ in
        let _v : 'tv_sentence = 
# 189 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              ( Syntax.VariableInitSentence
                { Syntax.variable_init_type = t
                ; variable_init_name = name
                ; variable_init_value = value
                }
              )
# 2712 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = value;
            MenhirLib.EngineTypes.startp = _startpos_value_;
            MenhirLib.EngineTypes.endp = _endpos_value_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = _2;
              MenhirLib.EngineTypes.startp = _startpos__2_;
              MenhirLib.EngineTypes.endp = _endpos__2_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.state = _menhir_s;
                MenhirLib.EngineTypes.semv = _1;
                MenhirLib.EngineTypes.startp = _startpos__1_;
                MenhirLib.EngineTypes.endp = _endpos__1_;
                MenhirLib.EngineTypes.next = _menhir_stack;
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let value : 'tv_exp = Obj.magic value in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_sentence = 
# 196 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ExpSentence value )
# 2754 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = s1;
          MenhirLib.EngineTypes.startp = _startpos_s1_;
          MenhirLib.EngineTypes.endp = _endpos_s1_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = s0;
              MenhirLib.EngineTypes.startp = _startpos_s0_;
              MenhirLib.EngineTypes.endp = _endpos_s0_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = cond;
                  MenhirLib.EngineTypes.startp = _startpos_cond_;
                  MenhirLib.EngineTypes.endp = _endpos_cond_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _2;
                    MenhirLib.EngineTypes.startp = _startpos__2_;
                    MenhirLib.EngineTypes.endp = _endpos__2_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s1 : 'tv_sentence = Obj.magic s1 in
        let _6 : unit = Obj.magic _6 in
        let s0 : 'tv_sentence = Obj.magic s0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s1_ in
        let _v : 'tv_sentence = let bodyF =
          let s = s1 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 2816 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 2824 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 2830 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = b0;
          MenhirLib.EngineTypes.startp = _startpos_b0_;
          MenhirLib.EngineTypes.endp = _endpos_b0_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = s0;
              MenhirLib.EngineTypes.startp = _startpos_s0_;
              MenhirLib.EngineTypes.endp = _endpos_s0_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = cond;
                  MenhirLib.EngineTypes.startp = _startpos_cond_;
                  MenhirLib.EngineTypes.endp = _endpos_cond_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _2;
                    MenhirLib.EngineTypes.startp = _startpos__2_;
                    MenhirLib.EngineTypes.endp = _endpos__2_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let b0 : 'tv_block = Obj.magic b0 in
        let _6 : unit = Obj.magic _6 in
        let s0 : 'tv_sentence = Obj.magic s0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_b0_ in
        let _v : 'tv_sentence = let bodyF =
          let b = b0 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 2892 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 2900 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 2906 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = s0;
          MenhirLib.EngineTypes.startp = _startpos_s0_;
          MenhirLib.EngineTypes.endp = _endpos_s0_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = b0;
              MenhirLib.EngineTypes.startp = _startpos_b0_;
              MenhirLib.EngineTypes.endp = _endpos_b0_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = cond;
                  MenhirLib.EngineTypes.startp = _startpos_cond_;
                  MenhirLib.EngineTypes.endp = _endpos_cond_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _2;
                    MenhirLib.EngineTypes.startp = _startpos__2_;
                    MenhirLib.EngineTypes.endp = _endpos__2_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let s0 : 'tv_sentence = Obj.magic s0 in
        let _6 : unit = Obj.magic _6 in
        let b0 : 'tv_block = Obj.magic b0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s0_ in
        let _v : 'tv_sentence = let bodyF =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 2968 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let b = b0 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 2976 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 2982 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = b1;
          MenhirLib.EngineTypes.startp = _startpos_b1_;
          MenhirLib.EngineTypes.endp = _endpos_b1_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _6;
            MenhirLib.EngineTypes.startp = _startpos__6_;
            MenhirLib.EngineTypes.endp = _endpos__6_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = b0;
              MenhirLib.EngineTypes.startp = _startpos_b0_;
              MenhirLib.EngineTypes.endp = _endpos_b0_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _4;
                MenhirLib.EngineTypes.startp = _startpos__4_;
                MenhirLib.EngineTypes.endp = _endpos__4_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = cond;
                  MenhirLib.EngineTypes.startp = _startpos_cond_;
                  MenhirLib.EngineTypes.endp = _endpos_cond_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.semv = _2;
                    MenhirLib.EngineTypes.startp = _startpos__2_;
                    MenhirLib.EngineTypes.endp = _endpos__2_;
                    MenhirLib.EngineTypes.next = {
                      MenhirLib.EngineTypes.state = _menhir_s;
                      MenhirLib.EngineTypes.semv = _1;
                      MenhirLib.EngineTypes.startp = _startpos__1_;
                      MenhirLib.EngineTypes.endp = _endpos__1_;
                      MenhirLib.EngineTypes.next = _menhir_stack;
                    };
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let b1 : 'tv_block = Obj.magic b1 in
        let _6 : unit = Obj.magic _6 in
        let b0 : 'tv_block = Obj.magic b0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_b1_ in
        let _v : 'tv_sentence = let bodyF =
          let b = b1 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 3044 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let b = b0 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 3052 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 3058 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = s0;
          MenhirLib.EngineTypes.startp = _startpos_s0_;
          MenhirLib.EngineTypes.endp = _endpos_s0_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _4;
            MenhirLib.EngineTypes.startp = _startpos__4_;
            MenhirLib.EngineTypes.endp = _endpos__4_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = cond;
              MenhirLib.EngineTypes.startp = _startpos_cond_;
              MenhirLib.EngineTypes.endp = _endpos_cond_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _2;
                MenhirLib.EngineTypes.startp = _startpos__2_;
                MenhirLib.EngineTypes.endp = _endpos__2_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = _1;
                  MenhirLib.EngineTypes.startp = _startpos__1_;
                  MenhirLib.EngineTypes.endp = _endpos__1_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let s0 : 'tv_sentence = Obj.magic s0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_s0_ in
        let _v : 'tv_sentence = let body =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 3108 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 198 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                            ( Syntax.IfThenOnly (cond, body) )
# 3114 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = b0;
          MenhirLib.EngineTypes.startp = _startpos_b0_;
          MenhirLib.EngineTypes.endp = _endpos_b0_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _4;
            MenhirLib.EngineTypes.startp = _startpos__4_;
            MenhirLib.EngineTypes.endp = _endpos__4_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = cond;
              MenhirLib.EngineTypes.startp = _startpos_cond_;
              MenhirLib.EngineTypes.endp = _endpos_cond_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _2;
                MenhirLib.EngineTypes.startp = _startpos__2_;
                MenhirLib.EngineTypes.endp = _endpos__2_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.state = _menhir_s;
                  MenhirLib.EngineTypes.semv = _1;
                  MenhirLib.EngineTypes.startp = _startpos__1_;
                  MenhirLib.EngineTypes.endp = _endpos__1_;
                  MenhirLib.EngineTypes.next = _menhir_stack;
                };
              };
            };
          };
        } = _menhir_stack in
        let b0 : 'tv_block = Obj.magic b0 in
        let _4 : unit = Obj.magic _4 in
        let cond : 'tv_exp = Obj.magic cond in
        let _2 : unit = Obj.magic _2 in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_b0_ in
        let _v : 'tv_sentence = let body =
          let b = b0 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 3164 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 198 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                            ( Syntax.IfThenOnly (cond, body) )
# 3170 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _4;
          MenhirLib.EngineTypes.startp = _startpos__4_;
          MenhirLib.EngineTypes.endp = _endpos__4_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _3000;
            MenhirLib.EngineTypes.startp = _startpos__3000_;
            MenhirLib.EngineTypes.endp = _endpos__3000_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.semv = xs0000;
              MenhirLib.EngineTypes.startp = _startpos_xs0000_;
              MenhirLib.EngineTypes.endp = _endpos_xs0000_;
              MenhirLib.EngineTypes.next = {
                MenhirLib.EngineTypes.semv = _1000;
                MenhirLib.EngineTypes.startp = _startpos__1000_;
                MenhirLib.EngineTypes.endp = _endpos__1000_;
                MenhirLib.EngineTypes.next = {
                  MenhirLib.EngineTypes.semv = name;
                  MenhirLib.EngineTypes.startp = _startpos_name_;
                  MenhirLib.EngineTypes.endp = _endpos_name_;
                  MenhirLib.EngineTypes.next = {
                    MenhirLib.EngineTypes.state = _menhir_s;
                    MenhirLib.EngineTypes.semv = _1;
                    MenhirLib.EngineTypes.startp = _startpos__1_;
                    MenhirLib.EngineTypes.endp = _endpos__1_;
                    MenhirLib.EngineTypes.next = _menhir_stack;
                  };
                };
              };
            };
          };
        } = _menhir_stack in
        let _4 : unit = Obj.magic _4 in
        let _3000 : unit = Obj.magic _3000 in
        let xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__ = Obj.magic xs0000 in
        let _1000 : unit = Obj.magic _1000 in
        let name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3220 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic name in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__4_ in
        let _v : 'tv_sentence = let lst =
          let _300 = _3000 in
          let xs000 = xs0000 in
          let _100 = _1000 in
          let lst =
            let _30 = _300 in
            let xs00 = xs000 in
            let _10 = _100 in
            let xs =
              let _3 = _30 in
              let xs0 = xs00 in
              let _1 = _10 in
              let x =
                let xs = xs0 in
                
# 207 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 3242 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 175 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 3248 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 3254 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            
          in
          
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 3260 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 199 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                 ( Syntax.LogSentence (name, lst, None))
# 3266 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = _3;
          MenhirLib.EngineTypes.startp = _startpos__3_;
          MenhirLib.EngineTypes.endp = _endpos__3_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = e;
            MenhirLib.EngineTypes.startp = _startpos_e_;
            MenhirLib.EngineTypes.endp = _endpos_e_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = _1;
              MenhirLib.EngineTypes.startp = _startpos__1_;
              MenhirLib.EngineTypes.endp = _endpos__1_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let _3 : unit = Obj.magic _3 in
        let e : 'tv_exp = Obj.magic e in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__3_ in
        let _v : 'tv_sentence = 
# 200 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                     ( Syntax.SelfdestructSentence e )
# 3302 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_arg = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_separated_nonempty_list_COMMA_arg_ = 
# 216 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 3326 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = x;
              MenhirLib.EngineTypes.startp = _startpos_x_;
              MenhirLib.EngineTypes.endp = _endpos_x_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let xs : 'tv_separated_nonempty_list_COMMA_arg_ = Obj.magic xs in
        let _2 : unit = Obj.magic _2 in
        let x : 'tv_arg = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_separated_nonempty_list_COMMA_arg_ = 
# 218 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 3362 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_event_arg = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_separated_nonempty_list_COMMA_event_arg_ = 
# 216 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 3386 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = x;
              MenhirLib.EngineTypes.startp = _startpos_x_;
              MenhirLib.EngineTypes.endp = _endpos_x_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let xs : 'tv_separated_nonempty_list_COMMA_event_arg_ = Obj.magic xs in
        let _2 : unit = Obj.magic _2 in
        let x : 'tv_event_arg = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_separated_nonempty_list_COMMA_event_arg_ = 
# 218 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 3422 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = x;
          MenhirLib.EngineTypes.startp = _startpos_x_;
          MenhirLib.EngineTypes.endp = _endpos_x_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let x : 'tv_exp = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_x_ in
        let _v : 'tv_separated_nonempty_list_COMMA_exp_ = 
# 216 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 3446 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = xs;
          MenhirLib.EngineTypes.startp = _startpos_xs_;
          MenhirLib.EngineTypes.endp = _endpos_xs_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = x;
              MenhirLib.EngineTypes.startp = _startpos_x_;
              MenhirLib.EngineTypes.endp = _endpos_x_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let xs : 'tv_separated_nonempty_list_COMMA_exp_ = Obj.magic xs in
        let _2 : unit = Obj.magic _2 in
        let x : 'tv_exp = Obj.magic x in
        let _startpos = _startpos_x_ in
        let _endpos = _endpos_xs_ in
        let _v : 'tv_separated_nonempty_list_COMMA_exp_ = 
# 218 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 3482 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_typ = 
# 162 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.Uint256Type )
# 3506 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_typ = 
# 163 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          ( Syntax.Uint8Type )
# 3530 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_typ = 
# 164 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.Bytes32Type )
# 3554 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_typ = 
# 165 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.AddressType )
# 3578 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = _1;
          MenhirLib.EngineTypes.startp = _startpos__1_;
          MenhirLib.EngineTypes.endp = _endpos__1_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos__1_ in
        let _v : 'tv_typ = 
# 166 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.BoolType )
# 3602 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = value;
          MenhirLib.EngineTypes.startp = _startpos_value_;
          MenhirLib.EngineTypes.endp = _endpos_value_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.semv = _2;
            MenhirLib.EngineTypes.startp = _startpos__2_;
            MenhirLib.EngineTypes.endp = _endpos__2_;
            MenhirLib.EngineTypes.next = {
              MenhirLib.EngineTypes.state = _menhir_s;
              MenhirLib.EngineTypes.semv = key;
              MenhirLib.EngineTypes.startp = _startpos_key_;
              MenhirLib.EngineTypes.endp = _endpos_key_;
              MenhirLib.EngineTypes.next = _menhir_stack;
            };
          };
        } = _menhir_stack in
        let value : 'tv_typ = Obj.magic value in
        let _2 : unit = Obj.magic _2 in
        let key : 'tv_typ = Obj.magic key in
        let _startpos = _startpos_key_ in
        let _endpos = _endpos_value_ in
        let _v : 'tv_typ = 
# 170 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.MappingType (key, value) )
# 3638 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = s;
          MenhirLib.EngineTypes.startp = _startpos_s_;
          MenhirLib.EngineTypes.endp = _endpos_s_;
          MenhirLib.EngineTypes.next = _menhir_stack;
        } = _menhir_stack in
        let s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3659 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ) = Obj.magic s in
        let _startpos = _startpos_s_ in
        let _endpos = _endpos_s_ in
        let _v : 'tv_typ = 
# 171 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              ( Syntax.ContractInstanceType s )
# 3666 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let _menhir_s = _menhir_env.MenhirLib.EngineTypes.current in
        let _startpos =
          let (_, startpos, _) = _menhir_env.MenhirLib.EngineTypes.triple in
          startpos
        in
        let _endpos = _startpos in
        let _v : 'tv_value_info = 
# 256 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                ( None )
# 3686 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
      (fun _menhir_env ->
        let _menhir_stack = _menhir_env.MenhirLib.EngineTypes.stack in
        let {
          MenhirLib.EngineTypes.semv = v;
          MenhirLib.EngineTypes.startp = _startpos_v_;
          MenhirLib.EngineTypes.endp = _endpos_v_;
          MenhirLib.EngineTypes.next = {
            MenhirLib.EngineTypes.state = _menhir_s;
            MenhirLib.EngineTypes.semv = _1;
            MenhirLib.EngineTypes.startp = _startpos__1_;
            MenhirLib.EngineTypes.endp = _endpos__1_;
            MenhirLib.EngineTypes.next = _menhir_stack;
          };
        } = _menhir_stack in
        let v : 'tv_exp = Obj.magic v in
        let _1 : unit = Obj.magic _1 in
        let _startpos = _startpos__1_ in
        let _endpos = _endpos_v_ in
        let _v : 'tv_value_info = 
# 257 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    ( Some v )
# 3716 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        {
          MenhirLib.EngineTypes.state = _menhir_s;
          MenhirLib.EngineTypes.semv = Obj.repr _v;
          MenhirLib.EngineTypes.startp = _startpos;
          MenhirLib.EngineTypes.endp = _endpos;
          MenhirLib.EngineTypes.next = _menhir_stack;
        });
    |]
  
  and trace =
    None
  
end

module MenhirInterpreter = struct
  
  module TI = MenhirLib.TableInterpreter.Make (Tables)
  
  include TI
  
end

let file =
  fun lexer lexbuf ->
    (Obj.magic (MenhirInterpreter.entry 0 lexer lexbuf) : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 3745 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    ))

module Incremental = struct
  
  let file =
    fun () ->
      (Obj.magic (MenhirInterpreter.start 0) : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 3755 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
      ) MenhirInterpreter.result)
  
end

# 220 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
  


# 3764 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
