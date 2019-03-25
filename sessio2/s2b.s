	.data
result: .word 0
num:	.byte '7'

	.text
	.globl main
main:

	li $s0, 1
	la $t0, num
	lb $t0, 0($t0) # $t0 = '7'
	
	slti $t2, $t0, 'a' #this has to be 0 to enter the conditional
	slti $t3, $t0, 123 #123 is the ASCII code for ('z' + 1)
	xori $t2, $t2, 1 #Complement of the bit 0 
	and $t1, $t2, $t3
	beq $s0, $t1, if
	
	slti $t2, $t0, 'A' #this has to be 0
	slti $t3, $t0, 91 #91 is the ASCII code for ('Z' + 1)
	xori $t2, $t2, 1
	and $t1, $t2, $t3
	bne $s0, $t1, else 
	
if:	#result = num
	la $t1, result
	sw $t0, 0($t1)
	jr $ra

else:	
	slti $t2, $t0, '0'
	xori $t2, $t2, 1
	beq $zero, $t2, else2
	slti $t3, $t0, 58  #58 is the ASCII code for ('9' + 1)
	beq $zero, $t3, else2
	la $t1, result
	addiu $t0, $t0, -48 #48 is the ASCII code for '0'
	sw $t0, 0($t1)
	jr $ra
	
else2: 
	la $t1, result
	addiu $t0, $zero, -1
	sw $t0, 0($t1)
	jr $ra

