.data
     age: .word 19 #This is a word or interger
.text
    #print an interger to the screen. 
    li $v0, 1 #uses code 1
    lw $a0, age
    syscall