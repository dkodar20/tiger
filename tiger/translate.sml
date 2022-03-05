open Atom
open AtomMap

structure Translate =
struct

(*fun compileExpr (Ast.Const x)         = [Machine.Push x]
  | compileExpr (Ast.Op (x, oper, y)) = compileExpr y @ compileExpr x @ [Machine.Exec oper];


fun compile []        = []
  | compile (x :: xs) = compileExpr x @ Machine.PrintTop :: compile xs *)
(*
  x = 3
  -> map({x -> 'Temp.temp })
*)

val map_variable = ref (empty : temp map)
val prog = ref ([] : IR.prog)

fun compileExpr (Ast.Variable x) = lookup(!map_variable, Atom.atom(x))
	
	| compileExpr (Ast.Const x) = 
		let
			val curr = !Temp.nextTemp : temp
		in
			Temp.nextTemp := curr + 1;
			map_variable := insert (!map_variable, Atom.atom(x), curr);
			prog := prog @ [IR.Instruction (IR.Li (curr, MIPS.Imm x))];
			curr
		end

	| compileExpr (Ast.Op (Ast.Variable x, Assign, y)) =
		let
			val temp_map = !map_variable
			val curr = !Temp.nextTemp : temp
		in
			Temp.nextTemp := curr + 1;
			if find(temp_map, Atom.atom(x)) = NONE then
				map_variable := insert (temp_map, Atom.atom(x), curr)
			else
				map_variable := temp_map;
			prog := prog @ [IR.Instruction (IR.Li (compileExpr (Ast.Variable x), compileExpr y))];
			lookup(!map_variable, Atom.atom(x))
		end

	| compileExpr (Ast.Op (x, Plus, y)) =
		let
			val curr = !Temp.nextTemp : temp
		in
			Temp.nextTemp := (curr + 1);
			prog := prog @ [IR.Instruction (IR.Add (curr, compileExpr x, compileExpr y))];
			curr
		end

	| compileExpr (Ast.Op (x, Mul, y)) =
		let
			val curr = !Temp.nextTemp : temp
		in
			Temp.nextTemp := (curr + 1);
			prog := prog @ [IR.Instruction (IR.Mul (curr, compileExpr x, compileExpr y))];
			curr
		end
	
	| compileExpr (Ast.Op (x, Minus, y)) =
		let
			val curr = !Temp.nextTemp : temp
		in
			Temp.nextTemp := (curr + 1);
			prog := prog @ [IR.Instruction (IR.Sub (curr, compileExpr x, compileExpr y))];
			curr
		end

end
