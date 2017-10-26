(* below is largely based on ocaml-rpc *)

(*
 * Copyright (c) 2006-2009 Citrix Systems Inc.
 * Copyright (c) 2006-2014 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*)

(* Yoichi Hirai: I modified the above-mentinoed code. *)

exception Connection_reset

let lib_version = "0.1.1"

module Utils = struct

  let open_connection_unix_fd filename =
    let s = Unix.socket Unix.PF_UNIX Unix.SOCK_STREAM 0 in
    try
      let addr = Unix.ADDR_UNIX(filename) in
      Unix.connect s addr;
      Printf.eprintf "connected \n%!";
      s
    with e ->
      Printf.eprintf "some problem \n%!";
      Unix.close s;
      raise e

end

type connection =
  | Unix_socket of string

let string_of_call ?(version=Jsonrpc.V1) (call : Rpc.call) =
  let c = call in
  Rpc.(Jsonrpc.
  (let json =
    match version with
    | V1 ->
      Dict [
        "method", String ((c : Rpc.call).name);
        "params", Enum c.params;
        "id", Int (new_id ());
      ]
    | V2 ->
      Dict [
        "jsonrpc", String "2.0";
        "method", String c.name;
        "params", Rpc.Enum c.params;
        "id", Int (new_id ());
      ]
  in
  to_string json))

let string_of_rpc_call (call : Rpc.call) =
  string_of_call ~version:(Jsonrpc.V2) call

let rpc_response_of_fd fd =
  Jsonrpc.response_of_in_channel (Unix.in_channel_of_descr fd)

let send_call ~fd call =
  let body = string_of_rpc_call call in
  let output_string str =
    ignore (Unix.write fd (Bytes.of_string str) 0 (String.length str)) in
  output_string body

let rpc_fd (fd: Unix.file_descr) call =
  try
    send_call ~fd call;
    rpc_response_of_fd fd
  with Unix.Unix_error(Unix.ECONNRESET, _, _) ->
    raise Connection_reset

let with_fd s ~call =
  try
    let result = rpc_fd s call in
    result
  with e ->
    raise e

let do_rpc_unix s call =
  with_fd s ~call


let eth_accounts_call : Rpc.call =
  Rpc.({ name = "eth_accounts"
       ; params = []
       })

(* How to perform a call and expect a return of eth_accounts *)

let filename = "/tmp/test/geth.ipc"

type address = string [@@deriving rpc]

type eth_accounts = address list [@@deriving rpc]

type eth_transaction =
  { from : string
  ; _to : string [@key "to"]
  ; gas : string
  ; value : string
  ; data : string
  ; gasprice : string
  }
  [@@deriving rpc]

let pick_result (j : Rpc.response) =
  let j = Jsonrpc.json_of_response Jsonrpc.V2 j in
  Rpc.
  (match j with
  | Dict x ->
     begin
       try
         List.assoc "result" x
       with Not_found ->
         let () = Printf.eprintf "got response %s\n%!" (Rpc.string_of_rpc j) in
         raise Not_found
     end
  | _ ->
     failwith "unexpected form"
  )

let eth_accounts s : eth_accounts =
  let res : Rpc.response = (do_rpc_unix s eth_accounts_call) in
  let json : Rpc.t = pick_result res in
  let result : eth_accounts = eth_accounts_of_rpc json in
  result

let init_code_dummy = "0x00"

let eth_sendTransaction s (trans : eth_transaction) : address =
  let call : Rpc.call =
    Rpc.({ name = "eth_sendTransaction"
         ; params = [rpc_of_eth_transaction trans]
         }) in
  let res : Rpc.response = do_rpc_unix s call in
  let json : Rpc.t = pick_result res in
  let result = address_of_rpc json in
  result

let eth_call s (trans : eth_transaction) : string =
  let c : Rpc.call =
    Rpc.({ name = "eth_call"
         ; params = [rpc_of_eth_transaction trans; Rpc.rpc_of_string "latest"]
         }) in
  let res : Rpc.response = do_rpc_unix s c in
  let json = pick_result res in
  Rpc.string_of_rpc json

