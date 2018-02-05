
module MenhirBasics = struct
  
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
       (WrapBn.t)
# 57 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
  )
    | DECLIT256 of (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
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

include MenhirBasics

let _eRR =
  MenhirBasics.Error

type _menhir_env = {
  _menhir_lexer: Lexing.lexbuf -> token;
  _menhir_lexbuf: Lexing.lexbuf;
  _menhir_token: token;
  mutable _menhir_error: bool
}

and _menhir_state = 
  | MenhirState190
  | MenhirState185
  | MenhirState180
  | MenhirState177
  | MenhirState171
  | MenhirState168
  | MenhirState164
  | MenhirState157
  | MenhirState155
  | MenhirState150
  | MenhirState144
  | MenhirState141
  | MenhirState138
  | MenhirState129
  | MenhirState124
  | MenhirState120
  | MenhirState115
  | MenhirState112
  | MenhirState110
  | MenhirState108
  | MenhirState106
  | MenhirState104
  | MenhirState103
  | MenhirState100
  | MenhirState96
  | MenhirState94
  | MenhirState91
  | MenhirState89
  | MenhirState87
  | MenhirState83
  | MenhirState81
  | MenhirState77
  | MenhirState73
  | MenhirState71
  | MenhirState70
  | MenhirState55
  | MenhirState53
  | MenhirState52
  | MenhirState46
  | MenhirState42
  | MenhirState37
  | MenhirState34
  | MenhirState31
  | MenhirState26
  | MenhirState21
  | MenhirState11
  | MenhirState3
  | MenhirState0

let rec _menhir_goto_list_sentence_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_sentence_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState180 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv659 * _menhir_state * 'tv_sentence) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv657 * _menhir_state * 'tv_sentence) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_sentence)), _, (xs : 'tv_list_sentence_)) = _menhir_stack in
        let _v : 'tv_list_sentence_ = 
# 187 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 153 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_list_sentence_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv658)) : 'freshtv660)
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv717 * _menhir_state) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv713 * _menhir_state) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv711 * _menhir_state) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (scs : 'tv_list_sentence_)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_block = 
# 109 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( scs )
# 174 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv709) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_block) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState115 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv683) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv681) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _, (b : 'tv_block)) = _menhir_stack in
                let _1 = () in
                let _v : 'tv_reentrance_info = 
# 261 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                          ( b )
# 192 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv679) = _menhir_stack in
                let (_v : 'tv_reentrance_info) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv677 * _menhir_state * 'tv_value_info) = Obj.magic _menhir_stack in
                let (_v : 'tv_reentrance_info) = _v in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv675 * _menhir_state * 'tv_value_info) = Obj.magic _menhir_stack in
                let ((r : 'tv_reentrance_info) : 'tv_reentrance_info) = _v in
                ((let (_menhir_stack, _menhir_s, (v : 'tv_value_info)) = _menhir_stack in
                let _v : 'tv_msg_info = 
# 251 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                        ( { Syntax.message_value_info = v;
                                            message_reentrance_info = r } )
# 208 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv673) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_msg_info) = _v in
                ((match _menhir_s with
                | MenhirState103 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : ((((('freshtv663 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 220 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let (_v : 'tv_msg_info) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : ((((('freshtv661 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 228 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                    let (_ : _menhir_state) = _menhir_s in
                    let ((m : 'tv_msg_info) : 'tv_msg_info) = _v in
                    ((let (((_menhir_stack, _menhir_s, (contr : 'tv_exp)), (mtd : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 235 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))), _, (xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__)) = _menhir_stack in
                    let _3000 = () in
                    let _1000 = () in
                    let _2 = () in
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
                            
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 257 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                            
                          in
                          
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 263 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                          
                        in
                        
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 269 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                        
                      in
                      
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 275 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 237 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = Some mtd
                       ; send_args = (lst); send_msg_info = m }, () )
# 282 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                     in
                    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv662)) : 'freshtv664)
                | MenhirState124 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv667 * _menhir_state * 'tv_exp))))) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let (_v : 'tv_msg_info) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv665 * _menhir_state * 'tv_exp))))) = Obj.magic _menhir_stack in
                    let (_ : _menhir_state) = _menhir_s in
                    let ((m : 'tv_msg_info) : 'tv_msg_info) = _v in
                    ((let (_menhir_stack, _menhir_s, (contr : 'tv_exp)) = _menhir_stack in
                    let _5 = () in
                    let _4 = () in
                    let _3 = () in
                    let _2 = () in
                    let _v : 'tv_exp = 
# 234 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.SendExp { Syntax.send_head_contract = contr; send_head_method = None
                       ; send_args = []; send_msg_info = m }, () )
# 303 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                     in
                    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv666)) : 'freshtv668)
                | MenhirState129 ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv671 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 311 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                    let (_menhir_s : _menhir_state) = _menhir_s in
                    let (_v : 'tv_msg_info) = _v in
                    ((let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv669 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 319 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                    let (_ : _menhir_state) = _menhir_s in
                    let ((m : 'tv_msg_info) : 'tv_msg_info) = _v in
                    ((let (((_menhir_stack, _menhir_s), (s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 326 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    ))), _, (xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__)) = _menhir_stack in
                    let _3000 = () in
                    let _1000 = () in
                    let _1 = () in
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
                            
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 348 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                            
                          in
                          
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 354 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                          
                        in
                        
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 360 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                        
                      in
                      
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 366 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 231 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                    ( Syntax.NewExp { Syntax.new_head = s; new_args = lst; new_msg_info = m }, () )
# 372 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                     in
                    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv670)) : 'freshtv672)
                | _ ->
                    _menhir_fail ()) : 'freshtv674)) : 'freshtv676)) : 'freshtv678)) : 'freshtv680)) : 'freshtv682)) : 'freshtv684)
            | MenhirState168 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv687 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv685 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (s0 : 'tv_sentence)), _, (b0 : 'tv_block)) = _menhir_stack in
                let _6 = () in
                let _4 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_sentence = let bodyF =
                  let b = b0 in
                  
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 392 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                let bodyT =
                  let s = s0 in
                  
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 400 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 406 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv686)) : 'freshtv688)
            | MenhirState157 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv695 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | ELSE ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv689 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | ABORT ->
                        _menhir_run160 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | ADDRESS ->
                        _menhir_run159 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | BALANCE ->
                        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | BOOL ->
                        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | BYTES32 ->
                        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | DECLIT256 _v ->
                        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState177 _v
                    | DECLIT8 _v ->
                        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState177 _v
                    | DEPLOY ->
                        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | FALSE ->
                        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | IDENT _v ->
                        _menhir_run158 _menhir_env (Obj.magic _menhir_stack) MenhirState177 _v
                    | IF ->
                        _menhir_run154 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | LBRACE ->
                        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | LOG ->
                        _menhir_run148 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | LPAR ->
                        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | NOT ->
                        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | NOW ->
                        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | RETURN ->
                        _menhir_run141 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | SELFDESTRUCT ->
                        _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | SENDER ->
                        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | THIS ->
                        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | TRUE ->
                        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | UINT256 ->
                        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | UINT8 ->
                        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | VALUE ->
                        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | VOID ->
                        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState177
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState177) : 'freshtv690)
                | ABORT | ADDRESS | BALANCE | BOOL | BYTES32 | DECLIT256 _ | DECLIT8 _ | DEPLOY | FALSE | IDENT _ | IF | LOG | LPAR | NOT | NOW | RBRACE | RETURN | SELFDESTRUCT | SENDER | THIS | TRUE | UINT256 | UINT8 | VALUE | VOID ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv691 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                    ((let (((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (b0 : 'tv_block)) = _menhir_stack in
                    let _4 = () in
                    let _2 = () in
                    let _1 = () in
                    let _v : 'tv_sentence = let body =
                      let b = b0 in
                      
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 487 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 198 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                            ( Syntax.IfThenOnly (cond, body) )
# 493 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                     in
                    _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv692)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : (((('freshtv693 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                    ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv694)) : 'freshtv696)
            | MenhirState177 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv699 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv697 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block)) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (b0 : 'tv_block)), _, (b1 : 'tv_block)) = _menhir_stack in
                let _6 = () in
                let _4 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_sentence = let bodyF =
                  let b = b1 in
                  
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 518 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                let bodyT =
                  let b = b0 in
                  
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 526 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 532 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv698)) : 'freshtv700)
            | MenhirState52 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv707 * _menhir_state * 'tv_case_header) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv705 * _menhir_state * 'tv_case_header) * _menhir_state * 'tv_block) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, (ch : 'tv_case_header)), _, (cb : 'tv_block)) = _menhir_stack in
                let _v : 'tv_case = 
# 98 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    (
      { Syntax.case_header = ch
      ; Syntax.case_body = cb
      }
     )
# 548 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv703) = _menhir_stack in
                let (_menhir_s : _menhir_state) = _menhir_s in
                let (_v : 'tv_case) = _v in
                ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv701 * _menhir_state * 'tv_case) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | CASE ->
                    _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState185
                | DEFAULT ->
                    _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState185
                | RBRACE ->
                    _menhir_reduce39 _menhir_env (Obj.magic _menhir_stack) MenhirState185
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState185) : 'freshtv702)) : 'freshtv704)) : 'freshtv706)) : 'freshtv708)
            | _ ->
                _menhir_fail ()) : 'freshtv710)) : 'freshtv712)) : 'freshtv714)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv715 * _menhir_state) * _menhir_state * 'tv_list_sentence_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv716)) : 'freshtv718)
    | _ ->
        _menhir_fail ()

and _menhir_reduce81 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_value_info = 
# 256 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                ( None )
# 587 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_value_info _menhir_env _menhir_stack _menhir_s _v

and _menhir_run104 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState104 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState104
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState104

and _menhir_reduce43 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_sentence_ = 
# 185 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 635 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_list_sentence_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_exp__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv629 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 648 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv625 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 658 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ALONG ->
                _menhir_run104 _menhir_env (Obj.magic _menhir_stack) MenhirState103
            | REENTRANCE ->
                _menhir_reduce81 _menhir_env (Obj.magic _menhir_stack) MenhirState103
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState103) : 'freshtv626)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv627 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 678 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv628)) : 'freshtv630)
    | MenhirState77 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv635 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 687 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv631 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 697 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ALONG ->
                _menhir_run104 _menhir_env (Obj.magic _menhir_stack) MenhirState129
            | REENTRANCE ->
                _menhir_reduce81 _menhir_env (Obj.magic _menhir_stack) MenhirState129
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState129) : 'freshtv632)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv633 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 717 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv634)) : 'freshtv636)
    | MenhirState73 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv643 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 726 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv639 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 736 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv637 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 743 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 748 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))), _, (xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__)) = _menhir_stack in
            let _3000 = () in
            let _1000 = () in
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
                    
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 769 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    
                  in
                  
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 775 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 781 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 787 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 230 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                              ( Syntax.FunctionCallExp {Syntax.call_head = s; call_args = lst }, () )
# 793 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv638)) : 'freshtv640)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv641 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 803 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv642)) : 'freshtv644)
    | MenhirState150 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv655 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 812 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv651 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 822 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SEMICOLON ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv647 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 832 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv645 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 839 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                ((let (((_menhir_stack, _menhir_s), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 844 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))), _, (xs0000 : 'tv_loption_separated_nonempty_list_COMMA_exp__)) = _menhir_stack in
                let _4 = () in
                let _3000 = () in
                let _1000 = () in
                let _1 = () in
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
                        
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 867 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                        
                      in
                      
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 873 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 879 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    
                  in
                  
# 248 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    (lst)
# 885 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 199 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                 ( Syntax.LogSentence (name, lst, None))
# 891 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv646)) : 'freshtv648)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv649 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 901 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv650)) : 'freshtv652)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv653 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 912 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv654)) : 'freshtv656)
    | _ ->
        _menhir_fail ()

and _menhir_run54 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | SINGLE_EQ ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv621 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ADDRESS ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | BALANCE ->
            _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | DECLIT256 _v ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
        | DECLIT8 _v ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
        | DEPLOY ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | FALSE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | IDENT _v ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState55 _v
        | LPAR ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | NOW ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | SENDER ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | THIS ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | TRUE ->
            _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | VALUE ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState55
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState55) : 'freshtv622)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv623 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv624)

and _menhir_run138 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState138 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState138
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState138

and _menhir_run141 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState141 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState141 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState141 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState141
    | THEN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv619) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = MenhirState141 in
        ((let _v : 'tv_option_exp_ = 
# 100 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( None )
# 1051 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_option_exp_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv620)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState141

and _menhir_run148 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv615 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1071 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv611 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1082 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState150 _v
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | RPAR ->
                _menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) MenhirState150
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState150) : 'freshtv612)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv613 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1128 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv614)) : 'freshtv616)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv617 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv618)

