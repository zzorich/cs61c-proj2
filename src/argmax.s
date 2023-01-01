.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li t0 1
    bge a1 t0 loop_start
    li a0 36
    j exit   

loop_start:
    addi t0 a0 0  # t0 is the starting address of array
    li t1 0 # t1 is the index

    lw t2 0(a0) # t2 store the maximal ele
    addi t3 t1 0 # t3 store the maximal index
    
    addi t1 t1 1
    addi t0 t0 4

loop_continue:
    bge t1 a1 loop_end
    
    lw t4 0(t0)
    bge t2 t4 countinue
    addi t2 t4 0
    addi t3 t1 0

countinue:
    addi t1 t1 1
    addi t0 t0 4
    j loop_continue

loop_end:
    # Epilogue
    addi a0 t3 0

    jr ra
