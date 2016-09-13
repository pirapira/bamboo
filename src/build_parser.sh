ocamlbuild -I ast -use-menhir parse/parser_test.native && \
for f in `ls parse/examples`
do
  echo "trying" $f && \
  cat parse/examples/$f | ./parser_test.native || \
  exit 1
done
