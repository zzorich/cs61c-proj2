.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    li t0 1
    bge a2 t0 else1
    li a0 36
    j exit

else1:
    bge a3 t0 else2
    li a0 37
    j exit
    
else2:
    bge a4 t0 loop_start
    li a0 37
    j exit


loop_start:
    li t0 0 #t0 track the index
    li t1 0 #t1 record the sum
    li t4 4 #t4 = 4, constant 4 
loop_countinue:
    bge t0 a2 loop_end
    mul t2 t0 a3
    mul t2 t2 t4
    
    mul t3 t0 a4
    mul t3 t3 t4
    
    add t2 t2 a0
    add t3 t3 a1
    
    lw t2 0(t2)
    lw t3 0(t3)
    
    mul t2 t2 t3
    add t1 t1 t2
    
    addi t0 t0 1
    j loop_countinue


loop_end:
    mv a0 t1

    # Epilogue


    jr ra
