# Jaculus: an embryonic thought on a smart contract language

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
temporal order is ambiguous. An opaque function can be called
at any moment by default.  A closer look is necessary for every
interface function before a reader or the machine can enumerate
the possible orderings of events.

## Solution

We can solve the problem because our programming language runs from
top to bottom.

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

### Implementation

What would be difficult to implement?  Maybe not much: one word in
the storage to keep track where we are in the program, and some
dataflow analysis to decide which variable should live in the storage.
The ABI should be the common one while the method names should be
piped into the program in a nice syntax.

### Name

[Jaculus](https://en.wikipedia.org/wiki/Jaculus).
