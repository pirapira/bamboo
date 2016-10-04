let case0 = ("pay(address)", "0c11dedd")

let _ =
  let () = Printf.printf "case0 %s %s\n" (Ethereum.keccak_signature (fst case0)) (snd case0) in
  let () = assert (Ethereum.keccak_signature (fst case0) = (snd case0)) in
  Printf.printf "lib_test: success\n"
