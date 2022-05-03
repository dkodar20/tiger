(* I just use this to print the compiled code *)

structure Machine =
struct

fun programToListString [] = [] | 
    programToListString (x :: xs) = [MIPS.prStmt x] @ ["\n"] @ programToListString xs

fun programToString x = String.concat (programToListString x)

val cnt = ref (0 : int)

fun basicBlockString [] = [] | 
    basicBlockString ([] :: xs) = basicBlockString xs |
    basicBlockString (x :: xs) = (cnt := !cnt + 1; ["\n" ^ Int.toString (!cnt) ^ "th Basic Block: \n"] @ programToListString x @ basicBlockString xs)

fun bbToString x = String.concat (basicBlockString x)

end