let test_mineBlocks s (num : int) =
  let call : Rpc.call =
    Rpc.({ name = "test_mineBlocks"
         ; params = [Rpc.Int (Int64.of_int num)]
         }) in
  let ()  = ignore (pick_result (do_rpc_unix s call)) in
  ()

let test_rawSign s (addr : address) (data : string) =
  let call : Rpc.call =
    Rpc.({ name = "test_rawSign"
         ; params = [rpc_of_address addr; rpc_of_string data]
         }) in
  let res = do_rpc_unix s call in
  let json = pick_result res in
  Rpc.string_of_rpc json


let eth_getBalance s (addr : address) : Big_int.big_int =
  let call : Rpc.call =
    Rpc.({ name = "eth_getBalance"
         ; params = [rpc_of_address addr; Rpc.rpc_of_string "latest"]
         }) in
  let res : Rpc.response = do_rpc_unix s call in
  let json = pick_result res in
  let () = Printf.printf "got result %s\n%!" (Rpc.string_of_rpc json) in
  let result = Rpc.string_of_rpc json in
  Big_int.big_int_of_string result

let test_setChainParams s (config : Rpc.t) : unit =
  let call : Rpc.call =
    Rpc.({ name = "test_setChainParams"
         ; params = [config]
         }) in
  ignore (do_rpc_unix s call)

let rich_config (accounts : address list) : Rpc.t =
  let accounts_with_balance =
    List.map (fun addr ->
        (addr, Rpc.(Dict [ ("wei", String "0x100000000000000000000000000000000000000000") ]))) accounts in
  Rpc.(Dict
         [ ("sealEngine", String "NoProof")
		 ; ("params", Dict
                        [ ("accountStartNonce", String "0x")
                        ; ("maximumExtraDataSize", String "0x1000000")
                        ; ("blockReward", String "0x")
                        ; ("allowFutureBlocks", String "1")
			            ; ("homsteadForkBlock", String "0x00")
			            ; ("EIP150ForkBlock", String "0x00")
			            ; ("EIP158ForkBlock", String "0x00")
                        ; ("metropolisForkBlock", String "0xffffffffffffffffffff")
           ])
		 ; ("genesis", Dict
                         [ ("author", String "0000000000000010000000000000000000000000")
			             ; ("timestamp", String "0x00")
			             ; ("parentHash", String "0x0000000000000000000000000000000000000000000000000000000000000000")
			             ; ("extraData", String "0x")
			             ; ("gasLimit", String "0x1000000000000")
           ])
         ;  ("accounts", Dict accounts_with_balance)
         ]
  )

type log =
  { topics : string list
  } [@@ deriving rpc]

type transaction_receipt =
  { blockHash : string
  ; blockNumber : int64
  ; transactionHash : string
  ; transactionIndex : int64
  ; cumulativeGasUsed : int64
  ; gasUsed : int64
  ; contractAddress : address
  ; logs : log list
  } [@@ deriving rpc]

let eth_getTransactionReceipt s (tx : string) : transaction_receipt =
  let call : Rpc.call =
    { Rpc.name = "eth_getTransactionReceipt"
    ; Rpc.params = [Rpc.rpc_of_string tx]
    } in
  let res : Rpc.response = do_rpc_unix s call in
  let json : Rpc.t =
    pick_result res
  in
  let result = transaction_receipt_of_rpc json in
  result

let eth_blockNumber s : int64 =
  let call : Rpc.call =
    Rpc.({ name = "eth_blockNumber"
         ; params = []
         }) in
  let res : Rpc.response = do_rpc_unix s call in
  let json = pick_result res in
  let result = Rpc.int64_of_rpc json in
  result

