.data
mat:	.word 0 0 2 0 0 0 0 0 4 0 0 0 0 0 6 0 0 0 0 0 8 0 0 0
resultat: .word 0

.text
.globl main

main:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, mat
	jal suma_col
	la $t0, resultat
	sw $v0, 0($t0)
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra
	
suma_col:
	li $v0, 0
	li $s1, 4
	addiu $s2, $a0, 8
for:	lw $t0, 0($s2)
	addu $v0, $v0, $t0
	addiu $s2, $s2, 24
	addiu $s1, $s1, -1
	bge $s1, $zero, for
	
	jr $ra  