structure IR : sig
  type inst = (string, Temp.temp) MIPS.inst
  type stmt = (string, Temp.temp) MIPS.stmt
  type prog = stmt list
  val instruction : inst -> stmt
  val add : Temp.temp * Temp.temp * Temp.temp -> inst
  val mul : Temp.temp * Temp.temp * Temp.temp -> inst
  val sub : Temp.temp * Temp.temp * Temp.temp -> inst
  val li : Temp.temp * Temp.temp -> inst
  (* val ppInst : inst -> string
  val ppStmt : stmt -> string
  val pp     : prog -> string *)
end = struct
    type inst = (string, Temp.temp) MIPS.inst
    type stmt = (string, Temp.temp) MIPS.stmt
    type prog = stmt list
    fun instruction a = MIPS.Instruction (a)
    fun add (a, b, c) = (MIPS.Add (a, b, c))
    fun mul (a, b, c) = (MIPS.Mul (a, b, c))
    fun sub (a, b, c) = (MIPS.Mul (a, b, c))
    fun li (a, b) = MIPS.Li (a, b)
end
    