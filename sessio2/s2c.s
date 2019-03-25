	.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	la	$a0, w
	li	$a1, 31
	jal	moda
	la	$s0, resultat
	sb	$v0, 0($s0)
	move	$a0, $v0
	li	$v0, 11
	syscall
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	#li $s0, 420 #remove!!!
	jr 	$ra

nofares:
	li	$t0, 0x12345678 #modifiquem tots els registres no segurs per assegurar-nos que fem els procediments adequats a dins de la funció update
	move	$t1, $t0
	move	$t2, $t0
	move	$t3, $t0
	move	$t4, $t0
	move 	$t5, $t0
	move	$t6, $t0
	move 	$t7, $t0
	move 	$t8, $t0
	move 	$t9, $t0
	move	$a0, $t0
	move	$a1, $t0
	move	$a2, $t0
	move	$a3, $t0
	jr	$ra


moda:
	addiu $sp, $sp, -56 
	sw $s0, 40($sp) #histo
	sw $s1, 44($sp) 
	sw $s2, 48($sp)
	sw $ra, 52($sp)
	move $s1, $a0 #$s1 = *vec
	move $s2, $a1 #$s2 = num
	li $s0, 0 #$s0 = k
	li $t0, 10

for1:	#fem un bucle do-while perque sabem que farem 10 iteracions
	sll $t1, $s0, 2 
	addu $t1, $t1, $sp #adreça de histo[0] + k
	sw $zero, 0($t1)
	addiu $s0, $s0, 1
	bne $s0, $t0, for1 #final del bucle for

		
	li $t2, '0' #$t2 = max = '0' 
	li $s0, 0 # k = 0
	
	
for2: 	#REVISAR BUCLE!!!
	move $a0, $sp # $a0 = histo (primera adreça del stack pointer)
	addu $t0, $s0, $s1 
	lb $t0, 0($t0)
	addiu $a1, $t0, -48 # $a1 = vec[k]-'0'
	addiu $a2, $t2, -48 # $a2 = max-'0' (48 els el codi ASCII del '0')
	jal update
	addiu $t2, $v0, 48
	addiu $s0, $s0, 1
	bne $s2, $s0, for2
	#final bucle

	
	lw $s0, 40($sp)
	lw $s1, 44($sp)
	lw $s2, 48($sp)
	lw $ra, 52($sp)
	addiu $sp, $sp, 56
	move $v0, $t2
	jr $ra

	
update:
		
	addiu $sp, $sp, -16
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $ra, 12($sp)
	
	move $s0, $a0 # $s0 = *h
	move $s1, $a1 #$s1 = i
	move $s2, $a2 # $s2 = imax
	
	jal nofares

	sll $t0, $s1, 2 #h[i]++
	addu $t0, $t0, $s0
	lw $t1, 0($t0) # t1 = h[i]
	addiu $t1, $t1, 1 # t1 = h[i]+1
	sw $t1, 0($t0)

	sll $t2, $s2, 2 #h[imax]
	addu $t2, $t2, $s0
	lw $t2, 0($t2)
	
	ble $t1, $t2, else
	move $v0, $s1
	b fi_update

else: 
	move $v0, $s2
	
	
fi_update:
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $ra, 12($sp)
	addiu $sp, $sp, 16


