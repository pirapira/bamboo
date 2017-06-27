# Bamboo: a language for morphing smart contracts

[![Join the chat at https://gitter.im/bbo-dev/Lobby](https://badges.gitter.im/bbo-dev/Lobby.svg)](https://gitter.im/bbo-dev/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Compiler in development

The Bamboo compiler sometimes produces bytecode, which needs to be tested.

As preparattion,
* install [opam](http://opam.ocaml.org/doc/Install.html)
* and then use `opam install menhir batteries rope` to install some of the dependencies.
* checkout [cryptokit](https://github.com/xavierleroy/cryptokit/) and follow the build instruction (the version available in `opam` does not work yet)

Then,
```
make
```
builds a compiler `bbo.native`.

```
./bbo.native < src/parse/examples/00a_auc_first_cast.bbo
```
produces a bytecode.

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

The solution is polymorphic contracts.  According to the stages,
a contract changes its signature.

```
contract Funding() {
	function toBeCalledDuringFunding() {
		// something something
		return true then Funding();
	}
	function endFunding() {
		if (something)
			return (true) then FundingSuccess();
		else
			return (false) then FundingFailure();
	}
}
contract FundingSuccess() {
	function toBeCalledAfterSuccess() {
		// something
	}
}
contract FundingFailure() {
	function toBeCalledAfterFailure() {
		// something
	}
}
```

All of these contracts `Funding`, `FundingSuccess` and `FundingFailure` occupies the same address.  The initial contract `Funding` becomes `FundingSuccess` or `FundingFailure`.

Where has gone the `notSureWhatThisDoes()` function in the previous
example?  It's not there because, well, I am not sure where it goes.
The new style forces temporal organization of the code lines.

### Syntax

After some polishing I ended up to something like this.
There is some influence from Erlang.
```
contract bid
	(address _bidder
	,uint _value
	,auction _auction)
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
		selfdestruct(beneficiary);
	}
	default
	{
		abort;
	}
}
contract auction
	(address _beneficiary
	,uint _bidding_time
	,bool[address] _bids /// When the contract is created, this must be empty.
	,uint _highest_bid)
{
	case (bool bid())
	{
		if (now(block) > _bidding_time)
			return (false) then auction_done(_beneficiary, _bids, _highest_bid);
		if (value(msg) < _highest_bid)
			abort;
		bid new_bid =
			new bid(sender(msg), value(msg), this) along value(msg)
				reentrance { abort; }; // failure throws.
		_bids[address(new_bid)] = true;
		return (true) then
			auction(_beneficiary, _bidding_time, _bids, value(msg));
	}
	case (bool bid_is_highest(uint _value))
	{
		return (_highest_bid == _value) then
			auction(_beneficiary, _bidding_time, _bids, _highest_bid);
	}
	case (address beneficiary())
	{
		return (_beneficiary) then
			auction(_beneficiary, _bidding_time, _bids, _highest_bid);
	}
	default
	{
		abort; // cancels the call.
	}
}

```

There are other [example contracts that morph into another](src/parse/examples/00d_auction.bbo).

### Not to have

This language is designed to facilliate a particular style.
So the language will not support features like:
* loop constructs (`for`, `while`, ...).  Due to the constant block gas limit, loops chould be avoided and each iteration should be done in separate transactions.
* assignments into storage variables, except array elements.  Instead of assigning a new value to a storage variable, the new value can be given as an arument in the continaution (e.g. `return () then auction(new_highest_bidder, ...)`
