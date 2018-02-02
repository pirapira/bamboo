type hex = Rope.t

let empty_hex = Rope.empty
let concat_hex = Rope.concat2
let length_of_hex h = Rope.length h / 2
let hex_of_big_int (b : WrapBn.t) (length : int) =
  let raw = WrapBn.to_string_in_hexa b in
  let char_limit = 2 * length in
  let () =
    if String.length raw > char_limit then failwith "hex_of_big_int: too big" in
  let missing_len = char_limit - String.length raw in
  let prefix = String.make missing_len '0' in
  concat_hex (Rope.of_string prefix) (Rope.of_string raw)

let string_of_hex ?prefix:(prefix : string = "") (h : hex) : string =
  let ret = concat_hex (Rope.of_string prefix) h in
  Rope.to_string ret

let print_hex ?prefix:(prefix = "") h =
  Printf.printf "%s\n" (string_of_hex ~prefix h)

let hex_of_string s =
  (* TODO: check if the string contains only 0-9a-fA-F *)
  Rope.of_string s
