ocamlbuild -I ast -use-menhir parse/parser_test.native && \
echo "trying nil.sol" && \
cat parse/examples/nil.sol | ./parser_test.native && \
echo "trying empty.sol" && \
cat parse/examples/empty.sol | ./parser_test.native
