.data

vec1: 	.space 40
vec2:	.space 52

.text
.globl main

main:

	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $a0, 10
	la $a1, vec1
	jal subr
	
	li $a0, 13
	la $a1, vec2
	jal subr
	
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	
	jr $ra


subr:
	# registers to save: v3, p0, v2, v1
	
	addiu $sp, $sp, -24
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $ra, 20($sp)
	move $s0, $a0 #$s0 = p0
	move $s1, $a1 #$s1 = v1
	sll $s2, $s0, 2
	addu $s2, $s2, $a1 #$s2 = v2
	addiu $s2, $s2, -4
	li $s3, 0 #v3 = 0	
	li $t0, 2
	div $a0, $t0
	mflo $s4 #$s4 = p0/2
for:
	lw $a0, 0($s1) #error
	jal func
	sw $v0, 0($s2)
	
	addiu $s1, $s1, 4
	addiu $s2, $s2, -4
	addiu $s3, $s3, 1
	blt $s3, $s4, for
	
	
	lw $s0, 0($sp) # this mite be wrong ahh fugg
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s4, 16($sp)
	lw $ra, 20($sp)
	addiu $sp, $sp, 24
	jr $ra

func:
	move $v0, $a0
	jr $ra