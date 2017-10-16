# Bamboo Semantics Sketch

This document describes the semantics of the Bamboo language.  This is an informal sketch written as a preparation for the coming Coq or K code.

## Overview

### Arena of the Game

A program written in Bamboo, once deployed, participates in a game between the program and the world.  In this game, the world makes the first move, the program makes the second move, and so on alternatively.  Neither the world or the program makes two moves in a row.  This document aims at  defining the choice of the program's move, given a sequence of earlier moves.

The world can make the following three kinds of moves:
* calling the program
* returning into the program
* failing into the program

The program can make the following five kinds of moves:
* calling an account
* deploying code
* returning
* failing
* destroying itself

A sequence of moves can be equipped with a number called the nesting.

The empty sequence is associated with zero-nesting.  Initially, when the program is deployed, the program is not running (or running with zero-nesting).  When the program is not running, the world can only call the program.

When the world calls the program, the nesting increases by one.  When the program returns, fails, or destroys itself, the nesting decreases by one.

From the above sentences, you should be able to prove that the nesting never goes below zero.

### Bamboo's Strategy

In general, a program needs to decide on a move after any sequence of moves that ends with the world's move.  However, Bamboo does not remember the whole sequence of moves, but just remembers the "program's state".  The Bamboo semantics computes the program's next move only using the stored program's state and the previous move made by the world.  In addition to the program's move, the Bamboo semantics specifies the program's new altered state for later use.

### Bamboo's Program State

The program's state has three components: a persistent state, a `killed` flag, and pending execution states.  When the game is `n`-running, the program's state contains `n` pending execution states.

A persistent state is either the special aborting element or a name of the contract followed by its arguments.

In the simple case, when the source code says
```
contract A ()
```
the persistent state can be simply `A()`.


In a more complicated example, when the source code says
```
contract B (uint totalSupply)
```
the program's state can be `B(0)`, `B(3000)` or `B(<any uint256 value>)`.  However, `B()` is not a program state.  `B(1,2)` is not a persistent state either because the number of arguments do not match the number of parameters in the source code.

### An example of Persistent States

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

When this source code is compiled and deployed, we get a program whose state consists of a persistent state and no pending execution states.  The initial persistent state is `A()`.  The initial `killed` flag is `false`.

When the world calls the program, the program might return, leaving the persistent state `B()`; intuitively, that's the meaning of `return then become B()`.  Otherwise, there is a possibility that the program fails, leaving the persistent state as `A()` (this possibility comes from EVM's out-of-gas).

When the world calls the program again, the program might return, leaving the persistent state `C()`; intuitively, that's the meaning of `return then become C()`. Otherwise, there is a possibility that the program fails, leaving the persistent state as `B()` (this possibility comes from EVM's out-of-gas).

When the world calls the program again, the program might destroy itself.  This is described in `selfdestruct(this)`.  The form `selfdestruct(.)` takes one argument, which specifies the account where the remaining ETH balance goes.  The keyword `this` represents the Ethereum account where the program is deployed.  Bamboo inherits EVM's special behavior when the program's own address is specified as the receiver of the remaining balance.  In that case, the remaining balance disappears.  After selfdestruction, the program's state contains the `killed` flag `true`.  Again, there is a possibility that the program fails, leaving the persistent state as `C()` and the `killed` flag `false` (this possibility comes from EVM's out-of-gas).

### What happens after selfdestruction

After the program destroys itself, if the world calls the program, the program simply returns the empty data given enough gas.  The program might fail if there is not enough gas.  (TODO: make sure the compiler realizes this behavior.  Issue [#170](https://github.com/pirapira/bamboo/issues/170).)

### What happens if the selfdestruction is reverted?

People familiar with EVM semantics might ask what happens when state changes are reverted.  The Bamboo semantics do not see the state reversion.  From a history in the EVM, you can pick up unreverted executions, and the Bamboo semantics can run there.

(TODO: maybe I should not mention the possibilities that the program fails because of out-of-gas in EVM?)

## Pending Execution State

As mentioned, a program's state contains a list of pending execution states.  Moreover, after the world makes a move and before the program makes a move, the abstract machine keeps track of the current pending execution state.

A pending execution state contains an evaluation point, a variable environment and an annotating function.  Each component is described below.

### An evaluation point

Any pending execution state contains an evaluation point.  An evaluation point is either a sentence or an expression in the source code.  When identical expressions (resp. sentences) appear in the source code, they are considered different expressions (resp. sentences) if their locations are different.

A Bamboo source code is a list of contracts.  A contract contains a list of cases.  A case contains a list of sentences.  A sentence contains sentences and/or expressions.  An expression contains sentences and/or expressions.  The current evaluation point is either a sentence or an expression in the source code.  (TODO: there should be a separate document called Bamboo Syntax.)

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

Moreover, if the persistent state of the program contains `killed` flag being true, the program returns or fails at random (the EVM knows if there is enough gas to execute `STOP`, but the Bamboo semantics is not aware of the EVM's choice).

### The world can call the default case

If such a contract is found in the source code, and if the world has called the default case, the program then looks for the `default` case in the contract.  If there is none, the program fails.  If there are more than one `default` case, the Bamboo compiler is broken.  If there is one such `default` case, the `default` case contains a list of sentences.  If the list of sentences is empty, the Bamboo compiler is broken.  Otherwise, the evaluation point is set to the first sentence in the list of sentences.

The combination of the evaluation point, the empty variable environment, and the empty annotating function is kept as the current pending execution state.

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

When the world calls a named case, the program looks up the source code for the contract specified in the permanent state.  If the contract is not found, the Bamboo compiler is broken.  If multiple contracts are found matching the permanent state, the Bamboo compiler is also broken.

The program searches the contract in the source code for a case that matches the world's call.  For instance, when the world specified a named case `f(uint256, bool, address)`, the case `case (f (uint256 x, bool y, address z))` is a matching case.  When there are no cases that match the world's call, the program proceeds as if the world specified the default case.  If there are multiple cases that match the world's call, the Bamboo compiler is broken.

The case contains a list of sentences.  If the list is empty, the Bamboo compiler is broken.  Otherwise, the evaluation point is set to the first sentence in the list of sentences.  To clarify the first-last direction, the first sentence is the closest to the case's header.

If the world's call contains more values than ABI types, the program fails.  If the world's call contains fewer values then ABI types, the program also fails.  Otherwise, a variable environment is formed in a straightforward way (TODO: explain).

The combination of the evaluation point, the variable environment, and the empty annotating function is kept as the current pending execution state.

## When there is a current pending execution state

When there is a current pending execution state, there is always a possibility that the program fails immediately.  This is because of the underlying EVM mechanism can run out of gas, but Bamboo is not aware of this mechanism.  From this document's view, the program just fails at any moment randomly.

Moreover, when the evaluation point in the current pending execution state is an `abort;` sentence, the program certainly fails.

Otherwise, when the evaluation point in the current pending execution state is a `return then become X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`.  When the annotation function maps `X` to a persistent state, the program returns and leaves the persistent state specified by the annotation function.

Otherwise, when the evaluation point in the current pending execution state is a `return e then become X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`. When the annotation function maps `X` to a persistent state, but the annotation function does not map `e` to anything, the evaluation point is set to `e`. When the annotation function maps `X` to a persistent state and the annotation function maps `e` to a value, the program returns the value associated with `e` and leaves the persistent state associated with `X`.  When the annotation function does anything else, the Bamboo compiler is broken.

Otherwise, when the evaluation point in the current pending execution state is a `void = X;` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`.  Otherwise, the evaluation point advances from the sentence (see below for how an evaluation point advances from a sentence in the source code).

Otherwise, when the evaluation point in the current pending execution state is a `TYPE V = X` where `TYPE` is a name of a type, `V` is an identifier and `X` is an expression, if the annotating function does not map `X` to anything, the evaluation point is set to `X`.  Otherwise, if the annotating function maps `X` to a value, the variable environment is updated to map `V` to the value, and the evaluation point advances from this sentence (see below for  what it is that the evaluation point advances).

Otherwise, when the evaluation point in the current pending execution state is an `if (C) then B0 else B1` sentence, where `C` is an expression, `B0` is a block and `B1` is another block, the evaluation point is set to `C` if the annotating function does not map `C` to anything.  Otherwise, when the annotation function maps `C` to zero, the evaluation point advances into `B1` (see below for what it is that the evaluation point advances into a block).  Even otherwise, when the annotation function maps `C` to a non-zero value, the evaluation point advances into `B0`.  When the annotation function maps `C` to something else, the Bamboo compiler is broken.

Otherwise, when the evaluation point in the current pending execution state is a `log E(e0, e1, ..., en)` sentence, if the annotation function maps any `ek` to nothing, the last such argument becomes the evaluation point.  Otherwise, the evaluation point moves advances from this sentence (see below for what it is for an evaluation point to advance).

Otherwise, when the evaluation point in the current pending execution state is a `selfdestruct(X);` sentence, if the annotating function does not map `X` to anything, the evaluation point is set to `X`. When the annotating function maps `X` to a value, the program destroys itself, specifying the value as the inheritor.  The current pending execution state is discarded.  The `killed` flag is set in the persistent state.  (When the program has been called from a Bamboo program, the world then returns into that Bamboo program, not failing into it.)

Otherwise, when the evaluation point in the current pending execution state is an identifier occurrence, the program looks up the variable environment. If the variable environment does not map the identifier occurrence to a value, the Bamboo compiler is broken.  Otherwise, when the variable environment maps the identifier occurrence to a value, the annotating function now associates the identifier occurrence with the value.  The evaluation point is set to the surrounding expression or sentence.

Otherwise, when the evaluation point in the current pending execution state is a call `C.m(E1, E2, ...,E_n) reentrance { abort; }`, if the annotating function does not map `C` to anything, the evaluation point is set to `C`.  Otherwise, if the annotation function maps any of `E_k` to nothing, the evaluation point is set to the last such argument.  Otherwise, the program calls an account of address, specified by the annotation of `C`.  The call is on a named case `m` (TODO: for completing this clause, we need some information about the types of arguments of `m`.  We need some information in the persistent state), together with annotations of `E1`, ... `E_n`.  The program's state should now contain the current pending execution state as the last element in the list of pending execution states.  Moreover, the persistent state in the program's state is now the aborting element.

Otherwise, when the evaluation point in the current pending execution state is a deployment `deploy C(E1, E2, E_n) reentrance { abort; }`, if the annotation function maps any of `E_k` to nothing, the evaluation point is set to the last such argument.  Otherwise, the program deploys the contract `C` with a packing of annotations of `E_k`s.  If the contract `C` does not appear in the source code, the Bamboo compiler is broken.  The program's state should now contain the current pending execution state as the last element in the list of pending execution states.  Moreover, the persistent state in the program's state is now the aborting element.

## How to advance an evaluation point

When an evaluation point advances from a sentence, if the sentence belongs to a case's body, and there is a next sentence, the next sentence becomes the evaluation point.  Otherwise, if the sentence belongs to a case's body but there is no next sentence, the Bamboo compiler has an error. Otherwise, when the sentence belongs to a block, and there is a next sentence, the next sentence becomes the evaluation point.  Otherwise, when the sentence belongs to a block and there is no next sentence, the evaluation point advances from the sentence containing the block.  Otherwise, when the sentence belongs to a sentence, the evaluation point advances from the containing sentence.

## When the World returns into the Program

When the world returns into the program but the program's state does not contain any pending execution state, something is very wrong.  Otherwise, the program finds in its state the last element in the list of pending execution states.  This element is removed from the program's state and becomes the current pending execution state.  The execution continues according to the execution point in the current pending execution state.

## When the World fails into the Program

The program fails as well.

## Adding Mappings

Sometimes, a contract contains a mapping.  For example, when a contract in the source code looks like
```
A(address => uint256 balances) { ... }
```
The permanent state associates a value for `balances`.  Moreover, the permanent state contains a grand mapping that takes two values and return a value.  This grand mapping `M` is common to all mappings in the permanent state.  When `balances[3]` is looked up, actually, `M(<<balances>>, 3)` is looked up (where `<<balances>>` is the value that he permanent state associates to `balances`).  When a program is deployed, the grand mapping in the permanent state maps everything to zero.  Moreover, the permanent state contains a value called the array seed.

When the program is deployed, the initial permanent state associates `balances` to one, and the array seed is two.  In general, when a contract contains `n` mappings, the initial permanent state associates these mappings to `1`, `2`, ..., `n`.  Moreover, the initial permanent state has the array seed `n + 1`.

When the evaluation point is an assignment to a mapping `m[idx0][idx1]...[idx_k] = V`, the program looks up the annotating function for `m[idx0][idx1]...[idx_k - 1]`.  If the annotating function does not map this part to anything, `m[idx0][idx1]...[idx_k - 1]` becomes the evaluation point.  Otherwise, if the annotating function does not map `idx_k` to anything, `idx_k` becomes the evaluation point.  Otherwise, if the annotating function does not map `V` to anything, `V` becomes the evaluation point.  Otherwise, when all of these are mapped to some value, the grand mapping is updated to map the evaluation of `m[idx0]...[idx_k - 1]` and `idx_k` into the evaluation of `V`, and the evaluation point advances from the assignment sentence.

When the evaluation point is a mapping lookup `m[idx]`, the program looks up the annotating function for `m`. If the annotating function does not map `m` to anything, `m` becomes the evaluation point.
Otherwise, if the annotating function maps `m` to zero, the program assigns a seed to `m` (see below for what it is for a program to assign a seed to `m`).
Otherwise, if the annotating function does not map `idx` to anything, the evaluation point becomes `idx`.
Otherwise, the annotating function is updated to map `m[idx]` to `M(<<m>>, <<idx>>)` where `<<m>>` and `<<idx>>` are the values that the annotation function returns for `m` and `idx`, and the evaluation point is set to the surrounding expression or sentence.

When the program assigns a new array seed to `m[idx]`, the grand mapping function is updated so that `M(<<m>>, <<idx>>)` is the array seed, where `<<m>>` and `<<idx>>` represents the values that the annotation function maps `m` and `idx` into.  Then, the array seed is incremented.  When the annotation function does not map `m` or `idx` to any value, the Bamboo compiler is broken.
