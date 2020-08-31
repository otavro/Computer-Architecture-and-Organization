.data

.text
   addi $t0, $zero, 30
   addi $t1, $zero, 5
   
   div $s0, $t0, $t1
   
   #Print it!
   li $v0, 1
   add $a0, $zero, $s0
   syscall