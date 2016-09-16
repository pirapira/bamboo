ocamlbuild -Is ast,parse,lib,codegen -use-menhir parse/parser_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -use-menhir ast/ast_test.native && \
ocamlbuild -Is ast,parse,lib,codegen -package batteries -use-menhir codegen/codegen_test.native && \
./codegen_test.native || \
exit 1
for f in `ls parse/examples/*.sol`
do
  echo "trying" $f
  cat $f | ./parser_test.native || \
  exit 1
  cat $f | ./ast_test.native || \
  exit 1
done
