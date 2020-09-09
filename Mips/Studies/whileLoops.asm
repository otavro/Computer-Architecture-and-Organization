# int i = 0
# while(i < 10){  i++; }
.data
     message: .asciiz "After while loop is done"
     space: .asciiz " "
.text
    main:
        addi $t0, $zero, 0  # i = 0
    
    
    # You will need two labels, the while and exit
    while:
        bgt $t0, 10 , exit # if $t0 >= 10; Exit the while
        jal printNumber
        addi $t0, $t0, 1  # i = i + 1    
        
        j while # jumps back to while
        
    exit:
        li $v0, 4
        la $a0, message
        syscall
        
    # end of program
    li $v0, 10
    syscall
    
   printNumber:
       li $v0, 1
       add $a0, $t0, $zero
       syscall
       
       li $v0, 4
       la $a0, space
       syscall
       
       jr $ra

