	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x00000000
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


descompon:
	slti $t0, $a0, 0
	sw $t0, 0($a1) # *s = (cf < 0)
	
	sll $a0, $a0, 1
	
	bne $a0 ,$zero, else
	li $s0, 0 # exp = 0
	b fi
else:   
	li $s0, 18
while:  blt $a0, $zero, fi_while
	sll $a0, $a0, 1
	addiu $s0, $s0, -1
	b while
fi_while:
	sra $a0, $a0, 8
	li $t0, 0x7fffff
	and $a0, $a0, $t0
	addiu $s0, $s0, 127
	
fi: 	sw $s0, 0($a2)
	sw $a0, 0($a3)
	
	jr $ra

compon:
	sll $s0, $a0, 31
	sll $a1, $a1, 23
	or $s0, $s0, $a1
	or $s0, $s0, $a2
	sw $s0, -88($fp)
	lwc1 $f0, -88($fp)
	jr $ra
