# Bamboo: a language for morphing smart contracts

[![Join the chat at https://gitter.im/bbo-dev/Lobby](https://badges.gitter.im/bbo-dev/Lobby.svg)](https://gitter.im/bbo-dev/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## What

Bamboo is a programming language for Ethereum contracts.
Bamboo makes state transition explicit and avoids reentrance problems by default.
See [manifest](doc/manifest.md) for the motivation.

## Compiler in development

The Bamboo compiler sometimes produces bytecode, which needs to be tested.

As preparattion,
* install [opam](http://opam.ocaml.org/doc/Install.html)
* and then use `opam install menhir batteries rope` to install some of the dependencies.
* checkout [cryptokit](https://github.com/xavierleroy/cryptokit/) and follow the build&install instruction (the version available in `opam` does not work yet)

Then,
```
make
```
builds a compiler `bbo.native`.

```
./bbo.native < src/parse/examples/006auction_first_case.bbo
```
produces a bytecode.

You can continue [testing the bytecode](doc/testing-bytecode.md).

## How to Contribute

* notice problems and point them out. [create issues](https://github.com/pirapira/bamboo/issues/new).
* write new Bamboo code and test the compiler.
* join the [Gitter channel](https://gitter.im/bbo-dev/Lobby).
* spread a rumor to your friends who are into programming languages.
