#if BSB_BACKEND = "js" then
  type t = Bn.t
  let to_string_in_hexa = Bn.toString ~base:16
#else
  type t = Big_int.big_int
  let to_string_in_hexa = BatBig_int.to_string_in_hexa
#end