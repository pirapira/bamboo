
(* The type of tokens. *)

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
  | IDENT of (string)
  | GT
  | FALSE
  | EVENT
  | EQUALITY
  | EOF
  | ELSE
  | DOT
  | DEPLOY
  | DEFAULT
  | DECLIT8 of (Wrap_bn.t)
  | DECLIT256 of (Wrap_bn.t)
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

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val file: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (unit Syntax.toplevel list)

module MenhirInterpreter : sig
  
  (* The incremental API. *)
  
  include MenhirLib.IncrementalEngine.INCREMENTAL_ENGINE
    with type token = token
  
end

(* The entry point(s) to the incremental API. *)

module Incremental : sig
  
  val file: unit -> (unit Syntax.toplevel list) MenhirInterpreter.result
  
end
