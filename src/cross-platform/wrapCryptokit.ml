#if BSB_BACKEND = "js" then
  (* TODO: Create keccak BuckleScript bindings as a separate module *)
  type keccakInit
  type keccakUpdated
  type keccakDigested
  (* Copied from https://github.com/ethereum/web3.js/blob/3547be3d1f274f70074b9eb69c3324228fc50ea5/lib/utils/utils.js#L128-L141 *)
  (* It can be imported after we have BuckleScript bindings to web3.js *)
  let toAscii: string -> string = [%raw
  {|
    function(hex) {
      // Find termination
    var str = "";
    var i = 0, l = hex.length;
    if (hex.substring(0, 2) === '0x') {
        i = 2;
    }
    for (; i < l; i+=2) {
        var code = parseInt(hex.substr(i, 2), 16);
        str += String.fromCharCode(code);
    }
    return str;
    }
  |}]
  external create_keccak_hash : string -> keccakInit = "keccak"[@@bs.module ]
  external update : string -> keccakUpdated = ""[@@bs.send.pipe :keccakInit]
  external digest : string -> string = ""[@@bs.send.pipe :keccakUpdated]
  let string_keccak str =
    create_keccak_hash "keccak256" |> update str |> digest "hex"
  let hex_keccak str =
    create_keccak_hash "keccak256" |> update (toAscii str) |> digest "hex"
#else
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
#end