signature TREE =
  sig

	datatype binop = PLUS | MINUS | MUL
	datatype relop = EQ | NE | LT | GT | LE | GE

	datatype expr = CONST of int
				| NAME  of Temp.label
			 	| TEMP  of Temp.temp
				| BINOP of binop * expr * expr
				| MEM   of expr
				| CALL  of expr * expr list
				| ESEQ of stmt * expr
     and stmt = MOVE  of expr * expr
	     		| EXP   of expr
	     		| JUMP  of expr * Temp.label list
	     		| CJUMP of relop * expr * expr * Temp.label * Temp.label
	     		| SEQ of stmt * stmt
	     		| LABEL of Temp.label

    val move : expr * expr -> stmt
    val seq : stmt * stmt -> stmt

end

structure Tree = struct

	datatype binop = PLUS | MINUS | MUL
	datatype relop = EQ | NE | LT | GT | LE | GE

	datatype expr = CONST of int
				| NAME  of Temp.label
			 	| TEMP  of Temp.temp
				| BINOP of binop * expr * expr
				| MEM   of expr
				| CALL  of expr * expr list
				| ESEQ of stmt * expr
     and stmt = MOVE  of expr * expr
	     		| EXP   of expr
	     		| JUMP  of expr * Temp.label list
	     		| CJUMP of relop * expr * expr * Temp.label * Temp.label
	     		| SEQ of stmt * stmt
	     		| LABEL of Temp.label

    fun move (x, y) = MOVE (x, y)
    fun seq (x, y) = SEQ (x, y)
end
