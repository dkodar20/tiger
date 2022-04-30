(* The abstract syntax tree for expression *)
structure Ast = struct

(*

Every language has a syntax or a grammar which defines what are its
valid constructs. Languages have two syntax.

1. The _concrete syntax_ which specifies the strings that are valid
   programs.

2. The _abstract syntax_ which captures the essence of the language
   constructs.

Inside the compiler, the program that is to be compiled is represented
by its abstract syntax.  The concrete syntax is only required at the
"parsing" stage where we would like to convert the input program which
is a string into the corresponding abstract syntax. For example, we
use parenthesis in the string `(2 + 3) * 4` only to distinguish it
from `2 + (3 * 4)`. If we are allowed to use trees the above two
expressions can be represented as trees as show below.

```

+--------------------------------------------------------+
|          (2 + 3) * 4       |      2 + (3 * 4)          |
|----------------------------|---------------------------|
|                            |                           |
|              *             |        +                  |
|             / \            |       / \                 |
|            +   4           |      2   *                |
|           / \              |         / \               |
|          2   3             |        3   4              |
|                            |                           |
+--------------------------------------------------------+

```

Notice that here the tree structure completely specifies what the
expression and no parenthesis is required for disambiguation. We can
think of the tree as the abstract syntax for expressions as it
captures the meaning of the expression succinctly. It turns out that
trees can be used to define the abstract syntax of languages and hence
the data structure that represent programs are called _abstract syntax
trees_ or AST's for short.

The advantage of Standard ML for writing compilers starts showing
itself right away: It almost seems that algebraic data types are
tailor made to represent abstract syntax trees of programming
languages. Here is the one for our rather humble expression language.


*)

datatype Expr  = Const of int
               | Variable of string
               | Op    of Expr * BinOp * Expr
               | Println of Expr
               | For of string * int * int * (Expr list)
     
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
fun for a b c d = For (a, b, c, d)
end
