# Bamboo: a language for morphing smart contracts

[![Join the chat at https://gitter.im/bbo-dev/Lobby](https://badges.gitter.im/bbo-dev/Lobby.svg)](https://gitter.im/bbo-dev/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.org/pirapira/bamboo.svg?branch=master)](https://travis-ci.org/pirapira/bamboo)

Bamboo is a programming language for Ethereum contracts.
Bamboo makes state transition explicit and avoids reentrance problems by default.
See [manifest](doc/manifest.md) for the motivation, or [tutorial](doc/tutorial.md) if you want to deploy something first, or [semantics](doc/semantics.md) if you need something resembling a definition.

## Example Bamboo Code

* [A payment channel](./src/parse/examples/00h_payment_channel.bbo)
* [An ERC20 contract](./src/parse/examples/01b_erc20better.bbo)
* [A vault](https://medium.com/@pirapira/implementing-a-vault-in-bamboo-9c08241b6755)

## Compiler

The Bamboo compiler sometimes produces bytecode, which needs to be tested.

As preparation,
* install [opam](http://opam.ocaml.org/doc/Install.html) with OCaml 4.04.1
* `opam install bamboo`
should install `bamboo`.

When you check out this repository,
```
bamboo < src/parse/examples/006auction_first_case.bbo
```
produces a bytecode. Do not trust the output as the compiler still contains bugs probably.

```
bamboo --abi < src/parse/examples/006auction_first_case.bbo
```
prints ABI.
```
[{"type": "constructor", "inputs":[{"name": "_beneficiary", "type": "address"},{"name": "_bidding_time", "type": "uint256"},{"name": "_highest_bid", "type": "uint256"}], "name": "auction", "outputs":[], "payable": true},{"type":"fallback","inputs": [],"outputs": [],"payable": true}]
```

## Developing Bamboo

To try Bamboo in your local environment, run `make dep` from the project folder. That should install all dependencies.
Once the installation process is done, run `eval $(opam config env)` and then you can build all targets using `make`, and run the tests with `make test`.

When you modify the OCaml source of Bamboo, you can try your version by
```
$ make
$ ./lib/bs/native/bamboo.native < src/parse/examples/006auction_first_case.bbo
```

## How to Contribute

* notice problems and point them out. [create issues](https://github.com/pirapira/bamboo/issues/new).
* test the bytecode like [this](doc/tutorial.md), but using other examples.  You might find bugs in the compiler.
* write new Bamboo code and test the compiler.
* join the [Gitter channel](https://gitter.im/bbo-dev/Lobby).
* spread a rumor to your friends who are into programming languages.

## Related Work

### Linden Scripting Language

[Linden Scripting Language](http://wiki.secondlife.com/wiki/Getting_started_with_LSL#Introducing_States_and_Events) has similar organization of code according to `state`s.