let eth_getCode s addr : string =
  let call : Rpc.call =
    Rpc.({ name = "eth_getCode"
         ; params = [rpc_of_address addr; rpc_of_string "latest"]
         }) in
  let res : Rpc.response = do_rpc_unix s call in
  let json = pick_result res in
  let result = Rpc.string_of_rpc json in
  result

let test_rewindToBlock s =
  let call = Rpc.({ name = "test_rewindToBlock"
                  ; params = [Rpc.Int (Int64.of_int 0)]
                  }) in
  ignore (do_rpc_unix s call)

let personal_newAccount s =
  let call = Rpc.({ name = "personal_newAccount"
                  ; params = [rpc_of_string ""]
                  }) in
  let ret = do_rpc_unix s call in
  let json = pick_result ret in
  address_of_rpc json

let personal_unlockAccount s addr =
  let call = Rpc.({ name = "personal_unlockAccount"
                  ; params = [rpc_of_address addr; rpc_of_string ""; rpc_of_int 100000]
                  }) in
  ignore (do_rpc_unix s call)

let eth_getStorageAt s addr slot =
  let call = Rpc.({ name = "eth_getStorageAt"
                  ; params = [rpc_of_address addr; rpc_of_string (Big_int.string_of_big_int slot); rpc_of_string "latest"]
             }) in
  let ret = do_rpc_unix s call in
  let json = pick_result ret in
  Big_int.big_int_of_string (Rpc.string_of_rpc json)

let wait_till_mined s old_block =
  while eth_blockNumber s = old_block do
    Unix.sleepf 0.01
  done

let sample_file_name : string = "./src/parse/examples/006auction_first_case.bbo"

let advance_block s =
  let old_blk = eth_blockNumber s in
  let () = test_mineBlocks s 1 in
  let () = wait_till_mined s old_blk in
  ()

let reset_chain s acc =
  (* Maybe it's not necessary to create a new account every time *)
  let my_acc =
    match acc with
    | None ->
       personal_newAccount s
    | Some acc -> acc in
  let config = rich_config [my_acc] in
  let () = test_setChainParams s config in
  let () = test_rewindToBlock s in
  let () = test_rewindToBlock s in
  let balance = eth_getBalance s my_acc in
  let () = assert (Big_int.gt_big_int balance (Big_int.big_int_of_int 10000000000000000)) in
  my_acc

let deploy_code s my_acc code value =
  let trans : eth_transaction =
    { from = my_acc
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = value
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    ; data = code
    ; _to = "0x"
    }
  in
  let tx = (eth_sendTransaction s trans) in
  let () = advance_block s in
  let receipt = eth_getTransactionReceipt s tx in
  receipt

let call s tr =
  let tx = eth_sendTransaction s tr in
  let () = advance_block s in
  eth_getTransactionReceipt s tx

let testing_006 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file sample_file_name in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "0000000000000000000000000000000000000000000000000000000400000020"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let receipt = deploy_code s my_acc initcode "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let original = eth_getStorageAt s contract_address (Big_int.big_int_of_int 4) in
  let () = assert (Big_int.(eq_big_int original zero_big_int)) in
  let tr : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "100"
    ; data = ""
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s tr in
  let n = eth_getStorageAt s contract_address (Big_int.big_int_of_int 4) in
  let () = Printf.printf "got storage %s\n" (Big_int.string_of_big_int n) in
  let () = assert (Big_int.(eq_big_int n (big_int_of_int 100))) in
  ()

let constructor_arg_test s =
  let initcode_compiled : string = CompileFile.compile_file sample_file_name in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let my_acc = reset_chain s None in
  let receipt = deploy_code s my_acc initcode "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (not (String.length deployed > 2)) in
  let () = Printf.printf "didn't find code! good!\n" in
  my_acc

let testing_00bb s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00bbauction_first_named_case.bbo" in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let receipt = deploy_code s my_acc initcode "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code! %s\n" deployed in
  let storage_first_word = eth_getStorageAt s contract_address (Big_int.big_int_of_int 0) in
  let () = Printf.printf "first word! %s\n" (Big_int.string_of_big_int storage_first_word) in
  let original = eth_getStorageAt s contract_address (Big_int.big_int_of_int 4) in
  let () = assert (Big_int.(eq_big_int original zero_big_int)) in
  let tr : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "100"
    ; data = Ethereum.compute_signature_hash "bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s tr in
  let () = Printf.printf "used gas: %s\n%!" (Int64.to_string receipt.gasUsed) in
  let () = Printf.printf "transaction hash: %s\n%!" receipt.transactionHash in
  let n = eth_getStorageAt s contract_address (Big_int.big_int_of_int 2) in
  let () = assert (Big_int.(eq_big_int n (big_int_of_int 100))) in
  ()


(* showing not quite satisfactory results *)
let testing_00b s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00b_auction_more.bbo" in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "ff00000000000000000000000000000000000000000000000000000400000020"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let receipt = deploy_code s my_acc initcode "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let highest_bid : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = Ethereum.compute_signature_hash "highest_bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s highest_bid in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let tr : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "100"
    ; data = Ethereum.compute_signature_hash "bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s tr in
  let answer = eth_call s highest_bid in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000064") in
  ()

let testing_010 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/010_logical_and.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let both : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(bool,bool)") ^ "0000000000000000000000000000000000000000000000000000000005f5e1000000000000000000000000000000000000000000000000000000000005f5e100"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s both in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000001") in
  ()

