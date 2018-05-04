#if BSB_BACKEND = "js" then
  let starts_with = Js.String.startsWith
#else
  include WrapStringNative
#end
