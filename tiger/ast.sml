(* The abstract syntax tree for expression *)
structure Ast = struct

datatype Expr  = Const of int
               | Variable of string
               | Op    of Expr * BinOp * Expr
               | Println of Expr
     
     and BinOp = Plus
               | Minus
               | Mul
               | Div
               | Assign

(* Some helper functions *)
fun plus  a b = Op (a, Plus, b)
fun minus a b = Op (a, Minus, b)
fun mul   a b = Op (a, Mul, b)
fun divi   a b = Op (a, Div, b)
fun assign a b = Op (a, Assign, b)
fun println  a = Println (a)
end
