ocamlbuild -I ast -use-menhir parse/parser_test.native && \
cat parse/examples/nil.sol | ./parse/parser_test.native && \
cat parse/examples/empty.sol | ./parse/parser_test.native
