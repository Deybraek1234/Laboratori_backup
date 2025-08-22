program practice_array
implicit none
    real, allocatable :: array (:)
    integer :: array_size

    read*, array_size
    allocate(array(array_size))
    call random_number(array)

    

end program practice_array

subroutine sort(array, array_size)
    real, allocatablee, array(:)

    