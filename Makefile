.PHONY: test bbo end-to-end

bbo:
	ocamlbuild -use-ocamlfind -Is src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -use-menhir src/exec/bbo.native

end-to-end:
	ocamlbuild -use-ocamlfind -Is src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -package rpclib -package rpclib.unix -package unix -package rpclib.json -package ppx_deriving -package ppx_deriving_rpc -use-menhir src/exec/end-to-end.native

test:
	(cd src; sh ./run_tests.sh)
