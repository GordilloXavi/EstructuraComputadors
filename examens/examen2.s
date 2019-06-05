.data

A:	.word 1, 11, 12, 13
	.word 2, -3, 14, 15
	.word 4, -5, 6, 16
	.word -7, 8, -9, 10
	 

.text
.globl main

main:
	li $t0, 0 #i = t0
	li $t2, 4
	
outer_for:
	li $t1, 0
inner_for:
	la $t3, A
	sll $t4, $t0, 4
	sll $t5, $t1, 2
	addu $t6, $t4, $t5
	addu $t6, $t6, $t3 
	lw $t7, 0($t6) #$t7 = A[i][j]
	
	sll $t4, $t0, 2
	sll $t5, $t1, 4
	addu $t6, $t4, $t5
	addu $t6, $t6, $t3 #$t6 = &A[j][i]
	
	ble $t7, $zero, else
	
	sw $t7, 0($t6)
	b end
else:
	sw $zero, 0($t6)
end:

	addiu $t1, $t1, 1
	blt $t1, $t0, inner_for

	addiu $t0, $t0, 1
	blt $t0, $t2, outer_for

	jr $ra