/***************************************************************************

* Project           			: Assignment 4
* Name of the file	     		: COA_A4_P2
* Brief Description of file     : Assembly code to implement a triple layered page table and illustrate protection
* Name of Author    	        : M Harini Saraswathy
* Roll No 						: CS18B025 

Page 1:
	machine mode code where  
		* instruction access fault is delegated to supervisor mode
		* triple layered page table is implemented
		* pmpcfg and pmpaddr are set according to our needs

Page 2:
	supervisor code where
		* protection is illustrated via instruction access fault which is seen in the value of a1 (a1 = 1 for iaf)
		* page miss is illustrated and shown in the value of a0 (a0 = 12 for page fault)

Page 3:
	supervisor trap entry where
		*page entry for second page is set to aid the illustration of page miss

***************************************************************************/


#------PAGE 1 START-----------------------------------

#loaded at 0x10010000

_start:

	#setting sp value
	lui sp, 0x10014

	#loading address of machine trap entry
	la t0, mtrap_entry
	csrw mtvec, t0

	#loading address of supervisor trap entry
	la t0, strap_entry
	csrw stvec, t0

	#supervisor mode will be used to illustrate instruction access fault
	li t3, 0x1000
	csrw medeleg, t3

	#setting up triple layered page table

	#level 0 page table uses vpn[0]
	li t0, 0x10020000
	li t1, 0x4008401
	sd t1, 0(t0)

	#level 1 page table uses vpn[1]
	li t0, 0x10021400
	li t1, 0x4008801
	sd t1, 0(t0)

	#level 2 page table uses vpn[2]
	#instances of vpn[2]
	li t0, 0x10022080
	li t1, 0x400404f
	sd t1, 0(t0)

	#instances of vpn[2]
	li t0, 0x10022090
	li t1, 0x400484f
	sd t1, 0(t0)

	#instances of vpn[2]
	li t0, 0x10022110
	li t1, 0x40088cf
	sd t1, 0(t0)

	#_start to mtrap_entry is to be protected
	#setting pmp addresses similar to assignment 4.1
	la t0, mtrap_entry
	srli t0, t0, 2
	csrw pmpaddr0, t0

	li t0, 0x11110000
	srli t0, t0, 2
	csrw pmpaddr1, t0

	#setting pmp configurations similar to assignment 4.1
	li t0, 0xffffff
	csrrc x0, pmpcfg0, t0
	li t0, 0xf08
	csrrs x0, pmpcfg0, t0

	#Paging is enabled by setting up satp appropriately
	li t0, 0
	addi t0, t0, 8
	slli t0, t0, 60
	li t1, 0x10020000
	srli t1, t1, 12
	or t0, t1, t0
	csrw satp, t0

	#Privilege level transition from machine to supervisor
	li t0, 0x1800
	csrrc x0, mstatus, t0
	li t0, 0x0800
	csrrs x0, mstatus, t0
	la t0, supervisor_module
	csrw mepc, t0

	#return to previous privilege level
	mret

.p2align 2
mtrap_entry:
	la t0, _infi_loop
	csrw mepc, t0
	mret

#-------PAGE 1 END------------------------------------


#-------PAGE 2 START----------------------------------

#loaded at 0x10011000
.p2align 12
supervisor_module:
	#namesake instruction to check functionality
	li t0, 5
	
	#protection is shown as instruction access fault is called when trying to access machine level privileged information from supervisor mode
	j _start

	#infinite loop
	_infi_loop:
	j _infi_loop

#------PAGE 2 END-------------------------------------


#------PAGE 3 START-----------------------------------

#loaded at 0x10012000
.p2align 12
strap_entry:
	li t0, 0x10022088
	li t1, 0x400444f
	sd t1, 0(t0)
	sret

#------PAGE 3 END-------------------------------------