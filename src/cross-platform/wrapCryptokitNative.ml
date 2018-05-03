  module Hash = Cryptokit.Hash
  let string_keccak str : string =
    let sha3_256 = Hash.keccak 256 in
    let () = sha3_256#add_string str in
    let ret = sha3_256#result in
    let tr = Cryptokit.Hexa.encode () in
    let () = tr#put_string ret in
    let () = tr#finish in
    let ret = tr#get_string in
    (* need to convert ret into hex *)
    ret

  let strip_0x h =
    if BatString.starts_with h "0x" then
      BatString.tail h 2
    else
      h
  
  let add_hex sha3_256 h =
    let h = strip_0x h in
    let add_byte c =
      sha3_256#add_char c in
    let chars = BatString.explode h in
    let rec work chars =
      match chars with
      | [] -> ()
      | [x] -> failwith "odd-length hex"
      | a :: b :: rest ->
        let () = add_byte (Hex.to_char a b) in
        work rest in
    work chars
  
  let hex_keccak h : string =
    let sha3_256 = Hash.keccak 256 in
    let () = add_hex sha3_256 h in
    let ret = sha3_256#result in
    let tr = Cryptokit.Hexa.encode () in
    let () = tr#put_string ret in
    let () = tr#finish in
    let ret = tr#get_string in
    (* need to convert ret into hex *)
    ret
