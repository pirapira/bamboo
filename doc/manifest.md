# Bamboo Manifest

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
contract CrowdFund() {
    case(void toBeCalledDuringFunding()) {
        // ...
    }

    case(void toBeCalledAfterFailure()) {
        // ...
    }

    case(void toBeCalledAfterSuccess()) {
        // ...
    }

    case(void notSureWhatThisDoes()) {
        // ...
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

The solution is polymorphic contracts.  According to the stages,
a contract changes its signature.

```
contract Funding() {
    case(bool toBeCalledDuringFunding()) {
        // something something
        return true then become Funding();
    }
    case(bool endFunding()) {
        if (something)
            return (true) then become FundingSuccess();
        else
            return (false) then become FundingFailure();
    }
}

contract FundingSuccess() {
    case(void toBeCalledAfterSuccess()) {
        // something
    }
}

contract FundingFailure() {
    case(void toBeCalledAfterFailure()) {
        // something
    }
}
```

All of these contracts `Funding`, `FundingSuccess` and `FundingFailure` occupies the same address.  The initial contract `Funding` becomes `FundingSuccess` or `FundingFailure`.

Where has gone the `notSureWhatThisDoes()` function in the previous
example?  It's not there because, well, I am not sure where it goes.
The new style forces temporal organization of the code lines.

### Syntax

After some polishing I ended up to something like [this](../src/parse/examples/00d_auction.bbo).
There is some influence from Erlang.

### Not to have

This language is designed to facilliate a particular style.
So the language will not support features like:
* loop constructs (`for`, `while`, ...).  Due to the constant block gas limit, loops should be avoided and each iteration should be done in separate transactions.
* assignments into storage variables, except array elements.  Instead of assigning a new value to a storage variable, the new value can be given as an argument in the continaution (e.g. `return () then auction(new_highest_bidder, ...)`
