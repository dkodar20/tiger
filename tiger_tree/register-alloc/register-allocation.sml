structure Regalloc =
struct

    fun to_reg ( 0 : Temp.temp ) = MIPS.t0 |
        to_reg ( 1 : Temp.temp ) = MIPS.t1 |
        to_reg ( 2 : Temp.temp ) = MIPS.t2 |
        to_reg ( 3 : Temp.temp ) = MIPS.t3 |
        to_reg ( 4 : Temp.temp ) = MIPS.t4 |
        to_reg ( 5 : Temp.temp ) = MIPS.t5 |
        to_reg ( 6 : Temp.temp ) = MIPS.t6 |
        to_reg ( 7 : Temp.temp ) = MIPS.t7 |
        to_reg ( 8 : Temp.temp ) = MIPS.t8 |
        to_reg ( 9 : Temp.temp ) = MIPS.t9 |
        to_reg ( 10 : Temp.temp ) = MIPS.s0 |
        to_reg ( 11 : Temp.temp ) = MIPS.s1 |
        to_reg ( 12 : Temp.temp ) = MIPS.s2 |
        to_reg ( 13 : Temp.temp ) = MIPS.s3 |
        to_reg ( 14 : Temp.temp ) = MIPS.s4 |
        to_reg ( 15 : Temp.temp ) = MIPS.s5 |
        to_reg ( 16 : Temp.temp ) = MIPS.s6 |
        to_reg ( 17 : Temp.temp ) = MIPS.s7 |
        to_reg ( ~1 : Temp.temp ) = MIPS.a0 |
        to_reg ( ~2 : Temp.temp ) = MIPS.a1 |
        to_reg ( ~3 : Temp.temp ) = MIPS.a2 |
        to_reg ( ~4 : Temp.temp ) = MIPS.a3 |
        to_reg ( ~5 : Temp.temp ) = MIPS.v0 |
        to_reg ( ~6 : Temp.temp ) = MIPS.v1 |
        to_reg _ = MIPS.overflow

    fun registerAlloc ([] : IR.prog) = [] : ((string, MIPS.reg) MIPS.stmt) list |
        registerAlloc (MIPS.Instruction (MIPS.Add (x, y, z)) :: xs) = [MIPS.Instruction (MIPS.Add (to_reg x, to_reg y, to_reg z))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Sub (x, y, z)) :: xs) = [MIPS.Instruction (MIPS.Sub (to_reg x, to_reg y, to_reg z))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Mul (x, y, z)) :: xs) = [MIPS.Instruction (MIPS.Mul (to_reg x, to_reg y, to_reg z))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Li (x, y)) :: xs) = [MIPS.Instruction (MIPS.Li (to_reg x, MIPS.Imm (y)))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.La (x, y)) :: xs) = [MIPS.Instruction (MIPS.La (to_reg x, y))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Move (x, y)) :: xs) = [MIPS.Instruction (MIPS.Move (to_reg x, to_reg y))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Syscall) :: xs) = [MIPS.Instruction (MIPS.Syscall)] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Bgt (x, y, z)) :: xs) = [MIPS.Instruction (MIPS.Bgt (to_reg x, MIPS.Imm(y), z))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.Addi (x, y, z)) :: xs) = [MIPS.Instruction (MIPS.Addi (to_reg x, to_reg y, MIPS.Imm (z)))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Instruction (MIPS.J (x)) :: xs) = [MIPS.Instruction (MIPS.J (x))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Directive (MIPS.Data (x)) :: xs) = [MIPS.Directive (MIPS.Data (x))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Directive (MIPS.Text (x)) :: xs) = [MIPS.Directive (MIPS.Text (x))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Directive (MIPS.Asciiz (x)) :: xs) = [MIPS.Directive (MIPS.Asciiz (x))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Directive (MIPS.Globl (x)) :: xs) = [MIPS.Directive (MIPS.Globl (x))] @ (registerAlloc xs) |
        registerAlloc (MIPS.Directive (MIPS.Label (x)) :: xs) = [MIPS.Directive (MIPS.Label (x))] @ (registerAlloc xs)

        
end