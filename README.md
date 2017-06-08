# Bamboo: an embryonic smart contract language

## Problem

Smart contracts should reduce surprises.
The code should reveal what can happen in which order, and the same
ordering must be enforced mechanically.  This is not done in the usual
way of writing smart contracts where a smart contract is described as
several interface functions.

In the following example, the names of functions suggest the timing of
the calls, but this ordering can only be enforced by careful timestamp
checking or global state tracking in the body of the functions.
```
contract CrowdFund {
	function toBeCalledDuringFunding() {
		...
	}
	function toBeCalledAfterFailure() {
		...
	}
	function toBeCalledAfterSuccess() {
		...
	}
	function notSureWhatThisDoes() {
		...
	}
}
```
To make my point clearer, I added the last function
`notSureWhatThisDoes()`.  Whenever such a function exists the
temporal order is ambiguous. An interface function can be called
at any moment by default.  A closer look is necessary for every
interface function before a reader or the machine can enumerate
the possible orderings of events.

## Solution

The solution is a programming language that runs from top to bottom.

```
contract CrowdFund {
	while(now < deadline) {
		call = sleep_till_called();
		// toBeCalledDuringFunding
		...
	}
	while(true) {
		if(success) {
			call = sleep_till_called();
			// toBeCalledAfterSuccess
			...
		}
		else {
			call = sleep_till_called();
			// toBeCalledAfterFailure
			...
		}
	}
}
```
Here I used common syntax so that it's clear to people and the
(not-yet implemented) machine what can happen in which order.
Where has gone the `notSureWhatThisDoes()` function in the previous
example?  It's not there because, well, I am not sure where it goes.
The new style forces temporal organization of the code lines.

### Strategy Taken

The trick here is to enlarge the duration of program execution.  In the
first example, the program starts when it is called and finishes when
it returns.  In the second example, the program starts when it is
created and finishes when it disappears (if ever).

The other way around, the new programming language must be aware
of the "called until returns" delimitation.  Above it's vaguely
written as `sleep_till_called()`.  Actually there are three different
ways to exit a contract:
* `sleep_after_return(result_of_previous_call)`
* `cancel_current_call()`
* `sleep_after_calling(call_to_other_account)`.

The first `sleep_after_return()` is the most straightforward.  It
returns to the caller and waits to be called again.  Next time the
contract is called, the expression reveals the details of the new
call.  The second `cancel_current_call()` is also easy.  The
expression rewinds all the effects during the current call.  When this
expression is evaluated, the program goes back to where it was when
the call came in.

The third `sleep_after_calling()` is interesting.  When this expression
is evaluated, the contract calls the specified account.  After that,
two possibilities exist.  Either the called account returns or some
account calls into our contract.  In any case, the expression
`sleep_after_calling()` returns, revealing whether the callee has
returned or a reentrancy has happened.

```
sleep_after_calling(account, value, data) with reentrancy(_call) {
	// What should happen when reentered.  For instance
	cancel_current_call();
}
```

### Syntax

After some polishing I ended up to something like this.
There is some influence from Erlang.
```
contract bid
	(address _bidder
	,uint _value
	,auction _auction) // the compiler is aware that an `auction` account can become an `auction_done` account.
{
	case (bool refund())
	{
		if (sender(msg) != _bidder)
			abort;
		if (_auction.bid_is_highest(_value) reentrance { abort; })
			abort;
		selfdestruct(_bidder);
	}
	case (bool pay_beneficiary())
	{
		if (not _auction.bid_is_highest(_value) reentrance { abort; })
			abort;
		address beneficiary = _auction.beneficiary() reentrance { abort; };
		selfdestruct(_beneficiary);
	}
	default
	{
		abort;
	}
}
```

### Compiler in development

Currently the compiler can parse the examples, assign types to expressions, but
the code generation is still in development.

As preparattion,
* install [opam](http://opam.ocaml.org/doc/Install.html)
* and then use `opam install menhir` to install `menhir`.
* `opam install batteries rope`
* checkout [cryptokit](https://github.com/xavierleroy/cryptokit/) and follow the build instruction (the version available in `opam` does not work)

Then,
```
cd src
sh run_tests.sh
```
builds a compiler in development and tests it against the example files
`src/parse/examples/*.sol`

### Implementation

What would be difficult to implement?  Maybe not much: one word in
the storage to keep track where we are in the program, and some
dataflow analysis to decide which variable should live in the storage.
The ABI should be the common one while the method names should be
piped into the program in a nice syntax (something like the pattern
match in Erlang).

I'm thinking about using OCaml, but type-level lists in Haskell might
be convenient for keeping track of the stack elements during EVM code
generation.

### Not to have

This language is designed to facilliate a particular style.
So the language will not support features like:
* loop constructs (`for`, `while`, ...).  Due to the constant block gas limit, loops chould be avoided and each iteration should be done in separate transactions.
* assignments into storage variables, except array elements.  Instead of assigning a new value to a storage variable, the new value can be given as an arument in the continaution (e.g. `return () then auction(new_highest_bidder, ...)`
