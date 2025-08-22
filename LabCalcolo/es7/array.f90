program test
implicit none
real, dimension(3,2):: array1

    call random_number(array1)

print*, array1
print*, array1(1,1), array1(2,1), array1(3,1)

end program