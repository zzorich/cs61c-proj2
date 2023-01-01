.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================
matmul:

    # Error checks
    li t0 1
    blt a1 t0 error
    blt a2 t0 error
    blt a4 t0 error
    blt a5 t0 error
    bne a2 a4 error


    # Prologue
    addi sp sp -32
    sw ra 0(sp)
    sw s0 4(sp)
    sw s1 8(sp)
    sw s2 12(sp)
    sw s3 16(sp)
    sw s4 20(sp)
    sw s5 24(sp)
    sw s6 28(sp)
    
    mv s0 a0 #s0 points to the start of A
    mv s1 a1 #s1 is the number of row in A
    mv s2 a2 #s2 is the number of col in A
    mv s3 a3 #s3 points to the start of B
    mv s4 a4 #s4 is the number of row in B
    mv s5 a5 #s5 is the number of col in B
    mv s6 a6 #s6 points to the start of result matrix
    
    li t0 0 #row index
    

outer_loop_start:
    bge t0 s1 outer_loop_end
    li t1 0 #col index

inner_loop_start:
    bge t1 s5 inner_loop_end
    
    # calculate the dot product of t0th row of A and t1th col of B
    mul a0 t0 s2
    slli a0 a0 2
    add a0 s0 a0  # a0 now points to the start of t0th row of A
    
    slli a1 t1 2
    add a1 a1 s3 # a1 now points to the start of t1th col of B
    
    mv a2 s2
    li a3 1
    mv a4 s5
    ebreak
    
    # start dot
    addi sp sp -8
    sw t0 0(sp)
    sw t1 4(sp)
    
    jal ra dot
    ebreak
    
    lw t0 0(sp)
    lw t1 4(sp)
    addi sp sp 8
    
    #store the result a0 to d[t0][t1]
    mul t6 t0 s5
    add t6 t6 t1
    slli t6 t6 2
    add t6 s6 t6
    sw a0 0(t6)


    addi t1 t1 1
    j inner_loop_start




inner_loop_end:
    addi t0 t0 1
    j outer_loop_start


outer_loop_end:


    # Epilogue
    lw ra 0(sp)
    lw s0 4(sp)
    lw s1 8(sp)
    lw s2 12(sp)
    lw s3 16(sp)
    lw s4 20(sp)
    lw s5 24(sp)
    lw s6 28(sp)
    addi sp sp 32
    
    jr ra

error:
    li a0 38
    j exit