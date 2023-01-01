.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue
    li t0 1
    bge a1 t0 loop_start
    li a0 36
    j exit

loop_start:
    li t0 0 #t0 is the index
    addi t1 a0 0 #address of the element to be modified
    
loop_continue:
    bge t0 a1 loop_end
    lw t2 0(t1) #load a0[t0]
    
    bge t2 zero continue #set a0[t0] to 0 if a0[t0] < 0
    li t2 0
    sw t2 0(t1) 
    
continue:
    addi t0 t0 1
    addi t1 t1 4
    j loop_continue
    
loop_end:
    # Epilogue


    jr ra
