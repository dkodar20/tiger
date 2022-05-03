open Atom;
open AtomMap;

structure Translate_IR =
struct

val map_variable = ref (empty : Temp.temp map)
val prog = ref ([] : Tree.stmt list)

fun translate_ir (Ast.Op (Ast.Variable x, Ast.Assign, y)) =
		let
			val temp_map = !map_variable
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			map_variable := insert (temp_map, Atom.atom(x), curr);
			prog := [Tree.MOVE (Tree.TEMP curr, Tree.TEMP (translate_ir y))] @ !prog;
			curr
		end

	| translate_ir (Ast.Op (x, Ast.Plus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.PLUS, Tree.TEMP (translate_ir x), Tree.TEMP (translate_ir y))))] @ !prog;
			curr
		end

	| translate_ir (Ast.Op (x, Ast.Mul, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.MUL, Tree.TEMP (translate_ir x), Tree.TEMP (translate_ir y))))] @ !prog;
			curr
		end
	
	| translate_ir (Ast.Op (x, Ast.Minus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := [Tree.MOVE (Tree.TEMP curr, (Tree.BINOP (Tree.MINUS, Tree.TEMP (translate_ir x), Tree.TEMP (translate_ir y))))] @ !prog;
			curr
		end
	
	| translate_ir (Ast.Println x) = 
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			prog := [Tree.SEQ (Tree.SEQ (Tree.EXP (Tree.CALL (Tree.NAME ("syscall"), [])), 
					  Tree.MOVE (Tree.TEMP ~5, Tree.CONST 1)),
					  Tree.MOVE (Tree.TEMP ~1, Tree.TEMP (translate_ir x)))] @ !prog;
			prog := [Tree.SEQ (Tree.SEQ (Tree.EXP (Tree.CALL (Tree.NAME ("syscall"), [])), 
					  Tree.MOVE (Tree.TEMP ~5, Tree.CONST 4)),
					  Tree.MOVE (Tree.TEMP ~1, Tree.NAME ("newline")))] @ !prog;
			curr
		end

	| translate_ir (Ast.Variable x) = lookup(!map_variable, Atom.atom(x))

	| translate_ir (Ast.Const x) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			prog := [Tree.MOVE(Tree.TEMP curr, Tree.CONST x)] @ !prog;
			curr
		end 

val prog_final = ref ([] : Tree.stmt list)

fun compileRev [] = []
	| compileRev (x :: xs) = 
		(	
			translate_ir x;
			prog_final := !prog_final @ rev (!prog); prog := [];
			compileRev xs;
			!prog_final
		)

fun make_ir x =
	(
		compileRev (x);
		!prog_final
	)

end
