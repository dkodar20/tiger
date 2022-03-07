
structure MIPS = struct

 (* The registers of the mips machine *)
	datatype reg =   zero  | at | v0 | v1 |
				  a0    | a1 | a2 | a3 |
				  t0    | t1 | t2 | t3 |
				  t4    | t5 | t6 | t7 |
				  s0    | s1 | s2 | s3 |
				  s4    | s5 | s6 | s7 |
				  t8    | t9 | k0 | k1 |
				  gp    | sp | fp | ra |
				  Imm of int | overflow

	(* The instruction *)
	datatype  ('l,'t) inst = 
						   Add of 't * 't * 't |
						   Addi of 't * 't * 't |
						   Addu of 't * 't * 't |
						   Addiu of 't * 't * 't |
						   And of 't * 't * 't |
						   Andi of 't * 't * 't |
						   Div1 of 't * 't * 't |
						   Divu1 of 't * 't * 't |
						   Mul of 't * 't * 't |
						   Mulo of 't * 't * 't |
						   Mulou of 't * 't * 't |
						   Nor of 't * 't * 't |
						   Or of 't * 't * 't |
						   Ori of 't * 't * 't |
						   Rem of 't * 't * 't |
						   Remu of 't * 't * 't |
						   Rol of 't * 't * 't |
						   Ror of 't * 't * 't |
						   Sll of 't * 't * 't |
						   Sllv of 't * 't * 't |
						   Sra of 't * 't * 't |
						   Srav of 't * 't * 't |
						   Srl of 't * 't * 't |
						   Srlv of 't * 't * 't |
						   Sub of 't * 't * 't |
						   Subu of 't * 't * 't |
						   Xor of 't * 't * 't |
						   Xori of 't * 't * 't |
						   Seq of 't * 't * 't |
						   Sge of 't * 't * 't |
						   Sgeu of 't * 't * 't |
						   Sgt of 't * 't * 't |
						   Sgtu of 't * 't * 't |
						   Sle of 't * 't * 't |
						   Sleu of 't * 't * 't |
						   Slt of 't * 't * 't |
						   Slti of 't * 't * 't |
						   Sltu of 't * 't * 't |
						   Sltiu of 't * 't * 't |
						   Sne of 't * 't * 't |
						   B of 'l |
						   Bczt of 'l |
						   J of 'l |
						   Jal of 'l |
						   Bzcf of 'l |
						   Jalr of 't |
						   Mfhi of 't |
						   Mflo of 't |
						   Mthi of 't |
						   Mtlo of 't |
						   Jr of 't |
						   Beq of 't * 't * 'l |
						   Beqz of 't * 't * 'l |
						   Bge of 't * 't * 'l |
						   Bgeu of 't * 't * 'l |
						   Bgt of 't * 't * 'l |
						   Bgtu of 't * 't * 'l |
						   Ble of 't * 't * 'l |
						   Bleu of 't * 't * 'l |
						   Blt of 't * 't * 'l |
						   Bltu of 't * 't * 'l |
						   Bne of 't * 't * 'l |
						   Bltz of 't * 'l |
						   Bltzal of 't * 'l |
						   Bgez of 't * 'l |
						   Blez of 't * 'l |
						   Bgezal of 't * 'l |
						   Bgtz of 't * 'l |
						   Bnez of 't * 'l |
						   La of 't * 'l |
						   Lb of 't * 'l |
						   Lbu of 't * 'l |
						   Ld of 't * 'l |
						   Lh of 't * 'l |
						   Lhu of 't * 'l |
						   Lw of 't * 'l |
						   Lwcz of 't * 'l |
						   Lwl of 't * 'l |
						   Lwr of 't * 'l |
						   Ulh of 't * 'l |
						   Ulhu of 't * 'l |
						   Ulw of 't * 'l |
						   Sb of 't * 'l |
						   Sd of 't * 'l |
						   Sh of 't * 'l |
						   Sw of 't * 'l |
						   Swcz of 't * 'l |
						   Swl of 't * 'l |
						   Swr of 't * 'l |
						   Ush of 't * 'l |
						   Usw of 't * 'l |
						   Move of 't * 't |
						   Mfcz of 't * 't |
						   Mfc1d of 't * 't |
						   Mtcz of 't * 't |
						   Divu2 of 't * 't |
						   Not of 't * 't |
						   Neg of 't * 't |
						   Negu of 't * 't |
						   Div2 of 't * 't | 
						   Lui of 't * 't |
						   Li of 't * 't |
						   Abs of 't * 't | 
						   Multu of 't * 't |
						   Mult of 't * 't |
						   Rfe |
						   Syscall |
						   Break of int |
						   Nop

	datatype directive = 
					 Align of int |
					 Ascii of string |
					 Asciiz of string |
					 (*Byte of int array |*)
					 Data of string |
					 (*Double of int array | *)
					 Extern of int |
					 (*Float of int array |*)
					 Globl of string |
					 (*Half of int array |*)
					 Kdata of string |
					 Ktext of string |
					 Space of int |
					 Text of string
					 (*Word of string array*)

	(* The instructions and assembler directives *)
	datatype ('l,'t) stmt = Instruction of ('l, 't) inst | Dir of directive

	(* Print the instructions when the labels are strings and
	registers are actual MIPS registers
	*)

	fun prDir (Align arg) = ".align " ^ (Int.toString arg) 
	  | prDir (Ascii arg) = ".ascii " ^ arg
	  | prDir (Asciiz arg) = ".asciiz " ^ arg
	  | prDir (Data arg) = ".data " ^ arg
	  | prDir (Extern arg) = ".extern " ^ (Int.toString arg)
	  | prDir (Globl arg) = ".globl " ^ arg
	  | prDir (Kdata arg) = ".kdata " ^ arg
	  | prDir (Ktext arg) = ".ktext " ^ arg
	  | prDir (Space arg) = ".space " ^ (Int.toString arg)
	  | prDir (Text arg) = ".text " ^ arg

	fun prReg zero = "$zero"
	| prReg at   = "$at"
	| prReg v0   = "$v0"
	| prReg v1   = "$v1"
	| prReg a0   = "$a0"
	| prReg a1   = "$a1"
	| prReg a2   = "$a2"
	| prReg a3   = "$a3"
	| prReg t0   = "$t0"
	| prReg t1   = "$t1"
	| prReg t2   = "$t2"
	| prReg t3   = "$t3"
	| prReg t4   = "$t4"
	| prReg t5   = "$t5"
	| prReg t6   = "$t6"
	| prReg t7   = "$t7"
	| prReg s0   = "$s0"
	| prReg s1   = "$s1"
	| prReg s2   = "$s2"
	| prReg s3   = "$s3"
	| prReg s4   = "$s4"
	| prReg s5   = "$s5"
	| prReg s6   = "$s6"
	| prReg s7   = "$s7"
	| prReg t8   = "$t8"
	| prReg t9   = "$t9"
	| prReg k0   = "$k0"
	| prReg k1   = "$k1"
	| prReg gp   = "$gp"
	| prReg sp   = "$sp"
	| prReg fp   = "$fp"
	| prReg ra   = "$ra"
	| prReg (Imm i) = Int.toString i
	| prReg oveflow = "Stack Overflow!"

	fun prArg1 (a : reg, b : reg, c : reg) = (prReg a) ^ ", " ^ (prReg b) ^ ", " ^ (prReg c)
	fun prArg2 (a : reg, b : reg, c : string) = (prReg a) ^ ", " ^ (prReg b) ^ ", " ^ c
	fun prArg3 (a : reg, b : reg) = prReg(a) ^ ", " ^ prReg(b)
	fun prArg4 (a : reg, b : string) = prReg(a) ^ ", " ^ b
	fun prArg5 (a : reg) = prReg(a)
	fun prArg6 (a : string) = a

	fun prInst (Add arg) = "add " ^ (prArg1 arg)
		 | prInst (Addi arg) = "addi " ^ (prArg1 arg)
		 | prInst (Addu arg) = "addu " ^ (prArg1 arg)
		 | prInst (Addiu arg) = "addiu " ^ (prArg1 arg)
		 | prInst (And arg) = "and " ^ (prArg1 arg)
		 | prInst (Andi arg) = "andi " ^ (prArg1 arg)
		 | prInst (Div1 arg) = "div1 " ^ (prArg1 arg)
		 | prInst (Divu1 arg) = "divu1 " ^ (prArg1 arg)
		 | prInst (Mul arg) = "mul " ^ (prArg1 arg)
		 | prInst (Mulo arg) = "mulo " ^ (prArg1 arg)
		 | prInst (Mulou arg) = "mulou " ^ (prArg1 arg)
		 | prInst (Nor arg) = "nor " ^ (prArg1 arg)
		 | prInst (Or arg) = "or " ^ (prArg1 arg)
		 | prInst (Ori arg) = "ori " ^ (prArg1 arg)
		 | prInst (Rem arg) = "rem " ^ (prArg1 arg)
		 | prInst (Remu arg) = "remu " ^ (prArg1 arg)
		 | prInst (Rol arg) = "rol " ^ (prArg1 arg)
		 | prInst (Ror arg) = "ror " ^ (prArg1 arg)
		 | prInst (Sll arg) = "sll " ^ (prArg1 arg)
		 | prInst (Sllv arg) = "sllv " ^ (prArg1 arg)
		 | prInst (Sra arg) = "sra " ^ (prArg1 arg)
		 | prInst (Srav arg) = "srav " ^ (prArg1 arg)
		 | prInst (Srl arg) = "srl " ^ (prArg1 arg)
		 | prInst (Srlv arg) = "srlv " ^ (prArg1 arg)
		 | prInst (Sub arg) = "sub " ^ (prArg1 arg)
		 | prInst (Subu arg) = "subu " ^ (prArg1 arg)
		 | prInst (Xor arg) = "xor " ^ (prArg1 arg)
		 | prInst (Xori arg) = "xori " ^ (prArg1 arg)
		 | prInst (Seq arg) = "seq " ^ (prArg1 arg)
		 | prInst (Sge arg) = "sge " ^ (prArg1 arg)
		 | prInst (Sgeu arg) = "sgeu " ^ (prArg1 arg)
		 | prInst (Sgt arg) = "sgt " ^ (prArg1 arg)
		 | prInst (Sgtu arg) = "sgtu " ^ (prArg1 arg)
		 | prInst (Sle arg) = "sle " ^ (prArg1 arg)
		 | prInst (Sleu arg) = "sleu " ^ (prArg1 arg)
		 | prInst (Slt arg) = "slt " ^ (prArg1 arg)
		 | prInst (Slti arg) = "slti " ^ (prArg1 arg)
		 | prInst (Sltu arg) = "sltu " ^ (prArg1 arg)
		 | prInst (Sltiu arg) = "sltiu " ^ (prArg1 arg)
		 | prInst (Sne arg) = "sne " ^ (prArg1 arg)
		 | prInst (B arg) = "b " ^ (prArg6 arg)
		 | prInst (Bczt arg) = "bczt " ^ (prArg6 arg)
		 | prInst (J arg) = "j " ^ (prArg6 arg)
		 | prInst (Jal arg) = "jal " ^ (prArg6 arg)
		 | prInst (Bzcf arg) = "bzcf " ^ (prArg6 arg)
		 | prInst (Jalr arg) = "jalr " ^ (prArg5 arg)
		 | prInst (Mfhi arg) = "mfhi " ^ (prArg5 arg)
		 | prInst (Mflo arg) = "mflo " ^ (prArg5 arg)
		 | prInst (Mthi arg) = "mthi " ^ (prArg5 arg)
		 | prInst (Mtlo arg) = "mtlo " ^ (prArg5 arg)
		 | prInst (Jr arg) = "jr " ^ (prArg5 arg)
		 | prInst (Beq arg) = "beq " ^ (prArg2 arg)
		 | prInst (Beqz arg) = "beqz " ^ (prArg2 arg)
		 | prInst (Bge arg) = "bge " ^ (prArg2 arg)
		 | prInst (Bgeu arg) = "bgeu " ^ (prArg2 arg)
		 | prInst (Bgt arg) = "bgt " ^ (prArg2 arg)
		 | prInst (Bgtu arg) = "bgtu " ^ (prArg2 arg)
		 | prInst (Ble arg) = "ble " ^ (prArg2 arg)
		 | prInst (Bleu arg) = "bleu " ^ (prArg2 arg)
		 | prInst (Blt arg) = "blt " ^ (prArg2 arg)
		 | prInst (Bltu arg) = "bltu " ^ (prArg2 arg)
		 | prInst (Bne arg) = "bne " ^ (prArg2 arg)
		 | prInst (Bltz arg) = "bltz " ^ (prArg4 arg)
		 | prInst (Bltzal arg) = "bltzal " ^ (prArg4 arg)
		 | prInst (Bgez arg) = "bgez " ^ (prArg4 arg)
		 | prInst (Blez arg) = "blez " ^ (prArg4 arg)
		 | prInst (Bgezal arg) = "bgezal " ^ (prArg4 arg)
		 | prInst (Bgtz arg) = "bgtz " ^ (prArg4 arg)
		 | prInst (Bnez arg) = "bnez " ^ (prArg4 arg)
		 | prInst (La arg) = "la " ^ (prArg4 arg)
		 | prInst (Lb arg) = "lb " ^ (prArg4 arg)
		 | prInst (Lbu arg) = "lbu " ^ (prArg4 arg)
		 | prInst (Ld arg) = "ld " ^ (prArg4 arg)
		 | prInst (Lh arg) = "lh " ^ (prArg4 arg)
		 | prInst (Lhu arg) = "lhu " ^ (prArg4 arg)
		 | prInst (Lw arg) = "lw " ^ (prArg4 arg)
		 | prInst (Lwcz arg) = "lwcz " ^ (prArg4 arg)
		 | prInst (Lwl arg) = "lwl " ^ (prArg4 arg)
		 | prInst (Lwr arg) = "lwr " ^ (prArg4 arg)
		 | prInst (Ulh arg) = "ulh " ^ (prArg4 arg)
		 | prInst (Ulhu arg) = "ulhu " ^ (prArg4 arg)
		 | prInst (Ulw arg) = "ulw " ^ (prArg4 arg)
		 | prInst (Sb arg) = "sb " ^ (prArg4 arg)
		 | prInst (Sd arg) = "sd " ^ (prArg4 arg)
		 | prInst (Sh arg) = "sh " ^ (prArg4 arg)
		 | prInst (Sw arg) = "sw " ^ (prArg4 arg)
		 | prInst (Swcz arg) = "swcz " ^ (prArg4 arg)
		 | prInst (Swl arg) = "swl " ^ (prArg4 arg)
		 | prInst (Swr arg) = "swr " ^ (prArg4 arg)
		 | prInst (Ush arg) = "ush " ^ (prArg4 arg)
		 | prInst (Usw arg) = "usw " ^ (prArg4 arg)
		 | prInst (Move arg) = "move " ^ (prArg3 arg)
		 | prInst (Mfcz arg) = "mfcz " ^ (prArg3 arg)
		 | prInst (Mfc1d arg) = "mfc1d " ^ (prArg3 arg)
		 | prInst (Mtcz arg) = "mtcz " ^ (prArg3 arg)
		 | prInst (Divu2 arg) = "divu2 " ^ (prArg3 arg)
		 | prInst (Not arg) = "not " ^ (prArg3 arg)
		 | prInst (Neg arg) = "neg " ^ (prArg3 arg)
		 | prInst (Negu arg) = "negu " ^ (prArg3 arg)
		 | prInst (Div2 arg) = "div2 " ^ (prArg3 arg)
		 | prInst (Lui arg) = "lui " ^ (prArg3 arg)
		 | prInst (Li arg) = "li " ^ (prArg3 arg)
		 | prInst (Abs arg) = "abs " ^ (prArg3 arg)
		 | prInst (Multu arg) = "multu " ^ (prArg3 arg)
		 | prInst (Mult arg) = "mult " ^ (prArg3 arg)
		 | prInst (Rfe) = "rfe"
		 | prInst (Syscall) = "syscall"
		 | prInst (Break arg) = "break " ^ (Int.toString arg)
		 | prInst (Nop) = "nop"

	fun     prStmt (Dir arg) = prDir arg
	  |  prStmt (Instruction arg) = prInst arg

	(* actual code that SPIM can understand is (string, reg) inst *)

end
