# PROGRAMA DE INTERCALAÇÃO DE STRINGS
.data
data1: .asciiz "Digite a primeira string : "
data2: .asciiz "Digite a segunda string>: "
string1: .space 50
string2: .space 50
string_inter: .space 100

.text
main:
	la $a0, data1
	la $a1, string1
	jal leitura_string
	la $a0, data2
	la $a1, string2
	jal leitura_string
	
	la $a0, string1
	la $a1, string_inter
	jal strcat
	nop
	
	la $a0, string2
	or $a1, $v0, $zero
	jal strcat
	
	li $v0, 4
	la $a0, string_inter
	syscall
	
	li $v0, 10
	syscall
	
leitura_string:
	li $v0, 4
	syscall
	move $a0, $a1
	li $a1, 50
	li $v0, 8
	syscall
	jr $ra

strcat:
	or $t0, $a0, $zero
	or $t1, $a1, $zero 
loop:
	lb   $t2, 0($t0)
	beqz  $t2, exit
	addi $t0, $t0, 1
	sb   $t2, 0($t1)
	addi $t1, $t1, 1
	b loop
	nop 
exit:
	or $v0, $t1, $zero
	jr $ra
	nop