let testing_011 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/011_keccak256.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let both : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(address,bytes32)") ^ "0000000000000000000000000000000000000000000000000000000005f5e1000000000000000000000000000000000000000000000000000000000005f5e100"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s both in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let expectation = "0x" ^ (Ethereum.hex_keccak "0x0000000000000000000000000000000005f5e1000000000000000000000000000000000000000000000000000000000005f5e100") in
  let () = Printf.printf "expectation: %s\n%!" expectation in
  let () = assert (answer = expectation) in
  ()

let random_ecdsa s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00e_ecdsarecover.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert(String.length deployed > 2) in (* XXX the procedure so far can be factored out *)
  let random_req : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = "0x" ^ (Ethereum.compute_signature_hash "a(bytes32,uint8,bytes32,bytes32)") ^
        "0000000000000000000000000000000000000000000000000000000005f5e100"^
               "0000000000000000000000000000000000000000000000000000000005f5e100"^
                 "0000000000000000000000000000000000000000000000000000000005f5e100"^
                   "0000000000000000000000000000000000000000000000000000000005f5e100"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s random_req in
  let () = Printf.printf "got answer: %s\n" answer in
  let tx = eth_sendTransaction s random_req in
  let () = advance_block s in
  let () = Printf.printf "transaction id for random_eq: %s\n%!" tx in

  let () = assert(answer = "0x0000000000000000000000000000000000000000000000000000000000000000") in
  ()


let correct_ecdsa s my_acc =
  (* The input data and the output data are cited from Parity:builtin.rs from commit
   * 3308c404400a2bc58b12489814e9f3cfd5c9d272
   *)
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00e_ecdsarecover.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert(String.length deployed > 2) in (* XXX the procedure so far can be factored out *)
  let random_req : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = "0x" ^ (Ethereum.compute_signature_hash "a(bytes32,uint8,bytes32,bytes32)") ^
        "47173285a8d7341e5e972fc677286384f802f8ef42a5ec5f03bbfa254cb01fad000000000000000000000000000000000000000000000000000000000000001b650acf9d3f5f0a2c799776a1254355d5f4061762a237396a99a0e0e3fc2bcd6729514a0dacb2e623ac4abd157cb18163ff942280db4d5caad66ddf941ba12e03"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s random_req in
  let () = Printf.printf "got answer: %s\n" answer in
  let tx = eth_sendTransaction s random_req in
  let () = advance_block s in
  let () = Printf.printf "transaction id for random_eq: %s\n%!" tx in

  let () = assert(answer = "0x000000000000000000000000c08b5542d177ac6686946920409741463a15dddb") in
  ()

