# Bamboo Semantics Sketch

This document describes the semantics of the Bamboo language.  This is an informal sketch written as a preparation for the coming Coq code.

## Overview

### Arena of the Game

A program written in Bamboo, after deployed, participates in a game between the program and the world.  In this game, the world makes the first move, the program makes the second move, and so on alternatively.  Neither the world or the program makes two moves in a row.  This document aims at the choice of the program's move, given a sequence of earlier moves.

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

When the world calls the account, the nesting increases by one.  When the program returns, fails, or destroys itself, the nesting decreases by one.

From the above sentences, you should be able to prove that the nesting never goes below zero.

### Bamboo's Strategy

In general, a program needs to specify its move after any sequence of moves.  However, Bamboo does not remember the history as a whole, but just remembers the "program's state".  The Bamboo semantics computes the program's next move only using the program's state and the previous move made by the world.  In addition to the program's move, the Bamboo semantics specifies the remaining program's state for the later use.

### Bamboo's Program State

The program's state has three components: a persistent state, a `killed` flag, and pending execution states.  When the game is `n`-running, the program's state contains `n` pending execution states.

A persistent state is a name of the contract followed by its arguments.

In the simple case, when the source code says
```
contract A ()
```
the persistent state can be simply `A()`.


In a more complicated example, when the source code says
```
contract B (uint totalSupply)
```
the program's state can be `B(0)`, `B(3000)` or `B(<any uint256 value>)`.  However, `B()` is not a program state.  `B(1,2)` is not a persistent state either.

#### An example of Persistent States

Let's consider one Bamboo source code, which contains three contracts:
```
contract A() {
    default {
        return then become B();
    }
}
contract B() {
    default {
        return then become C();
    }
}
contract C() {
    default {
        selfdestruct(this);
    }
}
```

When this souce code is compiled and deployed, we get a program whose state consists of a persistent state and no pending execution states.  The initial persistent state is `A()`.  The initial `killed` flag is `false`.

When the world calls the program, the program returns, leaving the program's state `B()`.  This is described in `return then become B()`.

When the world again calls the program, the program returns, leaving the program's state `C()`.  This is described in `return then become C()`.

When the world again calls the program, the program destroys itself.  This is described in `selfdestruct(this)`.  The form `selfdestruct(.)` takes one argument, which specifies the account where the remaining ETH balance goes.  The keyword `this` represents the Ethereum account where the program is deployed.  Bamboo inherits EVM's special behavior when the program's own address is specified as the receiver of the remaining balance.  In that case, the remaining balance disappears.  After selfdestruction, the program's state contains the `killed` flag remains `true`.

### What happens after selfdestruction