and _menhir_run154 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv607 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ADDRESS ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | BALANCE ->
            _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | DECLIT256 _v ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState155 _v
        | DECLIT8 _v ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState155 _v
        | DEPLOY ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | FALSE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | IDENT _v ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState155 _v
        | LPAR ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | NOW ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | SENDER ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | THIS ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | TRUE ->
            _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | VALUE ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState155
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState155) : 'freshtv608)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv609 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv610)

and _menhir_run158 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1195 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
    | IDENT _ | RARROW ->
        _menhir_reduce80 _menhir_env (Obj.magic _menhir_stack)
    | DOT | EQUALITY | GT | LAND | LSQBR | LT | MINUS | MULT | NEQ | PLUS ->
        _menhir_reduce27 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv605 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 1215 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv606)

and _menhir_run159 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack)
    | IDENT _ | RARROW ->
        _menhir_reduce77 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv603 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv604)

and _menhir_run160 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | SEMICOLON ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv599 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv597 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_sentence = 
# 180 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                     ( Syntax.AbortSentence )
# 1256 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv598)) : 'freshtv600)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv601 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv602)

and _menhir_goto_option_exp_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_option_exp_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ('freshtv595 * _menhir_state) * _menhir_state * 'tv_option_exp_) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | THEN ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv591 * _menhir_state) * _menhir_state * 'tv_option_exp_) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BECOME ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv587 * _menhir_state) * _menhir_state * 'tv_option_exp_)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState144 _v
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState144
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState144) : 'freshtv588)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv589 * _menhir_state) * _menhir_state * 'tv_option_exp_)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv590)) : 'freshtv592)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv593 * _menhir_state) * _menhir_state * 'tv_option_exp_) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv594)) : 'freshtv596)

