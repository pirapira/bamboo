ocamlbuild -Is ast,parse -use-menhir parse/parser_test.native && \
ocamlbuild -Is ast,parse -use-menhir ast/ast_test.native && \
for f in `ls parse/examples/*.sol`
do
  echo "trying" $f
  cat $f | ./parser_test.native || \
  exit 1
  cat $f | ./ast_test.native || \
  exit 1
done
