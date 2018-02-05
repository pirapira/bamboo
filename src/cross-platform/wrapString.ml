#if BSB_BACKEND = "js" then
  let starts_with = Js.String.startsWith
#else
  let starts_with = BatString.starts_with
#end