and _menhir_goto_sentence : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_sentence -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv575 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ELSE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv569 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ABORT ->
                _menhir_run160 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | ADDRESS ->
                _menhir_run159 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | BOOL ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | BYTES32 ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | IDENT _v ->
                _menhir_run158 _menhir_env (Obj.magic _menhir_stack) MenhirState168 _v
            | IF ->
                _menhir_run154 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | LBRACE ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | LOG ->
                _menhir_run148 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | RETURN ->
                _menhir_run141 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | SELFDESTRUCT ->
                _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | UINT256 ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | UINT8 ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | VOID ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState168
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState168) : 'freshtv570)
        | ABORT | ADDRESS | BALANCE | BOOL | BYTES32 | DECLIT256 _ | DECLIT8 _ | DEPLOY | FALSE | IDENT _ | IF | LOG | LPAR | NOT | NOW | RBRACE | RETURN | SELFDESTRUCT | SENDER | THIS | TRUE | UINT256 | UINT8 | VALUE | VOID ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv571 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (s0 : 'tv_sentence)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_sentence = let body =
              let s = s0 in
              
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 1416 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 198 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                            ( Syntax.IfThenOnly (cond, body) )
# 1422 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv572)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv573 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv574)) : 'freshtv576)
    | MenhirState168 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv579 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv577 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (s0 : 'tv_sentence)), _, (s1 : 'tv_sentence)) = _menhir_stack in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_sentence = let bodyF =
          let s = s1 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 1447 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 1455 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 1461 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv578)) : 'freshtv580)
    | MenhirState177 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv583 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv581 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block)) * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((let ((((_menhir_stack, _menhir_s), _, (cond : 'tv_exp)), _, (b0 : 'tv_block)), _, (s0 : 'tv_sentence)) = _menhir_stack in
        let _6 = () in
        let _4 = () in
        let _2 = () in
        let _1 = () in
        let _v : 'tv_sentence = let bodyF =
          let s = s0 in
          
# 175 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ([s])
# 1479 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        let bodyT =
          let b = b0 in
          
# 176 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              (b)
# 1487 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
          
        in
        
# 197 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                                 ( Syntax.IfThenElse (cond, bodyT, bodyF) )
# 1493 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv582)) : 'freshtv584)
    | MenhirState180 | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv585 * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ABORT ->
            _menhir_run160 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | ADDRESS ->
            _menhir_run159 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | BALANCE ->
            _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | BOOL ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | BYTES32 ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | DECLIT256 _v ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
        | DECLIT8 _v ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
        | DEPLOY ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | FALSE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | IDENT _v ->
            _menhir_run158 _menhir_env (Obj.magic _menhir_stack) MenhirState180 _v
        | IF ->
            _menhir_run154 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | LOG ->
            _menhir_run148 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | LPAR ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | NOW ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | RETURN ->
            _menhir_run141 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | SELFDESTRUCT ->
            _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | SENDER ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | THIS ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | TRUE ->
            _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | UINT256 ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | UINT8 ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | VALUE ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | VOID ->
            _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | RBRACE ->
            _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack) MenhirState180
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState180) : 'freshtv586)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_exp_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_exp_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState150 | MenhirState73 | MenhirState77 | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv563) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_exp_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv561) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_exp_) : 'tv_separated_nonempty_list_COMMA_exp_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_exp__ = 
# 130 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 1574 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv562)) : 'freshtv564)
    | MenhirState120 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv567 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_exp_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv565 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_exp_) : 'tv_separated_nonempty_list_COMMA_exp_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_exp)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_exp_ = 
# 217 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 1591 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_exp_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv566)) : 'freshtv568)
    | _ ->
        _menhir_fail ()

and _menhir_goto_value_info : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_value_info -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv559 * _menhir_state * 'tv_value_info) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | REENTRANCE ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv555) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LBRACE ->
            _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState115
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState115) : 'freshtv556)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv557 * _menhir_state * 'tv_value_info) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv558)) : 'freshtv560)

and _menhir_reduce36 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_lexp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (l : 'tv_lexp)) = _menhir_stack in
    let _v : 'tv_exp = 
# 243 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ArrayAccessExp l, () )
# 1631 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v

and _menhir_run87 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState87 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState87
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState87

and _menhir_run94 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState94 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState94 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState94 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState94
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState94

and _menhir_run89 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState89 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState89
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState89

and _menhir_run96 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState96 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState96
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState96

and _menhir_run106 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState106 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState106
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState106

and _menhir_run91 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState91 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState91
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState91

and _menhir_run108 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState108 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState108
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState108

and _menhir_run110 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState110 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState110 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState110 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState110
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState110

and _menhir_run112 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState112 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState112
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState112

and _menhir_run98 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | DEFAULT ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv545 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv541 * _menhir_state * 'tv_exp))) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv537 * _menhir_state * 'tv_exp)))) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | ALONG ->
                    _menhir_run104 _menhir_env (Obj.magic _menhir_stack) MenhirState124
                | REENTRANCE ->
                    _menhir_reduce81 _menhir_env (Obj.magic _menhir_stack) MenhirState124
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState124) : 'freshtv538)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv539 * _menhir_state * 'tv_exp)))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv540)) : 'freshtv542)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv543 * _menhir_state * 'tv_exp))) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv544)) : 'freshtv546)
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv551 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2028 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv547 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2039 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState100 _v
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | RPAR ->
                _menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) MenhirState100
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState100) : 'freshtv548)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv549 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2085 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv550)) : 'freshtv552)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv553 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv554)

and _menhir_run53 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ABORT ->
        _menhir_run160 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | ADDRESS ->
        _menhir_run159 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | BOOL ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | BYTES32 ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | IDENT _v ->
        _menhir_run158 _menhir_env (Obj.magic _menhir_stack) MenhirState53 _v
    | IF ->
        _menhir_run154 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | LOG ->
        _menhir_run148 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | RETURN ->
        _menhir_run141 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | SELFDESTRUCT ->
        _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | UINT256 ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | UINT8 ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | VOID ->
        _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | RBRACE ->
        _menhir_reduce43 _menhir_env (Obj.magic _menhir_stack) MenhirState53
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState53

and _menhir_goto_list_case_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_case_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((((('freshtv531 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2167 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__))) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RBRACE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv527 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2177 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__))) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv525 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2184 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__))) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
            ((let ((((_menhir_stack, _menhir_s), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2189 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))), _, (xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__)), _, (css : 'tv_list_case_)) = _menhir_stack in
            let _6 = () in
            let _4 = () in
            let _300 = () in
            let _100 = () in
            let _1 = () in
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
                  
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 2209 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 2215 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 2221 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 82 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.Contract
      ({ Syntax.contract_cases = css
       ; contract_name = name
       ; contract_arguments = args}) )
# 2230 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_contract _menhir_env _menhir_stack _menhir_s _v) : 'freshtv526)) : 'freshtv528)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((((('freshtv529 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2240 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__))) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv530)) : 'freshtv532)
    | MenhirState185 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv535 * _menhir_state * 'tv_case) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv533 * _menhir_state * 'tv_case) * _menhir_state * 'tv_list_case_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_case)), _, (xs : 'tv_list_case_)) = _menhir_stack in
        let _v : 'tv_list_case_ = 
# 187 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 2253 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_list_case_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv534)) : 'freshtv536)
    | _ ->
        _menhir_fail ()

and _menhir_reduce27 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2262 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2268 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    ))) = _menhir_stack in
    let _v : 'tv_exp = 
# 225 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.IdentifierExp s, () )
# 2273 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v

and _menhir_run73 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 2280 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState73 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | RPAR ->
        _menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) MenhirState73
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState73

and _menhir_reduce49 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_separated_nonempty_list_COMMA_exp__ = 
# 128 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 2326 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_loption_separated_nonempty_list_COMMA_exp__ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_exp : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_exp -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv365 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv361 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv359 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_exp)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_exp = 
# 239 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( Syntax.AddressExp e, () )
# 2373 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv360)) : 'freshtv362)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv363 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv364)) : 'freshtv366)
    | MenhirState87 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv371 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | MINUS | NEQ | PLUS | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv367 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 204 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         (fun (l, r) -> Syntax.PlusExp(l, r))
# 2405 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2411 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv368)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv369 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv370)) : 'freshtv372)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv377 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | MINUS | MULT | NEQ | PLUS | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv373 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 206 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         (fun (l, r) -> Syntax.MultExp(l, r))
# 2441 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2447 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv374)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv375 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv376)) : 'freshtv378)
    | MenhirState91 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv395 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RSQBR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv391 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv389 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (s : 'tv_exp)), _, (idx : 'tv_exp)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_lexp = 
# 269 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ArrayAccessLExp {
       Syntax.array_access_array = s; array_access_index = idx} )
