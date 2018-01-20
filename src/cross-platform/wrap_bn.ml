#if BSB_BACKEND = "js" then
  type t = Bn.t
  let to_string_in_hexa = Bn.toString ~base:16
  let string_of_big_int = Bn.toString ~base:10
  let big_int_of_string = Bn.fromString ~base:10
  let hex_to_big_int h = Bn.fromString ~base:16 h
  let eq_big_int = Bn.eq
  let big_int_of_int x = x |> float_of_int |> Bn.fromFloat
#else
  type t = Big_int.big_int
  let to_string_in_hexa = BatBig_int.to_string_in_hexa
  let string_of_big_int = Big_int.string_of_big_int
  let big_int_of_string = Big_int.big_int_of_string
  let hex_to_big_int h = Big_int.big_int_of_string ("0x"^h)
  let eq_big_int = Big_int.eq_big_int
  let big_int_of_int = Big_int.big_int_of_int
#end