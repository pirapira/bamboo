ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -use-menhir parse/parser_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package cryptokit -package batteries -package hex -use-menhir ast/ast_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir codegen/codegen_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir codegen/codegen_test2.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir basics/hex_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir lib/lib_test.native && \
./codegen_test.native || exit 1
./lib_test.native || exit 1
./hex_test.native || exit 1
for f in `find parse -type f -name "*tuple*"`
do
  echo "trying" $f
  cat $f | ./parser_test.native || \
  exit 1
  cat $f | ./ast_test.native || \
  exit 1
  cat $f | ./codegen_test2.native || \
  exit 1
done
echo "[SUCCESS] Tuple tests are done."