# 2496 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv387) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : 'tv_lexp) = _v in
            ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
            match _menhir_s with
            | MenhirState171 | MenhirState164 | MenhirState155 | MenhirState150 | MenhirState141 | MenhirState144 | MenhirState138 | MenhirState55 | MenhirState70 | MenhirState71 | MenhirState73 | MenhirState77 | MenhirState81 | MenhirState120 | MenhirState100 | MenhirState112 | MenhirState110 | MenhirState108 | MenhirState106 | MenhirState104 | MenhirState96 | MenhirState94 | MenhirState91 | MenhirState89 | MenhirState87 | MenhirState83 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv379 * _menhir_state * 'tv_lexp) = Obj.magic _menhir_stack in
                (_menhir_reduce36 _menhir_env (Obj.magic _menhir_stack) : 'freshtv380)
            | MenhirState53 | MenhirState180 | MenhirState177 | MenhirState157 | MenhirState168 ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv385 * _menhir_state * 'tv_lexp) = Obj.magic _menhir_stack in
                ((assert (not _menhir_env._menhir_error);
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | SINGLE_EQ ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv381 * _menhir_state * 'tv_lexp) = Obj.magic _menhir_stack in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | ADDRESS ->
                        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | BALANCE ->
                        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | DECLIT256 _v ->
                        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _v
                    | DECLIT8 _v ->
                        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _v
                    | DEPLOY ->
                        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | FALSE ->
                        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | IDENT _v ->
                        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState171 _v
                    | LPAR ->
                        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | NOT ->
                        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | NOW ->
                        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | SENDER ->
                        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | THIS ->
                        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | TRUE ->
                        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | VALUE ->
                        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState171
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState171) : 'freshtv382)
                | DOT | EQUALITY | GT | LAND | LSQBR | LT | MINUS | MULT | NEQ | PLUS ->
                    _menhir_reduce36 _menhir_env (Obj.magic _menhir_stack)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : 'freshtv383 * _menhir_state * 'tv_lexp) = Obj.magic _menhir_stack in
                    ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv384)) : 'freshtv386)
            | _ ->
                _menhir_fail ()) : 'freshtv388)) : 'freshtv390)) : 'freshtv392)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv393 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv394)) : 'freshtv396)
    | MenhirState94 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv401 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | NEQ | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv397 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 209 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
        (fun (l, r) -> Syntax.NeqExp(l, r))
# 2596 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2602 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv398)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv399 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv400)) : 'freshtv402)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv407 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | MINUS | NEQ | PLUS | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv403 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 205 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          (fun (l, r)  -> Syntax.MinusExp(l, r))
# 2634 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2640 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv404)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv405 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv406)) : 'freshtv408)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv413 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | REENTRANCE ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv409 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (v : 'tv_exp)) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_value_info = 
# 257 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                    ( Some v )
# 2684 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_value_info _menhir_env _menhir_stack _menhir_s _v) : 'freshtv410)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv411 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv412)) : 'freshtv414)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv419 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | NEQ | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv415 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 207 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (fun (l, r) -> Syntax.LtExp(l, r))
# 2720 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2726 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv416)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv417 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv418)) : 'freshtv420)
    | MenhirState108 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv425 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | LAND | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv421 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _2 = () in
            let _v : 'tv_exp = 
# 214 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                               ( Syntax.LandExp (lhs, rhs), () )
# 2768 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv422)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv423 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv424)) : 'freshtv426)
    | MenhirState110 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv431 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | NEQ | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv427 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 208 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (fun (l, r) -> Syntax.GtExp(l, r))
# 2804 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2810 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv428)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv429 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv430)) : 'freshtv432)
    | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv437 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | EQUALITY | GT | LAND | LT | NEQ | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv433 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_exp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _10 = () in
            let _v : 'tv_exp = let o =
              let _1 = _10 in
              
# 210 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
             (fun (l, r) -> Syntax.EqualityExp(l, r))
# 2846 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 223 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( (o (lhs, rhs)), () )
# 2852 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv434)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv435 * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv436)) : 'freshtv438)
    | MenhirState150 | MenhirState73 | MenhirState77 | MenhirState120 | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv445 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv439 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState120 _v
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState120
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState120) : 'freshtv440)
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv441 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_exp)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_exp_ = 
# 215 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 2933 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_exp_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv442)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv443 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv444)) : 'freshtv446)
    | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv453 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv449 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv447 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_exp)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_exp = 
# 221 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                 ( Syntax.BalanceExp e, () )
# 2982 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv448)) : 'freshtv450)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv451 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv452)) : 'freshtv454)
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv461 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv457 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv455 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_exp)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_exp = 
# 229 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ParenthExp e, () )
# 3030 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv456)) : 'freshtv458)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv459 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv460)) : 'freshtv462)
    | MenhirState70 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv467 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | COMMA | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv463 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_exp)) = _menhir_stack in
            let _1 = () in
            let _v : 'tv_exp = 
# 240 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                 ( Syntax.NotExp e, () )
# 3074 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv464)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv465 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv466)) : 'freshtv468)
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv475 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv471 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv469 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (value : 'tv_exp)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _1 = () in
            let _v : 'tv_sentence = 
# 196 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ExpSentence value )
# 3123 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv470)) : 'freshtv472)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv473 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv474)) : 'freshtv476)
    | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv483 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv479 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv477 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _, (e : 'tv_exp)) = _menhir_stack in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_sentence = 
# 200 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                     ( Syntax.SelfdestructSentence e )
# 3171 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv478)) : 'freshtv480)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv481 * _menhir_state) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv482)) : 'freshtv484)
    | MenhirState144 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv491 * _menhir_state) * _menhir_state * 'tv_option_exp_))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv487 * _menhir_state) * _menhir_state * 'tv_option_exp_))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv485 * _menhir_state) * _menhir_state * 'tv_option_exp_))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), _, (value : 'tv_option_exp_)), _, (cont : 'tv_exp)) = _menhir_stack in
            let _6 = () in
            let _4 = () in
            let _3 = () in
            let _1 = () in
            let _v : 'tv_sentence = 
# 182 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.ReturnSentence { Syntax. return_exp = value; return_cont = cont} )
# 3221 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv486)) : 'freshtv488)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv489 * _menhir_state) * _menhir_state * 'tv_option_exp_))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv490)) : 'freshtv492)
    | MenhirState141 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv497 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | THEN ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv493 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_exp)) = _menhir_stack in
            let _v : 'tv_option_exp_ = 
# 102 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( Some x )
# 3264 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_option_exp_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv494)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv495 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv496)) : 'freshtv498)
    | MenhirState155 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv503 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv499 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ABORT ->
                _menhir_run160 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | ADDRESS ->
                _menhir_run159 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | BOOL ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | BYTES32 ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | IDENT _v ->
                _menhir_run158 _menhir_env (Obj.magic _menhir_stack) MenhirState157 _v
            | IF ->
                _menhir_run154 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | LBRACE ->
                _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | LOG ->
                _menhir_run148 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | RETURN ->
                _menhir_run141 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | SELFDESTRUCT ->
                _menhir_run138 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | UINT256 ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | UINT8 ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | VOID ->
                _menhir_run54 _menhir_env (Obj.magic _menhir_stack) MenhirState157
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState157) : 'freshtv500)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv501 * _menhir_state)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv502)) : 'freshtv504)
    | MenhirState164 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv511 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3372 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv507 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3402 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv505 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3409 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s, (t : 'tv_typ)), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3414 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))), _, (value : 'tv_exp)) = _menhir_stack in
            let _5 = () in
            let _3 = () in
            let _v : 'tv_sentence = 
# 189 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              ( Syntax.VariableInitSentence
                { Syntax.variable_init_type = t
                ; variable_init_name = name
                ; variable_init_value = value
                }
              )
