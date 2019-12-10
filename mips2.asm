.data
	Arr: .word 21 20 51 83 20 20
	length: .word 6
	x: .word 20
	y: .word 5
	index: .word 0
	space: .asciiz " "
.text		
	main:
		la $s1, length
		lw $t1, 0($s1)
		la $s0, Arr
		la $s2, x
		lw $t2, 0($s2)
		la $s3, y
	loop:	
		beq $t1, 0, exit
		
		lw $t0, 0($s0)
		addi $s0, $s0, 4
		
		beq $t0, $t2, replace
		j print
	print:	
		li $v0, 1
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0, space
		syscall
		
		subi $t1, $t1, 1	
		j loop	
	exit:
		li $v0, 10
		syscall
	replace:
		lw $t0, 0($s3)
		j print
		
	
		
		
		
		
		
		
		
		
		
