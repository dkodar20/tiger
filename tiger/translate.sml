open Atom;
open AtomMap;

structure Translate =
struct

(*fun compileExpr (Ast.Const x)         = [Machine.Push x]
  | compileExpr (Ast.Op (x, oper, y)) = compileExpr y @ compileExpr x @ [Machine.Exec oper];


fun compile []        = []
  | compile (x :: xs) = compileExpr x @ Machine.PrintTop :: compile xs *)


val map_variable = ref (empty : Temp.temp map)
val prog = ref ([] : IR.prog)

fun compileExpr (Ast.Variable x) = lookup(!map_variable, Atom.atom(x))
	
	| compileExpr (Ast.Const x) = 
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			(* map_variable := insert (!map_variable, Atom.atom(x), curr); *)
			prog := !prog @ [IR.instruction (IR.li (curr, x))]; (* To change 2nd argument of IR.Li *)
			curr
		end

	| compileExpr (Ast.Op (Ast.Variable x, Assign, y)) =
		let
			val temp_map = !map_variable
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := curr + 1;
			if find(temp_map, Atom.atom(x)) = NONE then
				map_variable := insert (temp_map, Atom.atom(x), curr)
			else
				map_variable := temp_map;
			prog := !prog @ [IR.instruction (IR.li (compileExpr (Ast.Variable x), compileExpr y))];
			lookup(!map_variable, Atom.atom(x))
		end

	| compileExpr (Ast.Op (x, Plus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := !prog @ [IR.instruction (IR.add (curr, compileExpr x, compileExpr y))];
			curr
		end

	| compileExpr (Ast.Op (x, Mul, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := !prog @ [IR.instruction (IR.mul (curr, compileExpr x, compileExpr y))];
			curr
		end
	
	| compileExpr (Ast.Op (x, Minus, y)) =
		let
			val curr = !Temp.nextTemp : Temp.temp
		in
			Temp.nextTemp := (curr + 1);
			prog := !prog @ [IR.instruction (IR.sub (curr, compileExpr x, compileExpr y))];
			curr
		end

	fun compile [] = [] 
end