# 3426 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv506)) : 'freshtv508)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv509 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3436 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv510)) : 'freshtv512)
    | MenhirState171 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv519 * _menhir_state * 'tv_lexp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv515 * _menhir_state * 'tv_lexp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv513 * _menhir_state * 'tv_lexp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (lhs : 'tv_lexp)), _, (rhs : 'tv_exp)) = _menhir_stack in
            let _4 = () in
            let _2 = () in
            let _v : 'tv_sentence = 
# 184 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.AssignmentSentence (lhs, rhs) )
# 3478 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_sentence _menhir_env _menhir_stack _menhir_s _v) : 'freshtv514)) : 'freshtv516)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv517 * _menhir_state * 'tv_lexp)) * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv518)) : 'freshtv520)
    | MenhirState53 | MenhirState180 | MenhirState177 | MenhirState157 | MenhirState168 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv523 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | DOT ->
            _menhir_run98 _menhir_env (Obj.magic _menhir_stack)
        | EQUALITY ->
            _menhir_run112 _menhir_env (Obj.magic _menhir_stack)
        | GT ->
            _menhir_run110 _menhir_env (Obj.magic _menhir_stack)
        | LAND ->
            _menhir_run108 _menhir_env (Obj.magic _menhir_stack)
        | LSQBR ->
            _menhir_run91 _menhir_env (Obj.magic _menhir_stack)
        | LT ->
            _menhir_run106 _menhir_env (Obj.magic _menhir_stack)
        | MINUS ->
            _menhir_run96 _menhir_env (Obj.magic _menhir_stack)
        | MULT ->
            _menhir_run89 _menhir_env (Obj.magic _menhir_stack)
        | NEQ ->
            _menhir_run94 _menhir_env (Obj.magic _menhir_stack)
        | PLUS ->
            _menhir_run87 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv521 * _menhir_state * 'tv_exp) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv522)) : 'freshtv524)
    | _ ->
        _menhir_fail ()

and _menhir_run83 : _menhir_env -> 'ttv_tail * _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState83 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState83
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState83

and _menhir_goto_separated_nonempty_list_COMMA_event_arg_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_event_arg_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv353) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_event_arg_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv351) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_event_arg_) : 'tv_separated_nonempty_list_COMMA_event_arg_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_event_arg__ = 
# 130 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 3577 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_event_arg__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv352)) : 'freshtv354)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv357 * _menhir_state * 'tv_event_arg)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_event_arg_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv355 * _menhir_state * 'tv_event_arg)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_event_arg_) : 'tv_separated_nonempty_list_COMMA_event_arg_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_event_arg)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_event_arg_ = 
# 217 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 3594 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_event_arg_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv356)) : 'freshtv358)
    | _ ->
        _menhir_fail ()

and _menhir_goto_separated_nonempty_list_COMMA_arg_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_separated_nonempty_list_COMMA_arg_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    match _menhir_s with
    | MenhirState46 | MenhirState37 | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv345) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_arg_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv343) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let ((x : 'tv_separated_nonempty_list_COMMA_arg_) : 'tv_separated_nonempty_list_COMMA_arg_) = _v in
        ((let _v : 'tv_loption_separated_nonempty_list_COMMA_arg__ = 
# 130 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 3615 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_loption_separated_nonempty_list_COMMA_arg__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv344)) : 'freshtv346)
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv349 * _menhir_state * 'tv_arg)) = Obj.magic _menhir_stack in
        let (_menhir_s : _menhir_state) = _menhir_s in
        let (_v : 'tv_separated_nonempty_list_COMMA_arg_) = _v in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv347 * _menhir_state * 'tv_arg)) = Obj.magic _menhir_stack in
        let (_ : _menhir_state) = _menhir_s in
        let ((xs : 'tv_separated_nonempty_list_COMMA_arg_) : 'tv_separated_nonempty_list_COMMA_arg_) = _v in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_arg)) = _menhir_stack in
        let _2 = () in
        let _v : 'tv_separated_nonempty_list_COMMA_arg_ = 
# 217 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 3632 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_arg_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv348)) : 'freshtv350)
    | _ ->
        _menhir_fail ()

and _menhir_goto_case_header : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_case_header -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv341 * _menhir_state * 'tv_case_header) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LBRACE ->
        _menhir_run53 _menhir_env (Obj.magic _menhir_stack) MenhirState52
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState52) : 'freshtv342)

and _menhir_reduce39 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_case_ = 
# 185 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 3658 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_list_case_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run32 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv339) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_case_header = 
# 113 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.DefaultCaseHeader )
# 3672 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_case_header _menhir_env _menhir_stack _menhir_s _v) : 'freshtv340)

and _menhir_run33 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv335 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ADDRESS ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | BOOL ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | BYTES32 ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | IDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState34 _v
        | UINT256 ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | UINT8 ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState34
        | VOID ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv333 * _menhir_state)) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = MenhirState34 in
            ((let _menhir_stack = (_menhir_stack, _menhir_s) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv329 * _menhir_state)) * _menhir_state) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3714 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = _v in
                ((let _menhir_stack = (_menhir_stack, _v) in
                let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | LPAR ->
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : ((('freshtv325 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3725 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    )) = Obj.magic _menhir_stack in
                    ((let _menhir_env = _menhir_discard _menhir_env in
                    let _tok = _menhir_env._menhir_token in
                    match _tok with
                    | ADDRESS ->
                        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | BOOL ->
                        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | BYTES32 ->
                        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | IDENT _v ->
                        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState37 _v
                    | UINT256 ->
                        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | UINT8 ->
                        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | RPAR ->
                        _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack) MenhirState37
                    | _ ->
                        assert (not _menhir_env._menhir_error);
                        _menhir_env._menhir_error <- true;
                        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState37) : 'freshtv326)
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    let (_menhir_env : _menhir_env) = _menhir_env in
                    let (_menhir_stack : ((('freshtv327 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 3755 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    )) = Obj.magic _menhir_stack in
                    ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv328)) : 'freshtv330)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv331 * _menhir_state)) * _menhir_state) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv332)) : 'freshtv334)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState34) : 'freshtv336)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv337 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv338)

and _menhir_run56 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv321 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | MSG ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv317 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv313 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv311 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                let _4 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_exp = 
# 219 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                        ( Syntax.ValueExp, () )
# 3810 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv312)) : 'freshtv314)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv315 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv316)) : 'freshtv318)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv319 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv320)) : 'freshtv322)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv323 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv324)

and _menhir_run60 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv309) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_exp = 
# 215 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.TrueExp, () )
# 3845 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv310)

and _menhir_run61 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv307) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_exp = 
# 241 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.ThisExp, () )
# 3859 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv308)

and _menhir_run62 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv303 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | MSG ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv299 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv295 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv293 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                let _4 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_exp = 
# 220 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                         ( Syntax.SenderExp, () )
# 3895 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv294)) : 'freshtv296)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv297 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv298)) : 'freshtv300)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv301 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv302)) : 'freshtv304)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv305 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv306)

and _menhir_run66 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv289 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | BLOCK ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv285 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv281 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv279 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                let _4 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
                let _v : 'tv_exp = 
# 222 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                        ( Syntax.NowExp, () )
# 3952 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv280)) : 'freshtv282)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (('freshtv283 * _menhir_state))) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv284)) : 'freshtv286)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv287 * _menhir_state)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv288)) : 'freshtv290)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv291 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv292)

and _menhir_run70 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState70 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState70
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState70

and _menhir_run71 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | BALANCE ->
        _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | DECLIT256 _v ->
        _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | DECLIT8 _v ->
        _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | DEPLOY ->
        _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | FALSE ->
        _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | IDENT _v ->
        _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState71 _v
    | LPAR ->
        _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | NOT ->
        _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | NOW ->
        _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | SENDER ->
        _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | THIS ->
        _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | TRUE ->
        _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | VALUE ->
        _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState71
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState71

and _menhir_run72 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4058 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        _menhir_run73 _menhir_env (Obj.magic _menhir_stack)
    | COMMA | DOT | EQUALITY | GT | LAND | LSQBR | LT | MINUS | MULT | NEQ | PLUS | REENTRANCE | RPAR | RSQBR | SEMICOLON | THEN ->
        _menhir_reduce27 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv277 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4076 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv278)

and _menhir_run74 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv275) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_exp = 
# 216 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          ( Syntax.FalseExp, () )
# 4091 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv276)

and _menhir_run75 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv271 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4107 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv267 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4118 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | BALANCE ->
                _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | DECLIT256 _v ->
                _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState77 _v
            | DECLIT8 _v ->
                _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState77 _v
            | DEPLOY ->
                _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | FALSE ->
                _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | IDENT _v ->
                _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState77 _v
            | LPAR ->
                _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | NOT ->
                _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | NOW ->
                _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | SENDER ->
                _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | THIS ->
                _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | TRUE ->
                _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | VALUE ->
                _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | RPAR ->
                _menhir_reduce49 _menhir_env (Obj.magic _menhir_stack) MenhirState77
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState77) : 'freshtv268)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv269 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4164 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv270)) : 'freshtv272)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv273 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv274)