let zero_word = "0000000000000000000000000000000000000000000000000000000000000000"
let one_word =  "0000000000000000000000000000000000000000000000000000000000000001"

let testing_00i s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00i_local_bool.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(uint8)") ^ zero_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s c in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x" ^ one_word) in
  ()

let testing_013 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/013_iszero.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "a(bytes32)") ^ zero_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s c in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000001") in
  ()

let zero_word = "0000000000000000000000000000000000000000000000000000000000000000"
let one_word =  "0000000000000000000000000000000000000000000000000000000000000001"

let testing_022 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/022_plus_gt.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(uint256,uint256,uint256)") ^ one_word ^ one_word ^ zero_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s c in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000000") in
  ()

let testing_014 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/014_ifelse.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(bool,bool)") ^ zero_word ^ one_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s c in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x" ^ zero_word) in
  ()

let testing_016 s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/016_void.bbo" in
  let receipt = deploy_code s my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "300"
    ; data = (Ethereum.compute_signature_hash "pass(address,uint256)") ^ "000000000000000000000000000000000000000000000000000000000000aaaa" ^ "0000000000000000000000000000000000000000000000000000000000000001"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let tx = eth_sendTransaction s c in
  let () = advance_block s in
  let balance = eth_getBalance s "0x000000000000000000000000000000000000aaaa" in
  let () = assert (Big_int.(eq_big_int balance (big_int_of_int 1))) in
  ()

let pad_to_word str =
  let str = Ethereum.strip_0x str in
  let len = String.length str in
  let () = assert (len <= 64) in
  let padded = 64 - len in
  let pad = BatString.make padded '0' in
  pad ^ str

let testing_00h_timeout s my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00h_payment_channel.bbo" in
  let sender = pad_to_word (Ethereum.strip_0x my_acc) in
  let recipient = pad_to_word (Ethereum.strip_0x my_acc) in
  let startDate = "0000000000000000000000000000000000000000000000000000000000010000" in
  let endDate   = "0000000000000000000000000000000000000000000000000000000000020000" in
  let initdata = initcode_compiled ^
                   sender ^
                     recipient ^
                       startDate ^
                         endDate
  in
  let receipt = deploy_code s my_acc initdata "300" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let balance = eth_getBalance s contract_address in
  let () = assert (Big_int.(eq_big_int balance (big_int_of_int 300))) in
  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = Ethereum.compute_signature_hash "ChannelTimeOut()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s c in
  let () = Printf.printf "timeout tx: %s\n%!" receipt.transactionHash in
  let balance = eth_getBalance s contract_address in
  let () = assert (Big_int.(eq_big_int balance zero_big_int)) in
  ()

