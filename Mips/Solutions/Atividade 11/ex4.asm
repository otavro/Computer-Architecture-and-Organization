.data
	string_space:      .space   1024                         #  reservado 1024  bytes para ler as strings.
	ehPalinMsg:      .asciiz  "O numero é palindromo.\n"
	naoEhPalin:     .asciiz  "O numero não é palindromo.\n"
	msgEntrada:         .asciiz  "Forneça um numero: " 

.text
main:                               
        la         $a0, msgEntrada
        li         $v0,  4
        syscall
                                      ##  read the string  S:
        la      $a0, string_space
        li      $a1, 1024
        li      $v0, 8                #  load "read_string"  code  into  $v0.
        syscall

        la         $t1, string_space         #  A  = S.

        la         $t2, string_space         ##  we need  to move B  to the end
length_loop:                                 #   of  the string:
        lb         $t3, ($t2)                #  load the byte at  addr B  into $t3.
        beqz       $t3,  end_length_loop     #  if $t3   == 0, branch out   of  loop.
        addu       $t2, $t2, 1               #  otherwise,  increment B,
        b          length_loop               #    and  repeat the loop.
end_length_loop:
        subu       $t2, $t2, 2               ##  subtract 2  to move B  back  past
                                             #   the ’\0’ and  ’\n’.
test_loop:
        bge        $t1, $t2, is_palin        #  if A  >= B,  it’s a  palindrome.

        lb         $t3, ($t1)                     #  load the byte at  addr A  into $t3,
        lb         $t4, ($t2)                     #  load the byte at  addr B  into $t4.
        bne        $t3, $t4, not_palin      #  if $t3   !=  $t4, not   a  palindrome.
               
        addu       $t1, $t1, 1              ##  Otherwise, increment  A,
        subu       $t2, $t2, 1              # decrement B,  
        b          test_loop                # and repeat the loop.

is_palin:                                   ##  print  the ehPalinMsg, and  exit.
        la         $a0, ehPalinMsg
        li         $v0,  4
        syscall
        b          exit

not_palin:
        la         $a0, naoEhPalin       ##  print  the ehPalinMsg, and  exit.
        li         $v0,  4
        syscall
        b          exit
exit:                                                 ##  exit  the program:
        li         $v0, 10                                   #  load "exit"  into $v0.
        syscall                                      #  make the  system call.