and _menhir_run78 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 4 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4179 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv265) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((d : (
# 4 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4189 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) : (
# 4 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4193 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) = _v in
    ((let _v : 'tv_exp = 
# 218 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                ( Syntax.DecLit8Exp d, ())
# 4198 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv266)

and _menhir_run79 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4205 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv263) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let ((d : (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4215 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) : (
# 3 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (WrapBn.t)
# 4219 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) = _v in
    ((let _v : 'tv_exp = 
# 217 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                  ( Syntax.DecLit256Exp d, ())
# 4224 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_exp _menhir_env _menhir_stack _menhir_s _v) : 'freshtv264)

and _menhir_run80 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv259 * _menhir_state) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ADDRESS ->
            _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | BALANCE ->
            _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | DECLIT256 _v ->
            _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
        | DECLIT8 _v ->
            _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
        | DEPLOY ->
            _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | FALSE ->
            _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | IDENT _v ->
            _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState81 _v
        | LPAR ->
            _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | NOT ->
            _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | NOW ->
            _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | SENDER ->
            _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | THIS ->
            _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | TRUE ->
            _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | VALUE ->
            _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState81
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState81) : 'freshtv260)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv261 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv262)

and _menhir_run82 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | LPAR ->
        _menhir_run83 _menhir_env (Obj.magic _menhir_stack)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv257 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv258)

and _menhir_run11 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_typ -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | ADDRESS ->
        _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | BOOL ->
        _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | BYTES32 ->
        _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | IDENT _v ->
        _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState11 _v
    | UINT256 ->
        _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | UINT8 ->
        _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState11
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState11

and _menhir_goto_event_arg : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_event_arg -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv255 * _menhir_state * 'tv_event_arg) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | COMMA ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv249 * _menhir_state * 'tv_event_arg) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | ADDRESS ->
            _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | BOOL ->
            _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | BYTES32 ->
            _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | IDENT _v ->
            _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState21 _v
        | UINT256 ->
            _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | UINT8 ->
            _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState21
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState21) : 'freshtv250)
    | RPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv251 * _menhir_state * 'tv_event_arg) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (x : 'tv_event_arg)) = _menhir_stack in
        let _v : 'tv_separated_nonempty_list_COMMA_event_arg_ = 
# 215 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 4355 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_separated_nonempty_list_COMMA_event_arg_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv252)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv253 * _menhir_state * 'tv_event_arg) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv254)) : 'freshtv256)

and _menhir_run15 : _menhir_env -> 'ttv_tail * _menhir_state * 'tv_typ -> (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4369 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _v ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv247 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
    let ((i : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4378 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4382 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    )) = _v in
    ((let (_menhir_stack, _menhir_s, (t : 'tv_typ)) = _menhir_stack in
    let _v : 'tv_arg = 
# 139 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( { Syntax.arg_typ = t
      ; Syntax.arg_ident = i
      ; Syntax.arg_location = None
      }
    )
# 4392 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv245) = _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    let (_v : 'tv_arg) = _v in
    ((let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState3 | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv235 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv233 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, (a : 'tv_arg)) = _menhir_stack in
        let _v : 'tv_event_arg = 
# 147 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.event_arg_of_arg a false )
# 4409 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_event_arg _menhir_env _menhir_stack _menhir_s _v) : 'freshtv234)) : 'freshtv236)
    | MenhirState26 | MenhirState46 | MenhirState42 | MenhirState37 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv243 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | COMMA ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv237 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState42
            | BOOL ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState42
            | BYTES32 ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState42
            | IDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState42 _v
            | UINT256 ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState42
            | UINT8 ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState42
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState42) : 'freshtv238)
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv239 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (x : 'tv_arg)) = _menhir_stack in
            let _v : 'tv_separated_nonempty_list_COMMA_arg_ = 
# 215 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [ x ] )
# 4447 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_separated_nonempty_list_COMMA_arg_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv240)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv241 * _menhir_state * 'tv_arg) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv242)) : 'freshtv244)
    | _ ->
        _menhir_fail ()) : 'freshtv246)) : 'freshtv248)

and _menhir_fail : unit -> 'a =
  fun () ->
    Printf.fprintf Pervasives.stderr "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

and _menhir_goto_contract : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_contract -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv231 * _menhir_state * 'tv_contract) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CONTRACT ->
        _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState190
    | EVENT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState190
    | EOF ->
        _menhir_reduce41 _menhir_env (Obj.magic _menhir_stack) MenhirState190
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState190) : 'freshtv232)

and _menhir_goto_loption_separated_nonempty_list_COMMA_arg__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_arg__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv205 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4493 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv201 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4503 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LBRACE ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv197 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4513 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | CASE ->
                    _menhir_run33 _menhir_env (Obj.magic _menhir_stack) MenhirState31
                | DEFAULT ->
                    _menhir_run32 _menhir_env (Obj.magic _menhir_stack) MenhirState31
                | RBRACE ->
                    _menhir_reduce39 _menhir_env (Obj.magic _menhir_stack) MenhirState31
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState31) : 'freshtv198)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((('freshtv199 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4535 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv200)) : 'freshtv202)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((('freshtv203 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4546 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv204)) : 'freshtv206)
    | MenhirState37 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv217 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4555 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv213 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4565 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv209 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4575 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv207 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4582 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s), _), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4587 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))), _, (xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__)) = _menhir_stack in
                let _6 = () in
                let _300 = () in
                let _100 = () in
                let _3 = () in
                let _2 = () in
                let _1 = () in
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
                      
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 4608 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 4614 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    
                  in
                  
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 4620 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 128 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.UsualCaseHeader
      { case_return_typ = []
      ; Syntax.case_name = name
      ; case_arguments = args
      }
    )
# 4631 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_case_header _menhir_env _menhir_stack _menhir_s _v) : 'freshtv208)) : 'freshtv210)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv211 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4641 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv212)) : 'freshtv214)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv215 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4652 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv216)) : 'freshtv218)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv229 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4661 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv225 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4671 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv221 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4681 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv219 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4688 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let ((((_menhir_stack, _menhir_s), _, (return_typ : 'tv_typ)), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4693 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))), _, (xs000 : 'tv_loption_separated_nonempty_list_COMMA_arg__)) = _menhir_stack in
                let _6 = () in
                let _300 = () in
                let _100 = () in
                let _2 = () in
                let _1 = () in
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
                      
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 4713 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                      
                    in
                    
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 4719 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                    
                  in
                  
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 4725 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 118 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.UsualCaseHeader
      { case_return_typ = [return_typ] (* multi returns not supported *)
      ; Syntax.case_name = name
      ; case_arguments = args
      }
    )
# 4736 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_case_header _menhir_env _menhir_stack _menhir_s _v) : 'freshtv220)) : 'freshtv222)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : (((((('freshtv223 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4746 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv224)) : 'freshtv226)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ((((('freshtv227 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4757 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv228)) : 'freshtv230)
    | _ ->
        _menhir_fail ()

and _menhir_reduce80 : _menhir_env -> 'ttv_tail * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4767 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s, (s : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4773 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    ))) = _menhir_stack in
    let _v : 'tv_typ = 
# 171 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
              ( Syntax.ContractInstanceType s )
# 4778 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_typ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_typ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState21 | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv165 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _v
        | INDEXED ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv161 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | IDENT _v ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv157 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
                let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4806 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = _v in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv155 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
                let ((i : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4814 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4818 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = _v in
                ((let (_menhir_stack, _menhir_s, (t : 'tv_typ)) = _menhir_stack in
                let _2 = () in
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
# 4832 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_event_arg _menhir_env _menhir_stack _menhir_s _v) : 'freshtv156)) : 'freshtv158)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv159 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
                ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv160)) : 'freshtv162)
        | RARROW ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv163 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv164)) : 'freshtv166)
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv171 * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | RARROW ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack)
        | IDENT _ | INDEXED ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv167 * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s, (key : 'tv_typ)), _, (value : 'tv_typ)) = _menhir_stack in
            let _2 = () in
            let _v : 'tv_typ = 
