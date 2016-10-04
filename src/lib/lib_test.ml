let case0 = ("pay(address)", "0c11dedd")

let case1_case : Syntax.usual_case_header =
  Syntax.(
  { case_return_typ = []
  ; case_name = "pay"
  ; case_arguments = [{arg_typ = AddressType; arg_ident = "addr"}]
  })

let case2_case : Syntax.usual_case_header =
  Syntax.(
    { case_return_typ = [UintType]
    ; case_name = "f"
    ; case_arguments = [{arg_typ = UintType; arg_ident = "x"}]
    })

let case2_hash :string = "b3de648b"

let _ =
  let () = Printf.printf "case0 %s %s\n" (Ethereum.keccak_signature (fst case0)) (snd case0) in
  let () = assert (Ethereum.keccak_signature (fst case0) = (snd case0)) in
  let () = assert (Ethereum.case_header_signature_hash case1_case = (snd case0)) in
  let () = assert ((Ethereum.case_header_signature_hash case2_case) = case2_hash) in
  Printf.printf "lib_test: success\n"
