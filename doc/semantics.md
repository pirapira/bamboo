# Bamboo Semantics

This document describes the semantics of the Bamboo language.  Against the norm, I try to skip the explanation of the syntax and directly desrcibe the semantics in a relaxed manner.

## Overview

### Arena of the Game

A program written in Bamboo, after deployed, participates in a game between the program and the world.  In this game, the world makes the first move, the program the second move, and so on alternatively.  Neither the world or the program makes two moves in a row.

The world can make the following three kinds of moves:
* calling the program
* returning into the program
* failing into the program

The program can make the following four kinds of moves:
* calling an account
* returning
* failing
* destroying itself

The game is somehow structured.  After a move, the program can be running with `n`-times nesting.

Initially, when the program is deployed, the program is not running (or running with 0-times nesting).  When the program is not running, the world can only call the account.

When the world calls the account, the nesting increases.  When the program returns, fails, or destroys itself, the nesting decreases.

### Bamboo's Strategy

In general, a program needs to specify its move after any sequence of moves.  However, Bamboo does not remember the history as a whole, but just remembers the "program's state".  The Bamboo semantics computes the program's next move only using the program's state and the previous move made by the world.  In addition to the program's move, the Bamboo semantics specifies the remaining program's state for the later use.

### Bamboo's Program State

The program's state is a name of the contract followed by its arguments.