# 170 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.MappingType (key, value) )
# 4867 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv168)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv169 * _menhir_state * 'tv_typ)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv170)) : 'freshtv172)
    | MenhirState46 | MenhirState42 | MenhirState37 | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv175 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            _menhir_run15 _menhir_env (Obj.magic _menhir_stack) _v
        | RARROW ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv173 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv174)) : 'freshtv176)
    | MenhirState34 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv185 * _menhir_state)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv181 * _menhir_state)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4906 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | LPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv177 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4917 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | ADDRESS ->
                    _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | BOOL ->
                    _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | BYTES32 ->
                    _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | IDENT _v ->
                    _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState46 _v
                | UINT256 ->
                    _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | UINT8 ->
                    _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | RPAR ->
                    _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack) MenhirState46
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState46) : 'freshtv178)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ((('freshtv179 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4947 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv180)) : 'freshtv182)
        | RARROW ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (('freshtv183 * _menhir_state)) * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv184)) : 'freshtv186)
    | MenhirState180 | MenhirState53 | MenhirState177 | MenhirState168 | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv195 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | IDENT _v ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv191 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4972 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = _v in
            ((let _menhir_stack = (_menhir_stack, _v) in
            let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | SINGLE_EQ ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv187 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 4983 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let _menhir_env = _menhir_discard _menhir_env in
                let _tok = _menhir_env._menhir_token in
                match _tok with
                | ADDRESS ->
                    _menhir_run82 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | BALANCE ->
                    _menhir_run80 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | DECLIT256 _v ->
                    _menhir_run79 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _v
                | DECLIT8 _v ->
                    _menhir_run78 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _v
                | DEPLOY ->
                    _menhir_run75 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | FALSE ->
                    _menhir_run74 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | IDENT _v ->
                    _menhir_run72 _menhir_env (Obj.magic _menhir_stack) MenhirState164 _v
                | LPAR ->
                    _menhir_run71 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | NOT ->
                    _menhir_run70 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | NOW ->
                    _menhir_run66 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | SENDER ->
                    _menhir_run62 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | THIS ->
                    _menhir_run61 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | TRUE ->
                    _menhir_run60 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | VALUE ->
                    _menhir_run56 _menhir_env (Obj.magic _menhir_stack) MenhirState164
                | _ ->
                    assert (not _menhir_env._menhir_error);
                    _menhir_env._menhir_error <- true;
                    _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState164) : 'freshtv188)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : ('freshtv189 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5027 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                )) = Obj.magic _menhir_stack in
                ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv190)) : 'freshtv192)
        | RARROW ->
            _menhir_run11 _menhir_env (Obj.magic _menhir_stack)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv193 * _menhir_state * 'tv_typ) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv194)) : 'freshtv196)
    | _ ->
        _menhir_fail ()

and _menhir_reduce77 : _menhir_env -> 'ttv_tail * _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack ->
    let (_menhir_stack, _menhir_s) = _menhir_stack in
    let _1 = () in
    let _v : 'tv_typ = 
# 165 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.AddressType )
# 5050 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v

and _menhir_goto_list_contract_ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_list_contract_ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    match _menhir_s with
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv149 * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
        ((assert (not _menhir_env._menhir_error);
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | EOF ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv145 * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv143 * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, (cs : 'tv_list_contract_)) = _menhir_stack in
            let _2 = () in
            let _v : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5074 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ) = 
# 72 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                              ( cs )
# 5078 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv141) = _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5086 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv139) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let (_v : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5094 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = _v in
            ((let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv137) = Obj.magic _menhir_stack in
            let (_menhir_s : _menhir_state) = _menhir_s in
            let ((_1 : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5102 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) : (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5106 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = _v in
            (Obj.magic _1 : 'freshtv138)) : 'freshtv140)) : 'freshtv142)) : 'freshtv144)) : 'freshtv146)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : 'freshtv147 * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv148)) : 'freshtv150)
    | MenhirState190 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv153 * _menhir_state * 'tv_contract) * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
        ((let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv151 * _menhir_state * 'tv_contract) * _menhir_state * 'tv_list_contract_) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, (x : 'tv_contract)), _, (xs : 'tv_list_contract_)) = _menhir_stack in
        let _v : 'tv_list_contract_ = 
# 187 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x :: xs )
# 5125 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
         in
        _menhir_goto_list_contract_ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv152)) : 'freshtv154)
    | _ ->
        _menhir_fail ()

