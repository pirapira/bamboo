let case0 = ("pay(address)", "0c11dedd")

let case1_case : Syntax.usual_case_header =
  Syntax.(
  { case_return_typ = []
  ; case_name = "pay"
  ; case_arguments = [{arg_typ = AddressType; arg_ident = "addr"; arg_location = None}]
  })

let case2_case : Syntax.usual_case_header =
  Syntax.(
    { case_return_typ = [Uint256Type]
    ; case_name = "f"
    ; case_arguments = [{arg_typ = Uint256Type; arg_ident = "x"; arg_location = None}]
    })

let case2_hash :string = "b3de648b"

let _ =
  let () = Printf.printf "case0 %s %s\n" (Ethereum.keccak_signature (fst case0)) (snd case0) in
  let () = assert (Ethereum.keccak_signature (fst case0) = (snd case0)) in
  let () = assert (Ethereum.case_header_signature_hash case1_case = (snd case0)) in
  let () = assert ((Ethereum.case_header_signature_hash case2_case) = case2_hash) in
  let () = assert (Big_int.eq_big_int (Ethereum.hex_to_big_int "01") Big_int.unit_big_int) in
  let () = assert (Ethereum.string_keccak "" = Ethereum.hex_keccak "0x") in
  let () = assert (Ethereum.string_keccak "a" = Ethereum.hex_keccak "0x61") in
  let () = assert (Ethereum.string_keccak "ab" = Ethereum.hex_keccak "6162") in
  Printf.printf "lib_test: success\n"
