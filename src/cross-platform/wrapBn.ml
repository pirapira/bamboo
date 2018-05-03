#if BSB_BACKEND = "js" then
  type t = Bn.t
  let to_string_in_hexa = Bn.toString ~base:16
  let string_of_big_int = Bn.toString ~base:10
  let big_int_of_string = Bn.fromString ~base:10
  let hex_to_big_int h = Bn.fromString ~base:16 h
  let eq_big_int = Bn.eq
  let big_int_of_int x = x |> float_of_int |> Bn.fromFloat
  let zero_big_int = Bn.fromFloat 0.
  let unit_big_int = Bn.fromFloat 1.
  let sub_big_int a b = Bn.sub b a
#else
  include WrapBnNative
#end
