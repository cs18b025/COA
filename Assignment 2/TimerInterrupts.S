#define mtime  0x200bff8
#define mtimecmp 0x2004000

_start:	
andi t4,t4,0
andi t2,t2,0
andi t3,t3,0
andi t6,t6,0
li t6, mtimecmp 
andi t3,t3,0
addi t3,t3,-1
sd t3, 0(t6) 
lui sp, 0x10011 
la t0, vtrap_entry 
csrw mtvec,t0 
la t1, 0x1
csrs mtvec,t1 

li      t0, 8
csrrs   zero, mstatus, t0 
li      t0, 0x80
csrrs   zero, mie, t0  
 
li t6,mtimecmp    
addi t4, t4, 900
slli t4, t4,63
lui t4, 0x80000
addi t4, t4, 999
la t2, mtime     
ld t3, 0(t2)    

add t3,t4,t3   
sd t3, 0(t6)   

.p2align 2
here: j here

.p2align 2
vtrap_entry:  
j here #u_sw_int_handler
nop
j here #s_sw_int_handler
nop
j here #h_sw_int_handler
nop
j here #m_sw_int_handler
nop
j here #u_ti_int_handler
nop
j here #s_ti_int_handler
nop
j here #h_ti_int_handler
nop
j m_ti_int_handler
nop
j here #u_ex_int_handler
nop
j here #s_ex_int_handler
nop
j here #h_ex_int_handler
nop
j here #m_ex_int_handler
nop

.p2align 2
m_ti_int_handler:
	addi sp, sp, -32*4
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

	# update mcause and mepc
	la t1, _data
	csrr t2, mcause
	sw t2, 0(t1)
	csrr t2, mepc
	sw t2, 4(t1)

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
	addi sp, sp, 32*4

	li t6,mtimecmp    
	andi t3,t3,0
	addi t3,t3,-1
	sd t3, 0(t6)
	j here

_data:
	.word 	0
	.word 	0