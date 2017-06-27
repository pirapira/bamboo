.PHONY: test bbo

bbo:
	ocamlbuild -Is src/ast,src/parse,src/lib,src/codegen -package batteries -package cryptokit -package rope -use-menhir src/exec/bbo.native

test:
	(cd src; sh ./run_tests.sh)
