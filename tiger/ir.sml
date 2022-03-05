structure IR : sig
  type inst = (string, Temp.temp) MIPS.inst
  type stmt = (string, Temp.temp) MIPS.stmt
  type prog = stmt list
  val ppInst : inst -> string
  val ppStmt : stmt -> string
  val pp     : prog -> string
end = struct
  (* complete this *)
end