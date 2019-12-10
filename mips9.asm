.data
	x: .float 0.5585
	pi: .float 3.141592653589793
	one: .float 1.0
	degree: .float 180.0
	nl: .asciiz "\n"
	stopchar: .word '-'
	s: .space 256
	zero: .float 0.0
.text
main:
	#la $a0, s
	#lw $s0, stopchar
	#lb $s1, 0($a0)
	#beq $s1, $s0, exitfinal
	li $v0, 6
	syscall 
	mov.s $f12, $f0
	jal cosine
	li $v0, 2
	mov.s $f12, $f0
	syscall
	
	li $v0, 10
	syscall
	cosine:
	lwc1 $f11, pi
	lwc1 $f10, degree
	mul.s $f12, $f12, $f11
	div.s $f12, $f12, $f10
	
	
	#ldc1 $f12, x
	
	mul.s $f8, $f12, $f12 #f8=x^2
	lwc1 $f1, one 
	add.s $f5, $f1, $f1 #f5=2
	mul.s $f2, $f1, $f5 #f2=1*2
	lwc1 $f0,zero
	add.s $f0, $f0, $f1
	div.s $f7, $f8, $f2 
	sub.s $f0, $f0, $f7 # f0 = 1- x^2/2!
	addi $t0, $t0, 6
	
	addi $t1, $t1, 0
	mov.s $f3, $f8
	loop:
		beq $t0, $zero, exitfinal
		subi $t0, $t0, 1
		
		
		mul.s $f3, $f3, $f8 # f3= x^2*x^2
		add.s $f5, $f5, $f1 # f5=3
		mul.s $f2, $f5, $f2 # f2=1*2*3
		add.s $f5, $f5, $f1 # f5=4
		mul.s $f2, $f5, $f2  #f2= 1*2*3*4
		div.s $f6, $f3, $f2 # f6= x^4 / 4!
		
		beq $t1, $zero, plus
		bne $t1, $zero, minus
	minus:  sub.s $f0, $f0, $f6 
		subi $t1, $t1, 1
		j loop
	plus:   add.s $f0, $f0, $f6 # f0 = x1- ^2/2! + x^4/4! 
		addi $t1, $t1, 1
		j loop
	#cvt.s.w $f0, $f0

	#exit:
		#j main
	exitfinal:
	jr $ra
	
	
		
	
