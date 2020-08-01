_start:
	la 	x5, _data1
	lwu 	sp, 0(x5)
	mv	a0, x0		#initialize a0 to 0
	mv	a4, x0
	mv 	a6, x0
	lw	a0, 4(x5)
	jal 	ra, _sort

_sort:
	#a4 = i, a5 = j
	addi	a6, a0, -1
	
_loopi:
	bge	a4, a6, _loopiend
	mv	a5, x0
	sub	a2, a6, a4

_loopj:
	bge	a5, a2, _loopjend
	addi	a1, x5, 0x08
	addi 	a7, x0, 0X04
	mul	a2, a7, a5
	add	a1, a7, a1
	lw 	a7, 0(a1)
	lw 	a3, 4(a1)
	addi	a5, a5, 0x01
	ble	a7, a3, _loopj
	sw	a3, 0(a1)
	sw	a7, 4(a1)

_loopjend:
	addi	a4, a4, 0x01
	j	_loopi

_loopiend:
	ret

.section .data  # data section starts
.p2align 0x2   # aligned to eight bytes

_data1:
	.word 	0x10011000    # First data in data section
	.word   0x04
	.word	0x04
	.word	0x03
	.word	0x02
	.word	0x01
