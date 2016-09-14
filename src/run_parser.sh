ocamlbuild -I ast -use-menhir parse/parser_test.native && \
for f in `ls parse/examples/*.sol`
do
  echo "trying" $f && \
  cat $f | ./parser_test.native || \
  exit 1
done
