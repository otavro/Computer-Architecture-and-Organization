.data
    
.text
    addi $t0, $zero, 2000 #t0 = 2000
    addi $t1, $zero, 10   #t1 = 10
    
    mult $t0, $t1  # hi, lo receves t0 * t1
    
    mflo $s0  #s0 = lo
    #mfhi $s1
    
    #Display the product to the screen.
    li $v0, 1
    add $a0, $zero, $s0
    syscall
    
    