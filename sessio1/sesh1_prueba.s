
	.data
A:	.word 3, 5, 7
punter:	.word 0

	.text
	.globl main

main:
	la $t0, A
	la $t1, punter
	addiu $t0, $t0, 8
	sw $t0, 0($t1)
	
	lw $t2, 0($t1)
	lw $t2, 0($t2)
	addiu $t2, $t2, 2
	move $s0, $t2
	
	lw $t3, 0($t1)
	addiu $t3, $t3, -8
	lw $t3, 0($t3)
	addu $s0, $s0, $t3
	
	addiu $t0, $t0, -4
	sw $s0, 0($t0)
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	jr $ra