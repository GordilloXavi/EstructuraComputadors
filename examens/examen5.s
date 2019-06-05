.data

V1:	.word 2, -3, 6, 2, -8, 6, 2
V2:	.word 0, 0, 0, 0, 0, 0, 0, 0 
V3:	.word 0, 0, 0, 0, 0, 0, 0, 0 
res1:	.word
res2:	.word

.text
.globl main

main:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, V1
	la $a1, V2
	li $a3, 2
	jal buscar
	la $t0, res1
	sw $v0, 0($t0)
	
	la $a0, V1
	la $a1, V3
	li $a2, 6
	jal buscar
	la $t0, res2
	sw $v0, 0($t0)
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra

buscar:
	# cont, a, b, c, i, ra, 8
	addiu $sp, $sp, -28
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $ra, 24($sp)

	li $s0, 0
	li $s1, 8	
	move $s2, $a0
	move $s3, $a1
	move $s4, $a2
for:
	lw $t0, 0($s2)
	bne $t0, $s4, not_if
	move $a0, $s3
	move $a1, $sp
	jal comptar

not_if:
	addiu $s2, $s2, 4
	addiu $s3, $s3, 4
	addiu $s0, $s0, 1
	blt $s0, $s1, for
	
	lw $v0, 0($sp)
	
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	lw $s4, 20($sp)
	lw $ra, 24($sp)
	addiu $sp, $sp, 28
	jr $ra
	
	
	
comptar:
	lw $t0, 0($a1)
	addiu $t0, $t0, 1
	sw $t0, 0($a1)
	li $t0, -1
	sw $t0, 0($a0)
