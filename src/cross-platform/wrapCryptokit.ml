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
  include WrapCryptokitNative
#end
