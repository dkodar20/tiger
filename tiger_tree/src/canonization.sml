open Atom;
open AtomMap;

structure Canonize =
struct

val map_variable = ref (empty : Temp.temp map)
val prog = ref ([] : IR.prog)

fun compileExpr (Tree.MOVE (Tree.TEMP x, Tree.TEMP y)) = [IR.instruction (IR.move (x, y))]
	
	| compileExpr (Tree.MOVE (Tree.TEMP x, Tree.CONST y)) = [IR.instruction (IR.li (x, y))] 

	| compileExpr (Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.PLUS, Tree.TEMP x, Tree.TEMP y)))) = [IR.instruction (IR.add (curr, x, y))]

	| compileExpr (Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.MUL, Tree.TEMP x, Tree.TEMP y)))) = [IR.instruction (IR.mul (curr, x, y))]

	| compileExpr (Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.MINUS, Tree.TEMP x, Tree.TEMP y)))) = [IR.instruction (IR.sub (curr, x, y))]

    | compileExpr (Tree.EXP (Tree.CALL (Tree.NAME ("syscall"), []))) = [IR.instruction (IR.syscall())]
    
    | compileExpr (Tree.SEQ (x, y)) = (compileExpr y) @ (compileExpr x)

fun convert [] = [] |
    convert (x :: xs) = (compileExpr x) @ convert xs

val prog_final = ref ([] : IR.prog)

fun compileDir _ = 
	let
		val a = IR.directive (IR.data (""))
		val b = IR.directive (IR.label ("newline"))
		val c = IR.directive (IR.asciiz ("\"\\n\""))
		val d = IR.directive (IR.text (""))
		val e = IR.directive (IR.globl ("main"))
		val f = IR.directive (IR.label ("main"))
	in
		prog_final := [a, b, c, d, e, f] @ !prog_final
	end

fun compileExit _ = 
	(
		prog_final := !prog_final @ [IR.instruction(IR.li (~5, 10)), IR.instruction (IR.syscall())]
	)

fun compile x =
	(
		compileDir ();
		prog_final := !prog_final @ (convert x);
		compileExit();
		!prog_final
	)

end
