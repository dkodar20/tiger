signature INST = sig
    type t   (* The type of the instruction *)
    val isJumpLike   : t -> bool
    val isTarget     : t -> bool
end

structure MIPSInst : INST = struct
    type t = (string, MIPS.reg) MIPS.stmt
    (* Only including the instructions which have been used yet *)

    fun isJumpLike (MIPS.Instruction (MIPS.J x)) = true |
        isJumpLike (MIPS.Instruction (MIPS.Bgt x)) = true |
        isJumpLike _ = false
    
    fun isTarget (MIPS.Directive (MIPS.Label x)) = true |
        isTarget _ = false
end

functor BasicBlocks (I : INST) = struct

    structure Inst = I
    type block = I.t list
    
    val isJumpLike = I.isJumpLike
    val isTarget = I.isTarget
    
    val curr_block = ref ([] : block) 
    fun basicBlocks [] = [!curr_block] |
        basicBlocks ((x :: xs) : I.t list) = 
        let
            val temp_block = ref (!curr_block)
        in
            if (isJumpLike x) then
                (temp_block := !temp_block @ [x];
                curr_block := [];
                [!temp_block] @ (basicBlocks xs))
            else if (isTarget x) then
                (curr_block := [x];
                [!temp_block] @ (basicBlocks xs))
                (* (curr_block := [];
                [!temp_block] @ (basicBlocks xs)) *)
            else
                (curr_block := !curr_block @ [x];
                basicBlocks xs
                )
        end
end

structure MIPSBasicBlocks = BasicBlocks (MIPSInst)