After the program destroys itself, if the world calls the program, the program simply returns the empty data  given enough gas.  The program might fail if there are no enough gas.  (TODO: make sure the compiler realizes this behavior.  Issue [#170](https://github.com/pirapira/bamboo/issues/170).)

### What happens the selfdestruction is reverted?

People familiar with EVM semantics might ask what happens when the state changes are reverted.  The Bamboo semantics does not see the state reversion.  From a history in the EVM, you can pick up unreverted executions, and the Bamboo semantics can run there.

## Pending Execution State

As mentioned, a program's state contains a list of pending execution states.  Moreover, after the world makes a move and before the program makes a move, the abstract machine keeps track of the current pending execution state.

A pending execution state contains a evaluation point, a variable environment and an annotating function.  Each component is described below.

### An evaluation point

Any pending execution state contains an evaluation point.  An evaluation point is either a sentence or an expression in the source code.  When identically looking expressions (or sentences) appear in the source code, they are considered different expressions (or sentences) if their locations are different.

A Bamboo source code is a list of contracts.  A contract contains a list of cases.  A list contains a list of sentences.  A sentence contains sentences and/or expressions.  An expression contains sentences and/or expressions.  The current evaluation point is either a sentence or an expression in the source code.  (TODO: there should be a separate document called Bamboo Syntax.)

### A variable environment

Any pending execution state contains a variable environment.  A variable environment is a finite map from identifiers to values.  (TODO: describe identifiers in a separate document Bamboo Syntax).

A value is a sequence of 32 bytes.  When values are interpreted as numbers, they are encoded in big-endian.

The empty variable environment maps no identifiers to values.

### An annotating function

Any pending execution state contains an annotation function.  An annotation function is a finite map from expressions in the source code to values or persistent states.  In other words, given an expression in the source code, an annotation function gives nothing, a value, or a persistent state. When identically looking expressions appear in the source code, they are considered different if their locations are different.

The empty annotating function maps no expressions to values.

## When the World calls the Program

When the world calls the program, the world can specify one of the two kinds of calls: calling the default case or calling a named case.

Anyway, when the world calls the program, the program first looks up the source code for the contract specified in the permanent state.  For example, when the permanent state is `A()`, the program tries to find a contract called `A` with zero arguments in the source code.  If such a contract is not found in the source code, the Bamboo compiler is broken.  If multiple such contracts are found in the compiler, the Bamboo compiler is also broken.

Moreover, if the persistent state of the program contains `killed` flag being true, the program returns or fails at random (the EVM knows if there is enough gas to execute `STOP`, but Bamboo semantics is not aware of the EVM's choice).

### The world can call the default case.

If such a contract is found in the source code, and if the world has called the default case, the program then looks for the `default` case in the contract.  If there is none, the program fails.  If there are more than one `default` case, the Bamboo compiler is broken (TODO: make sure that the compiler refused multiple `default` cases: issue [#171](https://github.com/pirapira/bamboo/issues/171)).  If there is one such `default` case, the `default` case contains a list of sentences.  If the list of sentences is empty, the Bamboo compiler is broken.  Otherwise, the evaluation point is set to the first sentence in the list of sentences.

The combination of the evaluation point, the empty variable environment, and the empty annotating function is kept as the current pending execution.

### The world can call a named case

When the world calls a named case, the world needs to specify an identifier (name of the case), a list of ABI types and a list of values.

Bamboo recognizes the following ABI types:
* uint256
* uint8
* bytes32
* address
* bool
These types are just meaningless symbols.

A value is a sequence of 32 bytes.

When the world calls a named case, the program looks up the source code for the contract specified in the permanent state.  If the contract is not found, the Bamboo compiler is broken.  If multiple contracts are found, the Bamboo compiler is also broken.

The program searches the contract in the source code for a case that matches the world's call.  For instance, when the world specified a named case `f(uint256, bool, address)`, the case `case (f (uint256 x, bool y, address z))` is a matching case.  When there are no cases that match the world's call, the program proceeds as if the world specified the default case.  If there are multiple cases that match the world's call, the Bamboo compiler is broken.

The case contains a list of sentences.  If the list is empty, the Bamboo compiler is broken.  Otherwise, the evaluation point is set to the first sentence in the list of sentences.

If the world's call contains more values than ABI types, the program fails.  If the world's call contains fewer values then ABI types, the program also fails.  Otherwise, a variable environment is formed in a straightforward way (TODO: explain).

The combination of the evaluation point, the variable environment, and the empty annotating function is kept as the current pending execution.

## When there is a current pending execution

When there is a current pending execution, there is always a possibility that the program fails immediately.  This is because of the underlying EVM mechanism can run out of gas, but Bamboo is not aware of this mechanism.  From this document, the program just fails at any moment randomly.

Moreover, when the evaluation point in the current pending execution is `abort;` sentence, the program certainly fails.

Otherwise, when the evaluation point in the current pending execution is `return then become X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`.  When the annotation function maps `X` to a persistent state, the program returns and leave the persistent state specified by the annotation function.

Otherwise, when the evaluation point in the current pending execution is `return e then become X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`. When the annotation function maps `X` to a persistent state, but the annotation function does not map `e` to anything, the evaluation point is set to `e`. When the annotation function maps `X` to a persistent state and the annotation function maps `e` to a value, the program returns the value associated with `e` and leaves the persistent state associated with `X`.  When the annotation function does anything else, the Bamboo compiler is broken.

Otherwise, when the evaluation point in the current pending execution is `void = X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`.  Otherwise, the evaluation point advances from the sentence (TODO: define how an evaluation point advances from a sentence in the source code).

Otherwise, when the evaluation point in the current pending execution is `selfdestruct(X);` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`. When the annotating function maps `X` to a value, the program destroys itself, specifying the value as the inheritor.  The current pending execution is discarded.  The `killed` flag is set in the persistent state.

Otherwise, when the evaluation point in the currrent pending execution is an identifier occurrence, the program looks up the variable environment. If the variable environment does not map the identifier occurrence to a value, the Bamboo compiler is broken.  Otherwise, when the variable environment maps the identifier occurrence to a value, the annotating function now associates the identifier occurrence with the value.  The evaluation point is set to the surrounding expression or sentence.

(WARNING: maybe polish the existing contents before adding more syntactic elements listed below.)

(TODO: add other kinds of expressions)

(TODO: add `if`)

(TODO: add `void = e;`)

(TODO: add `uint x = e;`)

(TODO: add mapping assignments)

(TODO: add `LOG`)
