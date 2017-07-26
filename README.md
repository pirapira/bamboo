# Bamboo: a language for morphing smart contracts

[![Join the chat at https://gitter.im/bbo-dev/Lobby](https://badges.gitter.im/bbo-dev/Lobby.svg)](https://gitter.im/bbo-dev/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/pirapira/bamboo.svg?branch=master)](https://travis-ci.org/pirapira/bamboo)

Bamboo is a programming language for Ethereum contracts.
Bamboo makes state transition explicit and avoids reentrance problems by default.
See [manifest](doc/manifest.md) for the motivation.

## Example Bamboo Codes

* [A payment channel](./src/parse/examples/00h_payment_channel.bbo)
* [An ERC20 contract](./src/parse/examples/01b_erc20better.bbo)

## Compiler in development

The Bamboo compiler sometimes produces bytecode, which needs to be tested.

As preparattion,
* install [opam](http://opam.ocaml.org/doc/Install.html) with OCaml 4.04.1
* and then use `opam install zarith ocamlfind menhir batteries rope hex cryptokit` to install some of the dependencies.

Then,
```
make
```
builds a compiler `bbo.native`.

```
./bbo.native < src/parse/examples/006auction_first_case.bbo
```
produces a bytecode.

```
./bbo.native --abi < src/parse/examples/006auction_first_case.bbo
```
prints ABI.
```
[{"type": "constructor", "inputs":[{"name": "_beneficiary", "type": "address"},{"name": "_bidding_time", "type": "uint256"},{"name": "_highest_bid", "type": "uint256"}], "name": "auction", "outputs":[], "payable": true},{"type":"fallback","inputs": [],"outputs": [],"payable": true}]
```

You can continue [testing the bytecode](doc/testing-bytecode.md).

## How to Contribute

* notice problems and point them out. [create issues](https://github.com/pirapira/bamboo/issues/new).
* test the bytecode like [this](doc/testing-bytecode.md), but using other examples.  You might find bugs in the compiler.
* write new Bamboo code and test the compiler.
* join the [Gitter channel](https://gitter.im/bbo-dev/Lobby).
* spread a rumor to your friends who are into programming languages.

## FAQ

### Unbound value Hash.keccak

```
File "src/lib/ethereum.ml", line 98, characters 17-28:
Error: Unbound value Hash.keccak
```

*Answer*: probably you have cryptokit installed from opam.
You need to install cryptokit from master branch of https://github.com/xavierleroy/cryptokit
because my PR was recently merged into this project.
After cryptokit 1.12 (or any new version) is released, you will be able to use cryptokit from opam, I believe.

## Related Work

### Linden Scripting Language

[Linden Scripting Language](http://wiki.secondlife.com/wiki/Getting_started_with_LSL#Introducing_States_and_Events) has similar organization of code according to `state`s.
