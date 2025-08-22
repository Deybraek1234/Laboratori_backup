program demo_matrix
    real, dimension (4,5):: A,B
    call random_number(A)
    call random_number (B)
    write (*, "(*(g0))") matmul(A, transpose(B))
end program demo_matrix