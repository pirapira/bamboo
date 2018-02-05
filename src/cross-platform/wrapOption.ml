#if BSB_BACKEND = "js" then
  include Js.Option
  (* Js.Option.map expects the callback to be uncurried
  https://bucklescript.github.io/bucklescript/api/Js.Option.html#VALmap
  Explanation: https://bucklescript.github.io/docs/en/function.html#curry-uncurry *)
  let map a = Js.Option.map ((fun x  -> a x)[@bs])
#else
  include BatOption
#end