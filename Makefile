.PHONY: test bbo end-to-end clean

bbo:
	ocamlbuild -use-ocamlfind -Is src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -package hex -use-menhir src/exec/bbo.native

end-to-end:
	ocamlbuild -use-ocamlfind -Is src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -package rpclib -package rpclib.unix -package unix -package rpclib.json -package ppx_deriving -package ppx_deriving_rpc -package hex -use-menhir src/exec/end-to-end.native

test:
	(cd src; sh ./run_tests.sh)

clean:
	rm -rf _build
