ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -use-menhir parse/parser_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package cryptokit -package batteries -package hex -use-menhir ast/ast_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir codegen/codegen_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir codegen/codegen_test2.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir basics/hex_test.native && \
ocamlbuild -Is basics,ast,parse,lib,codegen -package batteries -package cryptokit -package hex -package rope -use-menhir lib/lib_test.native && \
./codegen_test.native || exit 1
./lib_test.native || exit 1
./hex_test.native || exit 1
for f in `ls parse/examples/*.bbo ../sketch/*.bbo`
do
  echo "trying" $f
  cat $f | ./parser_test.native || \
  exit 1
  cat $f | ./ast_test.native || \
  exit 1
  cat $f | ./codegen_test2.native || \
  exit 1
done
for f in `ls parse/negative_examples/*.bbo`
do
  echo "trying" $f
  if cat $f | ./codegen_test2.native
  then
    exit 1
  fi
done
echo "what should succeed has succeeded; what should fail has failed."
