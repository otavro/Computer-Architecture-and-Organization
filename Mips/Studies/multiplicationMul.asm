.data

.text
    addi $s0, $zero, 10 # s0 = 0 + 10
    addi $s1, $zero, 4  # s1 = 0 + 4
    
     mul $t0, $s0, $s1  #t0 = s0 * s1
     
      li $v0, 1 #print command
      add $a0, $zero, $t0 #a0 = t0
      syscall 