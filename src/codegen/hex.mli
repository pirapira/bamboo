type hex

val append_op : hex -> Big_int.big_int Evm.instruction -> hex
val program : Big_int.big_int Evm.program -> hex
val string_of_hex : hex -> string
