#if BSB_BACKEND = "js" then
  type t = Bn.t
#else
  type t = Big_int.big_int
#end