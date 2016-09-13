(* Some code in this file comes from
 * https://github.com/realworldocaml/examples/tree/master/code/parsing-test
 * which is under UNLICENSE
 *)
{
  open Lexing
  open Parser
  exception SyntaxError of string

  let next_line lexbuf =
    let pos = lexbuf.lex_curr_p in
      lexbuf.lex_curr_p <-
          { pos with pos_bol = lexbuf.lex_curr_pos;
            pos_lnum = pos.pos_lnum + 1
    }
}

let white = [' ' '\t']+
let newline = '\r' | '\n' | "\r\n"
let digit = ['0'-'9']
let id = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*
let comment = "//" (_ # ['\r' '\n'])* newline

rule read =
  parse
  | white    { read lexbuf }
  | comment  { next_line lexbuf; read lexbuf }
  | newline  { next_line lexbuf; read lexbuf }
  | "contract" { CONTRACT }
  | "(" { LPAR }
  | ")" { RPAR }
  | "{" { LBRACE }
  | "}" { RBRACE }
  | id  { IDENT (lexeme lexbuf) }
  | eof { EOF }