let testing_00h_early channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00h_payment_channel.bbo" in
  let sender = pad_to_word (Ethereum.strip_0x my_acc) in
  let recv   = personal_newAccount channel in
  let recipient = pad_to_word (Ethereum.strip_0x recv) in

  (* give receiver some Ether so that she can send transactions *)
  let c : eth_transaction =
    { from = my_acc
    ; _to = recv
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "1000000000000000000000000"
    ; data = "0x00"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let () = ignore (call channel c) in

  let startDate = "0000000000000000000000000000000000000000000000000000000000010000" in
  let endDate   = "0000000000000000000000000000000000000100000000000000000000020000" in
  let initdata = initcode_compiled ^ sender ^ recipient ^ startDate ^ endDate in
  let receipt = deploy_code channel my_acc initdata "0x3000000000" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let balance = eth_getBalance channel contract_address in
  let () = assert (Big_int.(eq_big_int balance (big_int_of_string "0x3000000000"))) in
  let value = "0000000000000000000000000000000000000000000000000000002000000000" in
  let concatenation = (Ethereum.strip_0x contract_address) ^ value in
  let () = Printf.printf "concatenation: %s\n" concatenation in
  let hash = Ethereum.hex_keccak concatenation in
  let () = Printf.printf "hash:          %s\n" hash in

  (* first call *)
  let sign = test_rawSign channel recv hash in
  let () = Printf.printf "sign:          %s\n" sign in
  let sign = BatString.tail sign 2 in
  let r = BatString.sub sign 0 64 in
  let s = BatString.sub sign 64 64 in
  let v = "00000000000000000000000000000000000000000000000000000000000000" ^ (BatString.sub sign 128 2) in
  let () = Printf.printf "v: %s\n" v in
  let c : eth_transaction =
    { from = recv
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = "0x" ^ Ethereum.compute_signature_hash "CloseChannel(bytes32,uint8,bytes32,bytes32,uint256)" ^
               hash ^ v ^ r ^ s ^ value
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let () = Printf.printf "sent data looks like this %s\n" c.data in
  let () = assert (String.length c.data = (4 + 32 + 32 + 32 + 32 + 32) * 2  + 2) in
  let receipt = call channel c in
  let () = Printf.printf "timeout tx: %s\n%!" receipt.transactionHash in

  (* second call *)
  let sign = test_rawSign channel my_acc hash in
  let () = Printf.printf "sign:          %s\n" sign in
  let sign = BatString.tail sign 2 in
  let r = BatString.sub sign 0 64 in
  let s = BatString.sub sign 64 64 in
  let v = "00000000000000000000000000000000000000000000000000000000000000" ^ (BatString.sub sign 128 2) in
  let c : eth_transaction =
    { from = recv
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = Ethereum.compute_signature_hash "CloseChannel(bytes32,uint8,bytes32,bytes32,uint256)" ^
               hash ^ v ^ r ^ s ^ value
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call channel c in
  let () = Printf.printf "timeout tx: %s\n%!" receipt.transactionHash in

  (* need to do a bit more *)
  let balance = eth_getBalance channel contract_address in
  let () = assert (Big_int.(eq_big_int balance zero_big_int)) in
  let recv_balance = eth_getBalance channel recv in
  let () = assert (Big_int.(gt_big_int recv_balance (big_int_of_string "0x2000000000"))) in
  ()


let zero_word = "0000000000000000000000000000000000000000000000000000000000000000"
let one_word =  "0000000000000000000000000000000000000000000000000000000000000001"

let testing_mapmap_non_interference channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/018_mapmap.bbo" in

  let receipt = deploy_code channel my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in

  let write_to_true : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "set(bool,address,bool)")^
               one_word ^ zero_word ^ one_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel write_to_true in
  let () = Printf.printf "write tx: %s\n" receipt.transactionHash in

  let read_from_true : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "get(bool,address)") ^
               one_word ^ zero_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call channel read_from_true in
  let receipt = call channel read_from_true in
  let () = Printf.printf "read tx: %s\n" receipt.transactionHash in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000001") in

  let read_from_false : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "get(bool,address)") ^
               zero_word ^ zero_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel read_from_false in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x0000000000000000000000000000000000000000000000000000000000000000") in

  ()

let testing_019 channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/019_something.bbo" in
  let initdata = initcode_compiled ^ "00000000000000000000000000000000000000000000000000005af3107a4000" ^ (pad_to_word (Ethereum.strip_0x my_acc)) in
  let receipt = deploy_code channel my_acc initdata "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in

  let initial_trans : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = "0x"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call channel initial_trans in

  let ask_my_balance : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "balanceOf(address)")^(pad_to_word (Ethereum.strip_0x my_acc))
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call channel ask_my_balance in
  let () = assert (answer = "0x00000000000000000000000000000000000000000000000000005af3107a4000") in
  let () = Printf.printf "balance match!\n" in
  ()


let testing_land_neq channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/021_land_neq.bbo" in
  let receipt = deploy_code channel my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in

  let initial_trans : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f()")
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call channel initial_trans in
  let () = Printf.printf "got answer %s\n%!" answer in
  let () = assert (answer = "0x" ^ one_word) in
  ()


