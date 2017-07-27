.PHONY: test bbo end-to-end clean

bbo:
	ocaml setup.ml -configure
	ocaml setup.ml -build

end-to-end:
	ocamlbuild -use-ocamlfind -Is src/basics,src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -package rpclib -package rpclib.unix -package unix -package rpclib.json -package ppx_deriving -package ppx_deriving_rpc -package hex -use-menhir src/exec/end-to-end.native

test:
	(cd src; sh ./run_tests.sh)

clean:
	rm -rf _build
