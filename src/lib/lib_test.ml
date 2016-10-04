let case0 = ("pay(address)", "0c11dedd")

let _ =
  let () = assert (Ethereum.string_keccak (fst case0) = (snd case0)) in
  Printf.printf "lib_test: success\n"
