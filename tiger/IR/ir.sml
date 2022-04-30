structure IR : sig
	type inst = (string, Temp.temp) MIPS.inst
	type dir = MIPS.directive
	type stmt = (string, Temp.temp) MIPS.stmt
	type prog = stmt list
	val instruction : inst -> stmt
	val directive : dir -> stmt
	val add : Temp.temp * Temp.temp * Temp.temp -> inst
	val mul : Temp.temp * Temp.temp * Temp.temp -> inst
	val sub : Temp.temp * Temp.temp * Temp.temp -> inst
	val li : Temp.temp * Temp.temp -> inst
	val la : Temp.temp * string -> inst
	val move : Temp.temp * Temp.temp -> inst
	val syscall : 'a -> inst
	val j : string -> inst
	val bgt : Temp.temp * Temp.temp * string -> inst
	val addi : Temp.temp * Temp.temp * Temp.temp -> inst
	val data : string -> dir
	val text : string -> dir
	val asciiz: string -> dir
	val globl : string -> dir
	val label : string -> dir
	(* val ppInst : inst -> string *)
	val ppStmt : 'stmt -> string
	(* val pp     : prog -> string *)
end = struct
    type inst = (string, Temp.temp) MIPS.inst
    type stmt = (string, Temp.temp) MIPS.stmt
	type dir = MIPS.directive
    type prog = stmt list
    fun instruction a = MIPS.Instruction (a)
    fun directive a = MIPS.Directive (a)
    fun add (a, b, c) = (MIPS.Add (a, b, c))
    fun mul (a, b, c) = (MIPS.Mul (a, b, c))
    fun sub (a, b, c) = (MIPS.Sub (a, b, c))
    fun li (a, b) = MIPS.Li (a, b)
    fun la (a, b) = MIPS.La (a, b)
    fun move (a, b) = MIPS.Move (a, b)
	fun syscall _ = MIPS.Syscall
	fun j x = MIPS.J (x)
	fun bgt (a, b, c) = MIPS.Bgt (a, b, c)
	fun addi (a, b, c) = MIPS.Addi (a, b, c) 
	fun data x = MIPS.Data (x)
	fun text x = MIPS.Text (x)
	fun asciiz x = MIPS.Asciiz (x)
	fun globl x = MIPS.Globl (x)
	fun label x = MIPS.Label (x)
    fun ppStmt _ = "instruction"
end
    