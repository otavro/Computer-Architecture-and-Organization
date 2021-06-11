.data
   par: .asciiz "e par"
   imp: .asciiz "e imp"
.text
   addi $t0, $zero, 30
   addi $t1, $zero, 7
   
   div $t1, $t1, 2
   mfhi $t1

   beq $t1 , $zero, epar
   bne $t1 , $zero, eimp
   
   epar:
      li $v0, 4
      la $a0, par
      syscall
   eimp:
      li $v0, 4
      la $a0, imp
      syscall
   