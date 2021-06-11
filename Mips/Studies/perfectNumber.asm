.data
    prompt: .asciiz "Positive integer you would like to check : "
    output: .asciiz "Is a perfect number (1: Yes, 0: No): "
.text
.globl main
main: li $v0 , 4        # |
    la $a0 , prompt     # |
    syscall             # |=> Print string "prompt"
    li $v0 , 5          # |
    syscall             # |=> Ask for integer A

    # Initialise variables
    move $s0 , $v0      # => Store A in $s0
    li $s1 , 0          # => The sum of all proper divisors of A
    li $s2 , 1          # => start here with checks for devisors

s:  bgeu $s2, $s0, eval # while $s2 < $s0
    rem $t0, $s0, $s2   # $t0 = $s0 % $s2
    bne $t0, $0, w
    addu $s1, $s1, $s2  # $s1 += $s2
w:  addi $s2, $s2, 1    # $s2++
    j s;                # /endwhile

eval: seq $s0, $s0, $s1 # Compare the sum of divisors with A
    li $v0 , 4          # |
    la $a0 , output     # |
    syscall             # |=> Print string "output"
    la $v0 , 1          # |
    move $a0 , $s0      # |
    syscall             # |=> Print $s0
    jr $ra