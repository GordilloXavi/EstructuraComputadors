.data

V:	.word 0, 3, 2, 1, 4, 5, 6, 7, 8, 9
k:	.word
	 

.text
.globl main

main:
	li $s1, 0
	li $s0, 0
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
for:
	la $a0, V
	move $a1, $s0
	addiu $a2, $a1, 2
	jal subr
	addu $s1, $s1, $v0

	lw $ra, 0($sp)
	addiu $sp, $sp, 4

	jr $ra
	
subr2:
	andi $v0, $a0, 3

subr:
