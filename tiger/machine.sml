(* I just use this to print the compiled code *)

structure Machine =
struct

fun programToListString [] = [] | 
    programToListString (x :: xs) = [MIPS.prInst x] @ ["\n"] @ programToListString xs

fun programToString x = String.concat (programToListString x)

end
