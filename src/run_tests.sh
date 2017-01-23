ocamlbuild -Is ast,parse,lib,codegen -package cryptokit -use-menhir parse/parser_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -package cryptokit -package batteries -use-menhir ast/ast_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -package batteries -package cryptokit -package rope -use-menhir codegen/codegen_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -package batteries -package cryptokit -package rope -use-menhir codegen/codegen_test2.native && \
ocamlbuild -Is ast,parse,lib,codegen -package batteries -package cryptokit -package rope -use-menhir codegen/hex_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -package batteries -package cryptokit -package rope -use-menhir lib/lib_test.native && \
./codegen_test.native || exit 1
./lib_test.native || exit 1
./hex_test.native || exit 1
for f in `ls parse/examples/*.sol`
do
  echo "trying" $f
  cat $f | ./parser_test.native || \
  exit 1
  cat $f | ./ast_test.native || \
  exit 1
  cat $f | ./codegen_test2.native || \
  exit 1
done
