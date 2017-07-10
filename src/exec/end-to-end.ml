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
  let ()  = ignore (do_rpc_unix s call) in
  ()

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

type transaction_receipt =
  { blockHash : string
  ; blockNumber : int64
  ; transactionHash : string
  ; transactionIndex : int64
  ; cumulativeGasUsed : int64
  ; gasUsed : int64
  ; contractAddress : address
  ; logs : unit list (* XXX actually more structured *)
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
    Unix.sleep 1
  done

let sample_file_name : string = "./src/parse/examples/006auction_first_case.bbo"

let advance_block s =
  let old_blk = eth_blockNumber s in
  let () = test_mineBlocks s 1 in
  let () = wait_till_mined s old_blk in
  ()

let reset_chain s =
  (* Maybe it's not necessary to create a new account every time *)
  let my_acc = personal_newAccount s in
  let config = rich_config [my_acc] in
  let () = test_setChainParams s config in
  let () = test_rewindToBlock s in
  let () = test_rewindToBlock s in
  let balance = eth_getBalance s my_acc in
  let () = assert (Big_int.gt_big_int balance (Big_int.big_int_of_int 10000000000000000)) in
  my_acc

let deploy_code s my_acc code =
  let trans : eth_transaction =
    { from = my_acc
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0x0000000000000000000000000000000000000000000000000000000000000000"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    ; data = code
    ; _to = "0x"
    }
  in
  let tx = (eth_sendTransaction s trans) in
  let () = advance_block s in
  let receipt = eth_getTransactionReceipt s tx in
  receipt

let call s my_acc tr =
  let tx = eth_sendTransaction s tr in
  let () = advance_block s in
  eth_getTransactionReceipt s tx

let testing_006 s =
  let initcode_compiled : string = CompileFile.compile_file sample_file_name in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "0000000000000000000000000000000000000000000000000000000400000020"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let my_acc = reset_chain s in
  let receipt = deploy_code s my_acc initcode in
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
  let receipt = call s my_acc tr in
  let n = eth_getStorageAt s contract_address (Big_int.big_int_of_int 4) in
  let () = assert (Big_int.(eq_big_int n (big_int_of_int 100))) in
  ()

(** XXX this should move to a library *)
let compute_signature_hash (signature : string) : string =
  String.sub (Ethereum.string_keccak signature) 0 8

let testing_00bb s =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00bbauction_first_named_case.bbo" in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let my_acc = reset_chain s in
  let receipt = deploy_code s my_acc initcode in
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
    ; data = compute_signature_hash "bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s my_acc tr in
  let n = eth_getStorageAt s contract_address (Big_int.big_int_of_int 4) in
  let () = assert (Big_int.(eq_big_int n (big_int_of_int 100))) in
  ()


(* showing not quite satisfactory results *)
let testing_00b s =
  let initcode_compiled : string = CompileFile.compile_file "./src/parse/examples/00b_auction_more.bbo" in
  let initcode_args : string =
    "0000000000000000000000000000000000000000000000000000000000000000"
    ^ "ff00000000000000000000000000000000000000000000000000000400000020"
    ^ "0000000000000000000000000000000000000000000000000000000000000000" in
  let initcode = initcode_compiled^initcode_args in
  let my_acc = reset_chain s in
  let receipt = deploy_code s my_acc initcode in
  let contract_address = receipt.contractAddress in
  let deployed = eth_getCode s contract_address in
  let () = assert (String.length deployed > 2) in
  let () = Printf.printf "saw code!\n" in
  let highest_bid : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "0"
    ; data = compute_signature_hash "highest_bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let answer = eth_call s highest_bid in
  let () = Printf.printf "got answer: %s\n%!" answer in
  let tr : eth_transaction =
    { from = my_acc
    ; _to = contract_address
    ; gas = "0x0000000000000000000000000000000000000000000000000000000005f5e100"
    ; value = "100"
    ; data = compute_signature_hash "bid()"
    ; gasprice = "0x00000000000000000000000000000000000000000000000000005af3107a4000"
    } in
  let receipt = call s my_acc tr in
  let answer = eth_call s highest_bid in
  let () = Printf.printf "got answer: %s\n%!" answer in
  ()

let () =
  let s = Utils.open_connection_unix_fd filename in
  let () = testing_00bb s in
  let () = testing_006 s in
  let () = testing_00b s in
  let () = Unix.close s in
  ()

(* ocaml-rpc formats every message as an HTTP request while geth does not expect this *)
(* ocaml-bitcoin is similar.  It always adds HTTP headers *)
