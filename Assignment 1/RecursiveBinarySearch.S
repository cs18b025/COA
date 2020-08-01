.data
_success1: .string "Element "
_success2: .string " found at index "
_fail_string1: .string "Element "
_fail_string2: .string " does not exist in given array!"
_array:   .word 1, 2, 4, 5, 7, 8, 9, 12, 13, 15, 17, 19, 20, 21, 30
_array_size: .word 15
_search_element:.word 9
.text


_main:
    	# binarySearch(int arr[], int l, int r, int x)  
    addi 	t0, zero, 0    		# int l
    la   	t1, _array_size  
    lw   	t1, 0(t1)     	 	# int r
    addi 	t1, t1, -1
    add  	s10, t1, zero   	# s10 used to check if search is going out of array bounds
    addi 	a5, zero, -1
    la   	s2, _search_element
    lw   	s2, 0(s2)               # s2 stands for search value
    la   	s0, array           	# load the base address to $s0
    jal  	ra, _binary_search      # Jump-and-link to the 'binarySearch' label
    bltz 	a5, _fail		# Check if found or not
    j 		_exit


_binary_search:
    	# a2 stand for mid = (l + r)/2
    add  	a2, t0, t1
    srli 	a2, a2, 1

    	#check if mid > array_size
    blt 	s10, a2, _fail

    	#check if mid < 0
    bltz 	a2, _fail

    	# check if array[mid]== search_element
    add  	t2, a2, zero
    slli 	t2, t2, 2 # t2=t2*4
    add  	t2, t2, s0 
    lw   	t2, 0(t2)
    beq  	t2, s2, _find

    	# check if to == t1 and still not equal
    beq 	t0, t1, _fail

    	#not equal then adjust l,r depends on the value of array[mid]
    blt  	s2, t2, _less


_greater: 
	#elseif target > array[mid] : l = mid + 1
    addi 	t0, a2, 1
    j 		_binary_search


_less: 
	# @if target<array[mid] : r = mid-1
    addi 	t1, a2, -1
    j 		_binary_search
    ret


_fail:
    addi 	a5, zero, -1
    la  	a1, _fail_string1
    li  	a0, 4
    ecall

    mv       	a1, s2
    li       	a0, 1
    ecall

    la  	a1, _fail_string2
    li  	a0, 4
    ecall
    j 		_exit


_find:
    add 	a5, a2, zero
    la  	a1, _success1
    li  	a0, 4
    ecall

    mv       	a1, s2
    li       	a0, 1
    ecall

    la  	a1, _success2
    li  	a0, 4
    ecall

    mv       	a1, a5
    li       	a0, 1
    ecall
    
    j 		_exit

exit:

