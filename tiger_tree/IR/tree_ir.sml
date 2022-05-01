signature TREE =
  sig

     datatype binop = PLUS | MINUS | MUL
     datatype relop = EQ | NE | LT | GT | LE | GE

     datatype expr = CONST of int
		     | NAME  of Temp.label
			 (* tiger level : functions, destinations for conditionals etc *)
			 (* processor : assembly language address *)
		     | TEMP  of Temp.temp
			 (* tiger level : variables unbounded number *)
			 (* processor level : processor registers    *)
		     | BINOP of binop * expr * expr
		     | MEM   of expr   (* processor level : an address's content *)
		     | CALL  of expr * expr list
				       (* func (arg1, arg2 ....) *)
		     | ESEQ of stmt * expr
     and stmt = MOVE  of expr * expr    (* e₁ := e₂
					     The value e₂ is stored in the l-value
					     associated with e₁
					   *)
		| EXP   of expr           (* A statement that just evaluates an expression *)

		| JUMP  of expr * Temp.label list
		| CJUMP of relop * expr * expr * Temp.label * Temp.label
		(* CJUMP rop e1 e2 l1 l2  = if e1 rop e2 then goto l1 else goto l2 *)
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
			 (* tiger level : functions, destinations for conditionals etc *)
			 (* processor : assembly language address *)
		     | TEMP  of Temp.temp
			 (* tiger level : variables unbounded number *)
			 (* processor level : processor registers    *)
		     | BINOP of binop * expr * expr
		     | MEM   of expr   (* processor level : an address's content *)
		     | CALL  of expr * expr list
				       (* func (arg1, arg2 ....) *)
		     | ESEQ of stmt * expr
     and stmt = MOVE  of expr * expr    (* e₁ := e₂
					     The value e₂ is stored in the l-value
					     associated with e₁
					   *)
		| EXP   of expr           (* A statement that just evaluates an expression *)

		| JUMP  of expr * Temp.label list
		| CJUMP of relop * expr * expr * Temp.label * Temp.label
		(* CJUMP rop e1 e2 l1 l2  = if e1 rop e2 then goto l1 else goto l2 *)
		| SEQ of stmt * stmt
		| LABEL of Temp.label

    fun move (x, y) = MOVE (x, y)
    fun seq (x, y) = SEQ (x, y)
end

(* signature TEMP =
  sig
     type label
     type temp
     val newlabel : unit -> label  (* generate a new label *)
     val newtemp  : unit -> temp
  end

structure Temp :> TEMP = struct


   type label = int (* 2⁶⁴ = ∞ many variables *)
   type temp  = int

   (* you can use IntInf.int *)

   val nextLabel = ref 0
   val nextTemp  = ref 0

   fun newlabel _ = (* stuff here *)
   fun newtemp  _ = (* stuff here *)


end *)