.data 
	s: .space 256
	etext: .asciiz "Try again!"
	str1ask: .asciiz "Enter first string: "
	str2ask: .asciiz "Enter second string: "
	sum: .asciiz "The sum is: "
	address: .word 0x00400000
	nl: .asciiz "\n"	
.text
main:
	la $a0, str1ask
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall 
	move $t0, $v0
	
	la $a0, str2ask
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall 
	move $t1, $v0
	
	add $t2, $t0, $t1
	
	la $a0, sum
	li $v0, 4
	syscall
	
	li $v0, 1
	move $a0, $t2
	syscall
	
	li $v0, 10
	syscall	
	
.ktext 0x80000180
	mfc0 $k0, $14
	addi $k0, $k0, 4
	
	la $a0, etext
	li $v0, 4
	syscall
	
	la $a0, nl
	li $v0, 4
	syscall
	
	lw $k0, address
	mtc0 $k0, $14
	eret
	