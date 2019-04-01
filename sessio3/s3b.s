	# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
mat1: .space 120
mat4: .word 2,3,1,2,4,3
col:  .word 2

	.text 
	.globl main
main:
	
	
	addiu $sp, $sp, -12
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $ra, 8($sp)
	
	la $s0, mat1
	#addiu $s0, $s0, 6*4+3
	la $s1, mat4
	
	move $a0, $s1
	lw $a1, 8($s1)
	la $t0, col
	lw $a2, 0($t0)
	jal subr
	sw $v0, 108($s0)
	move $a0, $s1
	li $a1, 1
	li $a2, 1
	jal subr
	sw $v0, 0($s0)

	lw $s0, 0($sp)
	lw $s1,4($sp)
	lw $ra, 8($sp)
	addiu $sp, $sp, 12
	jr $ra

subr:
	la $t0, mat1
	li $t1, 24
	multu $t1, $a2
	mflo $t2
	addu $t0, $t0, $t2 #t0 = mat1[j][5]
	
	li $t1, 3
	mult $t1, $a1
	addu $t1,$t1, $a2
	sll $t1, $t1, 2
	addu $t1, $a0, $t1
	lw $t1, 0($t1)
	sw $t1, 20($t0)
	move $v0, $a1
	jr $ra
	
# Escriu aqui el codi de la subrutina


