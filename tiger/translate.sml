open Atom;
open AtomMap;

structure Translate =
struct

val map_variable = ref (empty : Temp.temp map)
val prog = ref ([] : IR.prog)

fun compileExpr (Ast.Variable x) = lookup(!map_variable, Atom.atom(x))
	
	| compileExpr (Ast.Const x) = 
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			prog := [IR.instruction (IR.li (curr, x))] @ !prog;
			curr
		end

	| compileExpr (Ast.Op (Ast.Variable x, Ast.Assign, y)) =
		let
			val temp_map = !map_variable
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			if find(temp_map, Atom.atom(x)) = NONE then
				map_variable := insert (temp_map, Atom.atom(x), curr)
			else
				map_variable := temp_map;
			prog := [IR.instruction (IR.move (compileExpr (Ast.Variable x), compileExpr y))] @ !prog;
			lookup(!map_variable, Atom.atom(x))
		end

	| compileExpr (Ast.Op (x, Ast.Plus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [IR.instruction (IR.add (curr, compileExpr x, compileExpr y))] @ !prog;
			curr
		end

	| compileExpr (Ast.Op (x, Ast.Mul, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [IR.instruction (IR.mul (curr, compileExpr x, compileExpr y))] @ !prog;
			curr
		end
	
	| compileExpr (Ast.Op (x, Ast.Minus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [IR.instruction (IR.sub (curr, compileExpr x, compileExpr y))] @ !prog;
			curr
		end
	
	| compileExpr (Ast.Println x) = 
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			prog := [IR.instruction (IR.syscall()), IR.instruction(IR.li (~5, 1)), IR.instruction (IR.move (~1, compileExpr x))] @ !prog;
			curr
		end

val prog_final = ref ([] : IR.prog)

fun compileDir _ = 
	let
		val x = IR.directive (IR.data (""))
		val y = IR.directive (IR.text (""))
		val z = IR.directive (IR.globl ("main"))
		val l = IR.directive (IR.label ("main"))
	in
		prog_final := [x, y, z, l] @ !prog_final
	end

fun compileRev [] = [] 
	| compileRev (x :: xs) = 
		(	
			compileExpr x;
			prog_final := !prog_final @ rev (!prog); prog := [];
			compileRev xs;
			!prog_final
		)

fun compileExit _ = 
	(
		prog_final := !prog_final @ [IR.instruction(IR.li (~5, 10)), IR.instruction (IR.syscall())]
	)

fun compile x =
	(
		compileDir ();
		compileRev (x);
		compileExit();
		!prog_final
	)

end