let testing_01a channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/01a_event.bbo" in

  let receipt = deploy_code channel my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in

  let write_to_true : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "e(uint256)")^one_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel write_to_true in
  let () = assert (List.length receipt.logs = 1) in
  let [log] = receipt.logs in
  let () = assert (List.length log.topics = 2) in

  ()

let test_plus_mult channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/020_plus_mult.bbo" in

  let receipt = deploy_code channel my_acc initcode_compiled "0" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let one_word =  "0000000000000000000000000000000000000000000000000000000000000001" in
  let two_word =  "0000000000000000000000000000000000000000000000000000000000000002" in
  let three_word =  "0000000000000000000000000000000000000000000000000000000000000003" in
  let seven_word =  "0000000000000000000000000000000000000000000000000000000000000007" in

  let c : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "f(uint256,uint256,uint256)")^one_word^two_word^three_word
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel c in
  let () = assert (answer = "0x" ^ seven_word) in

  ()

(* takes an address in hex (0x followed by 40 characters) form and returns it as a word (64 characters without 0x) *)
let address_as_word address =
  let () = assert (String.length address = 42) in
  let () = assert (String.sub address 0 2 = "0x") in
  (String.make 24 '0') ^ (String.sub address 2 40)

let testing_024 channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/024_vault_shorter.bbo" in
  let recover_key = my_acc in
  let () = Printf.printf "recover: %s\n" recover_key in
  let vault_key = personal_newAccount channel in
  let () = Printf.printf "vault: %s\n" vault_key in
  let hot = personal_newAccount channel in
  let () = Printf.printf "hot: %s\n" hot in

  let c : eth_transaction =
    { from = my_acc
    ; _to = vault_key
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "2200000000000000000"
    ; data = "0x00"
    ; gasprice = "0x0000000000000000000000000000000000000000000000000000005af3107a40"
    } in
  let () = ignore (call channel c) in

  let c : eth_transaction =
    { from = my_acc
    ; _to = hot
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "2200000000000000000"
    ; data = "0x00"
    ; gasprice = "0x0000000000000000000000000000000000000000000000000000005af3107a40"
    } in
  let () = ignore (call channel c) in


  let initdata = initcode_compiled ^ address_as_word vault_key ^ address_as_word recover_key in
  let receipt = deploy_code channel my_acc initdata "10000" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let balance = eth_getBalance channel contract_address in
  let () = assert (Big_int.(eq_big_int balance (big_int_of_int 10000))) in

  (* initiate a withdrawal *)
  let unvault : eth_transaction =
    { from = vault_key
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "unvault(uint256,address)")^
               (pad_to_word "50")^(address_as_word hot)
    ; gasprice = "0x0000000000000000000000000000000000000000000000000000005af3107a40"
    } in
  let unvault_tx = call channel unvault in
  let () = Printf.printf "unvault_tx: %Ld\n" unvault_tx.blockNumber in

  (* wait for two seconds *)
  let () = Unix.sleepf 2.0 in
  let () = advance_block channel in

  let redeem : eth_transaction =
    { from = hot
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "redeem()")
    ; gasprice = "0x0000000000000000000000000000000000000000000000000000005af3107a40"
    } in
  let redeem_tx = call channel redeem in
  let () = Printf.printf "redeem_tx: %Ld\n" redeem_tx.blockNumber in
  let balance = eth_getBalance channel hot in
  let () = Printf.printf "hot acccount now has %s\n%!" (Big_int.string_of_big_int balance) in
  let () = assert(Big_int.(eq_big_int balance (big_int_of_string "2198885220000000080"))) in

  ()

