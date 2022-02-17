
structure MIPS = struct

 (* The registers of the mips machine *)
 datatype reg =   zero  | at | v0 | v1 |
                  a0    | a1 | a2 | a3 |
                  t0    | t1 | t2 | t3 |
                  t4    | t5 | t6 | t7 |
                  s0    | s1 | s2 | s3 |
                  s4    | s5 | s6 | s7 |
                  t8    | t9 | k0 | k1 |
                  gp    | sp | fp | ra

 (* The instruction *)
 datatype  ('l,'t) inst = 
                           Abs of 't * 't | 
                           Add of 't * 't * 't |
                           Addi of 't * 't * 'l |
                           Addu of 't * 't * 't |
                           Addiu of 't * 't * 'l |

                           And of 't * 't * 't |
                           Andi of 't * 't * 'l |
                           
                           Div2 of 't * 't | 
                           Divu2 of 't * 't |
                           
                           Div1 of 't * 't * 't |
                           Divu1 of 't * 't * 't |

                           Mul of 't * 't * 't |
                           Mulo of 't * 't * 't |
                           Mulou of 't * 't * 't |
                           
                           Mult of 't * 't |
                           Multu of 't * 't |
                           
                           Neg of 't * 't |
                           Negu of 't * 't |
                           
                           Nor of 't * 't * 't |
                           
                           Not of 't * 't |
                           
                           Or of 't * 't * 't |
                           Ori of 't * 't * 'l |
                           
                           Rem of 't * 't * 't |
                           Remu of 't * 't * 't |
                           
                           Rol of 't * 't * 't |
                           Ror of 't * 't * 't |
                           
                           Sll of 't * 't * 't |
                           Sllv of 't * 't * 't |
                           Sra of 't * 't * 't |
                           Srav of 't * 't * 't |
                           Srl of 't * 't * 't |
                           Srlv of 't * 't * 't |

                           Sub of 't * 't * 't |
                           Subu of 't * 't * 't |

                           Xor of 't * 't * 't |
                           Xori of 't * 't * 'l |

                           Li of 't * 'l |
                           Lui of 't * 'l |

                           Seq of 't * 't * 't |

                           Sge of 't * 't * 't |
                           Sgeu of 't * 't * 't |

                           Sgt of 't * 't * 't |
                           Sgtu of 't * 't * 't |

                           Sle of 't * 't * 't |
                           Sleu of 't * 't * 't |

                           Slt of 't * 't * 't |
                           Slti of 't * 't * 'l |
                           Sltu of 't * 't * 't |
                           Sltiu of 't * 't * 'l |

                           Sne of 't * 't * 't |

                           B of 'l |

                           Bczt of 'l |
                           Bzcf of 'l |

                           Beq of 't * 't * 'l |
                           Beqz of 't * 't * 'l |

                           Bge of 't * 't * 'l |
                           Bgeu of 't * 't * 'l |

                           Bgez of 't * 'l |
                           Bgezal of 't * 'l |

                           Bgt of 't * 't * 'l |
                           Bgtu of 't * 't * 'l |
                           Bgtz of 't * 'l |

                           Ble of 't * 't * 'l |
                           Bleu of 't * 't * 'l |
                           Blez of 't * 'l |

                           Bltzal of 't * 'l |

                           Blt of 't * 't * 'l |
                           Bltu of 't * 't * 'l |

                           Bltz of 't * 'l |
                           Bne of 't * 't * 'l |
                           Bnez of 't * 'l |

                           J of 'l |
                           Jal of 'l |
                           Jalr of 't |
                           Jr of 't |

                           La of 't * 'l |
                           Lb of 't * 'l |
                           Lbu of 't * 'l |

                           Ld of 't * 'l |

                           Lh of 't * 'l |
                           Lhu of 't * 'l |

                           Lw of 't * 'l |
                           Lwcz of 't * 'l |
                           Lwl of 't * 'l |
                           Lwr of 't * 'l |

                           Ulh of 't * 'l |
                           Ulhu of 't * 'l |
                           Ulw of 't * 'l |

                           Sb of 't * 'l |
                           Sd of 't * 'l |
                           Sh of 't * 'l |
                           Sw of 't * 'l |
                           Swcz of 't * 'l |
                           Swl of 't * 'l |
                           Swr of 't * 'l |

                           Ush of 't * 'l |
                           Usw of 't * 'l |

                           Move of 't * 't |

                           Mfhi of 't |
                           Mflo of 't |

                           Mthi of 't |
                           Mtlo of 't |

                           Mfcz of 't * 't |
                           Mfc1d of 't * 't |
                           Mtcz of 't * 't |

                           Rfe |
                           Syscall |
                           Break of int |
                           Nop

datatype directive = 
                     Align of int |
                     Ascii of string |
                     Asciiz of string |
                     Byte of int array |
                     Data of string |
                     Double of float array | 
                     Extern of int |
                     Float of float array |
                     Globl of string |
                     Half of int array |
                     Kdata of string |
                     Ktext of string |
                     Space of int |
                     Text of string |
                     Word of string array

 (* The instructions and assembler directives *)
 datatype ('l,'t) stmt = inst | directive

 (* Print the instructions when the labels are strings and
    registers are actual MIPS registers
 *)

fun  prReg zero = "$zero"
   | prReg at   = "$at"
   | prReg v0   = "$v0"
   | prReg v1   = "$v1"
   | prReg a0   = "$v1"
   | prReg a1   = "$v1"
   | prReg a2   = "$v1"
   | prReg a3   = "$v1"
   | prReg t0   = "$t0"
   | prReg t1   = "$t1"
   | prReg t2   = "$t2"
   | prReg t3   = "$t3"
   | prReg t4   = "$t4"
   | prReg t5   = "$t5"
   | prReg t6   = "$t6"
   | prReg t7   = "$t7"
   | prReg s0   = "$s0"
   | prReg s1   = "$s1"
   | prReg s2   = "$s2"
   | prReg s3   = "$s3"
   | prReg s4   = "$s4"
   | prReg s5   = "$s5"
   | prReg s6   = "$s6"
   | prReg s7   = "$s7"
   | prReg t8   = "$t8"
   | prReg t9   = "$t9"
   | prReg k0   = "$k0"
   | prReg k1   = "$k1"
   | prReg gp   = "$gp"
   | prReg sp   = "$sp"
   | prReg fp   = "$fp"
   | prReg ra   = "$ra"



 fun prInst (i : (string, reg) inst) = ....

 fun prStmt (stm : (string, reg) stmt) = ....
 (* actual code that SPIM can understand is (string, reg) inst *)
