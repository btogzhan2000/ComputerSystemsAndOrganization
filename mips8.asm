.data
	DISPLAY: .space 0x00100 #8*8*4, we need to reserve this space at the beginning of .data segment
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64					
	RED: .word 0xff0000
	x0: .word 32
	y0: .word 32
	r: .word 15
	colors: .word 0xff0000, 0xff7f00, 0xfff00, 0x00ff00,0x0000ff, 0x4b0082, 0x9400d3, 0xff9aa2, 0xffb7b2, 0xffdac1
	ncolors: .word 10
	
.text
j main

set_pixel_color:
# Assume a display of width DISPLAYWIDTH and height DISPLAYHEIGHT
# Pixels are numbered from 0,0 at the top left
# a0: x-coordinate
# a1: y-coordinate
# a2: color
# address of pixel = DISPLAY + (y*DISPLAYWIDTH + x)*4
#			y rows down and x pixels across
# write color (a2) at arrayposition

	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1 	# y*DISPLAYWIDTH
	add $t0,$t0, $a0 	# +x
	sll $t0, $t0, 2 	# *4
	la $t1, DISPLAY 	# get address of display: DISPLAY
	add $t1, $t1, $t0	# add the calculated address of the pixel
	sw $a2, ($t1) 		# write color to that pixel
	jr $ra 			# return	

main:
	
	la $s0, colors
	lw $s1, ncolors
	lw $s2, r
	loopcolors:
		beq $s1, $zero, exitfinal
		subi $s1, $s1, 1
		
		lw $a3, 0($s0)
		addi $s0, $s0, 4
		
		lw $a0, x0
		lw $a1, y0
		
		move $a2, $s2
		subi $s2, $s2, 1
		
		jal circleRainbow
		j loopcolors
	exitfinal:
		li $v0, 10
		syscall	
circleRainbow:
	move $t2, $a0 #x0
	move $t3, $a1 #y0
	move $t4, $a2 #r
	add $t5, $zero, $zero
	add $t5, $t5, $t4 #x=x+r x=15
	mul $t6, $t4, $t4 #r^2
	loop:
		mul $t7, $t5, $t5 #x^2
		sub $t8, $t6, $t7 #r^2-x^2
		mtc1 $t8, $f0
		cvt.s.w $f0, $f0
		sqrt.s $f1, $f0
		round.w.s $f1, $f1
		mfc1 $t9, $f1
		
		add $a0, $t2, $t5 #x0+x
		add $a1, $t9, $t3 #y0+y
		move $a2, $a3
		jal set_pixel_color
		
		add $a0, $t2, $t5 #x0+x
		sub $a1, $t3, $t9 #y0-y
		move $a2, $a3
		jal set_pixel_color
		
		sub $a0, $t2, $t5 #x0-x
		sub $a1, $t3, $t9 #y0-y
		move $a2, $a3 
		jal set_pixel_color
		
		sub $a0, $t2, $t5 #x0-x
		add $a1, $t9, $t3 #y0+y
		move $a2, $a3
		jal set_pixel_color

		subi $t5, $t5, 1 #x--
		beq $t5, $zero, exit# if x=0, exit
		j loop
		
	exit:
		j loopcolors
		
		
			
		
	
	