let test_erc20 channel my_acc =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/01b_erc20better.bbo" in
  let initial_amount : string = "0000000000000000000000000000000000000000000000010000000000000000" in

  let receipt = deploy_code channel my_acc (initcode_compiled ^ initial_amount) "100000000000000000" in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode channel contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in

  let initialize : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = ""
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call channel initialize in
  let () = Printf.printf "init tx id: %s\n" receipt.transactionHash in

  let less_than_half_amount : string = "00000000000000000000000000000000000000000000000007f0000000000000" in
  let buying : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "100000000000000000"
    ; data = (Ethereum.compute_signature_hash "buy(uint256)")^less_than_half_amount
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel buying in
  let () = Printf.printf "consumed gas: %s\n" (Int64.to_string receipt.gasUsed) in
  let () = Printf.printf "buying tx id: %s\n" receipt.transactionHash in

  let check_balance : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "balanceOf(address)")^(pad_to_word (Ethereum.strip_0x my_acc))
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel check_balance in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x" ^ less_than_half_amount) in

  let second   = personal_newAccount channel in
  let c : eth_transaction =
    { from = my_acc
    ; _to = second
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "1000000000000000000000000"
    ; data = "0x00"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let () = ignore (call channel c) in
  let approve : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "approve(address,uint256)")^
               (pad_to_word (Ethereum.strip_0x second)) ^
                 less_than_half_amount
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel approve in
  let () = Printf.printf "approve tx id: %s\n" receipt.transactionHash in

  let see_allowance : eth_transaction =
    { from = second
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "allowance(address,address)")^
               (pad_to_word (Ethereum.strip_0x my_acc)) ^
               (pad_to_word (Ethereum.strip_0x second))
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel see_allowance in
  let () = assert (answer = "0x" ^ less_than_half_amount) in

  let use_allowance : eth_transaction =
    { from = second
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "transferFrom(address,address,uint256)")^
               (pad_to_word (Ethereum.strip_0x my_acc)) ^
               (pad_to_word (Ethereum.strip_0x second)) ^
                 less_than_half_amount
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel use_allowance in

  let check_balance : eth_transaction =
    { from = second
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "balanceOf(address)")^(pad_to_word (Ethereum.strip_0x second))
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel check_balance in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x" ^ less_than_half_amount) in

  let see_allowance : eth_transaction =
    { from = second
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "allowance(address,address)")^
               (pad_to_word (Ethereum.strip_0x my_acc)) ^
               (pad_to_word (Ethereum.strip_0x second))
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let answer = eth_call channel see_allowance in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let () = assert (answer = "0x" ^ zero_word) in

  let weis = "0000000000000000000000000000000000000000000000000010000000000000" in

  let second_orig_balance = eth_getBalance channel second in
  let selling : eth_transaction =
    { from = second
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = (Ethereum.compute_signature_hash "sell(uint256,uint256)")^less_than_half_amount^weis
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in

  let receipt = call channel selling in
  let second_new_balance = eth_getBalance channel second in

  let () = assert (Big_int.gt_big_int second_new_balance second_orig_balance) in
  let answer = eth_call channel check_balance in
  let () = assert (answer = "0x" ^ zero_word) in
  ()

let () =
  let s = Utils.open_connection_unix_fd filename in
  let my_acc = constructor_arg_test s in
  let () = testing_00h_early s my_acc in
  let () = testing_00h_timeout s my_acc in
  let () = testing_00bb s my_acc in
  let () = testing_006 s my_acc in
  let () = testing_00b s my_acc in
  let () = random_ecdsa s my_acc in
  let () = correct_ecdsa s my_acc in
  let () = testing_010 s my_acc in
  let () = testing_00i s my_acc in
  let () = testing_011 s my_acc in
  let () = testing_013 s my_acc in
  let () = testing_014 s my_acc in
  let () = testing_016 s my_acc in
  let () = testing_mapmap_non_interference s my_acc in
  let () = testing_019 s my_acc in
  let () = testing_01a s my_acc in
  let () = test_erc20 s my_acc in
  let () = testing_022 s my_acc in
  let () = testing_024 s my_acc in
  let () = Unix.close s in
  ()

(* ocaml-rpc formats every message as an HTTP request while geth does not expect this *)
(* ocaml-bitcoin is similar.  It always adds HTTP headers *)
