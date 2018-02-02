npm run build
lib_path="../lib/bs/native/"
$lib_path"codegen_test.native" || exit 1
$lib_path"lib_test.native" || exit 1
$lib_path"hex_test.native" || exit 1
for f in `ls parse/examples/*.bbo ../sketch/*.bbo`
do
  echo "trying" $f
  cat $f | $lib_path"parser_test.native" || \
  exit 1
  cat $f | $lib_path"ast_test.native" || \
  exit 1
  cat $f | $lib_path"codegen_test2.native" || \
  exit 1
  cat $f | $lib_path"bamboo.native" --abi | jq || \
  exit 1
done
for f in `ls parse/negative_examples/*.bbo`
do
  echo "trying" $f
  if cat $f | $lib_path"codegen_test2.native"
  then
    exit 1
  fi
done
echo "what should succeed has succeeded; what should fail has failed."