and _menhir_goto_loption_separated_nonempty_list_COMMA_event_arg__ : _menhir_env -> 'ttv_tail -> _menhir_state -> 'tv_loption_separated_nonempty_list_COMMA_event_arg__ -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : ((('freshtv135 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5138 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
    ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__) = Obj.magic _menhir_stack in
    ((assert (not _menhir_env._menhir_error);
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | RPAR ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv131 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5148 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__) = Obj.magic _menhir_stack in
        ((let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | SEMICOLON ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv127 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5158 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__)) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv125 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5165 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__)) = Obj.magic _menhir_stack in
            ((let (((_menhir_stack, _menhir_s), (name : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5170 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))), _, (xs000 : 'tv_loption_separated_nonempty_list_COMMA_event_arg__)) = _menhir_stack in
            let _4 = () in
            let _300 = () in
            let _100 = () in
            let _1 = () in
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
                  
# 206 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( xs )
# 5189 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                  
                in
                
# 174 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( x )
# 5195 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                
              in
              
# 69 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
                                                        (xs)
# 5201 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
              
            in
            
# 90 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
    ( Syntax.Event { Syntax.event_arguments = args
      ; event_name = name
      })
# 5209 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
             in
            _menhir_goto_contract _menhir_env _menhir_stack _menhir_s _v) : 'freshtv126)) : 'freshtv128)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : (((('freshtv129 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5219 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__)) = Obj.magic _menhir_stack in
            ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv130)) : 'freshtv132)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv133 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5230 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_event_arg__) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv134)) : 'freshtv136)

and _menhir_reduce45 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_loption_separated_nonempty_list_COMMA_arg__ = 
# 128 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 5240 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_loption_separated_nonempty_list_COMMA_arg__ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run4 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv123) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_typ = 
# 163 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
          ( Syntax.Uint8Type )
# 5254 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv124)

and _menhir_run5 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv121) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_typ = 
# 162 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.Uint256Type )
# 5268 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv122)

and _menhir_run6 : _menhir_env -> 'ttv_tail -> _menhir_state -> (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5275 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s _v ->
    let _menhir_stack = (_menhir_stack, _menhir_s, _v) in
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce80 _menhir_env (Obj.magic _menhir_stack)

and _menhir_run7 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv119) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_typ = 
# 164 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
            ( Syntax.Bytes32Type )
# 5292 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv120)

and _menhir_run8 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_env = _menhir_discard _menhir_env in
    let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv117) = Obj.magic _menhir_stack in
    let (_menhir_s : _menhir_state) = _menhir_s in
    ((let _1 = () in
    let _v : 'tv_typ = 
# 166 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
         ( Syntax.BoolType )
# 5306 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_typ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv118)

and _menhir_run9 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    _menhir_reduce77 _menhir_env (Obj.magic _menhir_stack)

and _menhir_errorcase : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    match _menhir_s with
    | MenhirState190 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv21 * _menhir_state * 'tv_contract) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv22)
    | MenhirState185 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv23 * _menhir_state * 'tv_case) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv24)
    | MenhirState180 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv25 * _menhir_state * 'tv_sentence) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv26)
    | MenhirState177 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv27 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_block)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv28)
    | MenhirState171 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv29 * _menhir_state * 'tv_lexp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv30)
    | MenhirState168 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv31 * _menhir_state)) * _menhir_state * 'tv_exp)) * _menhir_state * 'tv_sentence)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv32)
    | MenhirState164 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv33 * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5354 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv34)
    | MenhirState157 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv35 * _menhir_state)) * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv36)
    | MenhirState155 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv37 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv38)
    | MenhirState150 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv39 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5373 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv40)
    | MenhirState144 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv41 * _menhir_state) * _menhir_state * 'tv_option_exp_))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv42)
    | MenhirState141 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv43 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv44)
    | MenhirState138 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv45 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv46)
    | MenhirState129 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv47 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5397 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv48)
    | MenhirState124 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv49 * _menhir_state * 'tv_exp))))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv50)
    | MenhirState120 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv51 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv52)
    | MenhirState115 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv53) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv54)
    | MenhirState112 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv55 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv56)
    | MenhirState110 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv57 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv58)
    | MenhirState108 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv59 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv60)
    | MenhirState106 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv61 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv62)
    | MenhirState104 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv63 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv64)
    | MenhirState103 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv65 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5445 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_exp__)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv66)
    | MenhirState100 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((('freshtv67 * _menhir_state * 'tv_exp)) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5454 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv68)
    | MenhirState96 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv69 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv70)
    | MenhirState94 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv71 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv72)
    | MenhirState91 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv73 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv74)
    | MenhirState89 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv75 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv76)
    | MenhirState87 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv77 * _menhir_state * 'tv_exp)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv78)
    | MenhirState83 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv79 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv80)
    | MenhirState81 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv81 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv82)
    | MenhirState77 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv83 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5498 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv84)
    | MenhirState73 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv85 * _menhir_state * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5507 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv86)
    | MenhirState71 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv87 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv88)
    | MenhirState70 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv89 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv90)
    | MenhirState55 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv91 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv92)
    | MenhirState53 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv93 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv94)
    | MenhirState52 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv95 * _menhir_state * 'tv_case_header) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv96)
    | MenhirState46 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv97 * _menhir_state)) * _menhir_state * 'tv_typ) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5541 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s, _), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv98)
    | MenhirState42 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv99 * _menhir_state * 'tv_arg)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv100)
    | MenhirState37 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (((('freshtv101 * _menhir_state)) * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5555 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv102)
    | MenhirState34 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv103 * _menhir_state)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv104)
    | MenhirState31 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ((((('freshtv105 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5569 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) * _menhir_state * 'tv_loption_separated_nonempty_list_COMMA_arg__))) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv106)
    | MenhirState26 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv107 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5578 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv108)
    | MenhirState21 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv109 * _menhir_state * 'tv_event_arg)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv110)
    | MenhirState11 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : ('freshtv111 * _menhir_state * 'tv_typ)) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s, _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv112)
    | MenhirState3 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : (('freshtv113 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5597 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        ))) = Obj.magic _menhir_stack in
        ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv114)
    | MenhirState0 ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv115) = Obj.magic _menhir_stack in
        (raise _eRR : 'freshtv116)

and _menhir_reduce41 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _v : 'tv_list_contract_ = 
# 185 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 5611 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
     in
    _menhir_goto_list_contract_ _menhir_env _menhir_stack _menhir_s _v

and _menhir_run1 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv17 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5627 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv13 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5638 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | BOOL ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | BYTES32 ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | IDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState3 _v
            | UINT256 ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | UINT8 ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState3
            | RPAR ->
                let (_menhir_env : _menhir_env) = _menhir_env in
                let (_menhir_stack : 'freshtv11) = Obj.magic _menhir_stack in
                let (_menhir_s : _menhir_state) = MenhirState3 in
                ((let _v : 'tv_loption_separated_nonempty_list_COMMA_event_arg__ = 
# 128 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
    ( [] )
# 5662 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
                 in
                _menhir_goto_loption_separated_nonempty_list_COMMA_event_arg__ _menhir_env _menhir_stack _menhir_s _v) : 'freshtv12)
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState3) : 'freshtv14)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv15 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5676 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv16)) : 'freshtv18)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv19 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv20)

and _menhir_run24 : _menhir_env -> 'ttv_tail -> _menhir_state -> 'ttv_return =
  fun _menhir_env _menhir_stack _menhir_s ->
    let _menhir_stack = (_menhir_stack, _menhir_s) in
    let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | IDENT _v ->
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv7 * _menhir_state) = Obj.magic _menhir_stack in
        let (_v : (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5700 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
        )) = _v in
        ((let _menhir_stack = (_menhir_stack, _v) in
        let _menhir_env = _menhir_discard _menhir_env in
        let _tok = _menhir_env._menhir_token in
        match _tok with
        | LPAR ->
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv3 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5711 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let _menhir_env = _menhir_discard _menhir_env in
            let _tok = _menhir_env._menhir_token in
            match _tok with
            | ADDRESS ->
                _menhir_run9 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | BOOL ->
                _menhir_run8 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | BYTES32 ->
                _menhir_run7 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | IDENT _v ->
                _menhir_run6 _menhir_env (Obj.magic _menhir_stack) MenhirState26 _v
            | UINT256 ->
                _menhir_run5 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | UINT8 ->
                _menhir_run4 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | RPAR ->
                _menhir_reduce45 _menhir_env (Obj.magic _menhir_stack) MenhirState26
            | _ ->
                assert (not _menhir_env._menhir_error);
                _menhir_env._menhir_error <- true;
                _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState26) : 'freshtv4)
        | _ ->
            assert (not _menhir_env._menhir_error);
            _menhir_env._menhir_error <- true;
            let (_menhir_env : _menhir_env) = _menhir_env in
            let (_menhir_stack : ('freshtv5 * _menhir_state) * (
# 2 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (string)
# 5741 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
            )) = Obj.magic _menhir_stack in
            ((let ((_menhir_stack, _menhir_s), _) = _menhir_stack in
            _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv6)) : 'freshtv8)
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        let (_menhir_env : _menhir_env) = _menhir_env in
        let (_menhir_stack : 'freshtv9 * _menhir_state) = Obj.magic _menhir_stack in
        ((let (_menhir_stack, _menhir_s) = _menhir_stack in
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) _menhir_s) : 'freshtv10)

and _menhir_discard : _menhir_env -> _menhir_env =
  fun _menhir_env ->
    let lexer = _menhir_env._menhir_lexer in
    let lexbuf = _menhir_env._menhir_lexbuf in
    let _tok = lexer lexbuf in
    {
      _menhir_lexer = lexer;
      _menhir_lexbuf = lexbuf;
      _menhir_token = _tok;
      _menhir_error = false;
    }

and file : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (
# 64 "/Users/javi/Development/github/bamboo/src/parse/parser.mly"
       (unit Syntax.toplevel list)
# 5768 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
) =
  fun lexer lexbuf ->
    let _menhir_env =
      let (lexer : Lexing.lexbuf -> token) = lexer in
      let (lexbuf : Lexing.lexbuf) = lexbuf in
      ((let _tok = Obj.magic () in
      {
        _menhir_lexer = lexer;
        _menhir_lexbuf = lexbuf;
        _menhir_token = _tok;
        _menhir_error = false;
      }) : _menhir_env)
    in
    Obj.magic (let (_menhir_env : _menhir_env) = _menhir_env in
    let (_menhir_stack : 'freshtv1) = ((), _menhir_env._menhir_lexbuf.Lexing.lex_curr_p) in
    ((let _menhir_env = _menhir_discard _menhir_env in
    let _tok = _menhir_env._menhir_token in
    match _tok with
    | CONTRACT ->
        _menhir_run24 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | EVENT ->
        _menhir_run1 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | EOF ->
        _menhir_reduce41 _menhir_env (Obj.magic _menhir_stack) MenhirState0
    | _ ->
        assert (not _menhir_env._menhir_error);
        _menhir_env._menhir_error <- true;
        _menhir_errorcase _menhir_env (Obj.magic _menhir_stack) MenhirState0) : 'freshtv2))

# 219 "/Users/javi/.opam/4.02.3+buckle-master/lib/menhir/standard.mly"
  


# 5802 "/Users/javi/Development/github/bamboo/src/parse/parser.ml"
