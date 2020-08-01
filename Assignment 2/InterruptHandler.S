_start:
	lui sp, 0x10011 
	la t0, _trap_entry 
	csrw mtvec, t0

_prog:
    la t0, _data
    lw sp, 0(x5)
	
    mv a1, x0
	mv a2, x0
	addi a1, a2, 47

	# store address misalign
	la t0, _data
	sw x0, 3(t0)

	# load address misalign
	lw a1, 3(a5)

	# store access fault
	addi a2, a2, 8
	mv a5, x0
	sw a2, -4(a5)

	# load access fault
	mv a5, x0
	lw a2, -4(a5)

	# instruction access fault
	mv a2, x0
	jalr x0, -4(a2)

	# breakpoint
	ebreak

_iaf_end:
	j _finish

.p2align 0x2

_trap_entry:
	addi sp, sp, -4*31
	sw x1, 1*4(sp)
	sw x2, 2*4(sp)
	sw x3, 3*4(sp)
	sw x4, 4*4(sp)
	sw x5, 5*4(sp)
	sw x6, 6*4(sp)
	sw x7, 7*4(sp)
	sw x8, 8*4(sp)
	sw x9, 9*4(sp)
	sw x10, 10*4(sp)
	sw x11, 11*4(sp)
	sw x12, 12*4(sp)
	sw x13, 13*4(sp)
	sw x14, 14*4(sp)
	sw x15, 15*4(sp)
	sw x16, 16*4(sp)
	sw x17, 17*4(sp)
	sw x18, 18*4(sp)
	sw x19, 19*4(sp)
	sw x20, 20*4(sp)
	sw x21, 21*4(sp)
	sw x22, 22*4(sp)
	sw x23, 23*4(sp)
	sw x24, 24*4(sp)
	sw x25, 25*4(sp)
	sw x26, 26*4(sp)
	sw x27, 27*4(sp)
	sw x28, 28*4(sp)
	sw x29, 29*4(sp)
	sw x30, 30*4(sp)
	sw x31, 31*4(sp)

	la t0, _data
	lw t0, 0(t0)
	csrr t1, mcause
	sw t1, 0(t0)
	csrr t1, mepc
	sw t1, 4(t0)
	addi t0,t0,8
	la t1, _data
	sw t0, 0(t1)

	csrr t0, mepc 
    addi t0, t0, 4
    csrw mepc, t0

	la t0, _data
	lw t1, 4(t0)
	addi t1, t1, 1
	sw t1, 4(t0)

	mv a4, x0
	csrr a5, mcause #start switch case

	beq a5, a4, _iam

	addi a4, a4, 1
	beq a5, a4, _iaf

	addi a4, a4, 1
	beq a5, a4, _illins

	addi a4, a4, 1
	beq a5, a4, _break

	addi a4, a4, 1
	beq a5, a4, _lam

	addi a4, a4, 1
	beq a5, a4, _laf

	addi a4, a4, 1
	beq a5, a4, _sam

	addi a4, a4, 1
	beq a5, a4, _saf

	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

.p2align 0x2

_iam: 
	la t0, _data
	lw t1, 8(t0)
	addi t1, t1, 1
	sw t1, 8(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_iaf: 
la t0, _data
	lw t1, 12(t0)
	addi t1, t1, 1
	sw t1, 12(t0)

	la t0, _iaf_end
	csrw mepc, t0

	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_illins: 
	la t0, _data
	lw t1, 16(t0)
	addi t1, t1, 1
	sw t1, 16(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_break: 
	la t0, _data
	lw t1, 20(t0)
	addi t1, t1, 1
	sw t1, 20(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_lam: 
	la t0, _data
	lw t1, 24(t0)
	addi t1, t1, 1
	sw t1, 24(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_laf: 
	la t0, _data
	lw t1, 28(t0)
	addi t1, t1, 1
	sw t1, 28(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_sam: 
	la t0, _data
	lw t1, 28(t0)
	addi t1, t1, 1
	sw t1, 28(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

_saf: 
	la t0, _data
	lw t1, 32(t0)
	addi t1, t1, 1
	sw t1, 32(t0)
	
	lw x1, 1*4(sp)
	lw x2, 2*4(sp)
	lw x3, 3*4(sp)
	lw x4, 4*4(sp)
	lw x5, 5*4(sp)
	lw x6, 6*4(sp)
	lw x7, 7*4(sp)
	lw x8, 8*4(sp)
	lw x9, 9*4(sp)
	lw x10, 10*4(sp)
	lw x11, 11*4(sp)
	lw x12, 12*4(sp)
	lw x13, 13*4(sp)
	lw x14, 14*4(sp)
	lw x15, 15*4(sp)
	lw x16, 16*4(sp)
	lw x17, 17*4(sp)
	lw x18, 18*4(sp)
	lw x19, 19*4(sp)
	lw x20, 20*4(sp)
	lw x21, 21*4(sp)
	lw x22, 22*4(sp)
	lw x23, 23*4(sp)
	lw x24, 24*4(sp)
	lw x25, 25*4(sp)
	lw x26, 26*4(sp)
	lw x27, 27*4(sp)
	lw x28, 28*4(sp)
	lw x29, 29*4(sp)
	lw x30, 30*4(sp)
	lw x31, 31*4(sp)
	addi sp,sp, 4*31

	mret

# finish program
_finish:
	j _start

# data section
.section .data
.p2align 0x2
_data:
	.word	0x10012000
	.word	0		#total traps
	.word	0		#instruction address misalign
	.word	0		#instruction access fault
	.word	0		#illegal instruction
	.word	0		#breakpoint
	.word	0		#load address misalign
	.word	0		#store address misalign
	.word 	0		#store access fault