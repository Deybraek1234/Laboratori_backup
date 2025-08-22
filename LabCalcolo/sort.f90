program sort
    implicit none
    real, dimension(4096) :: array
    real:: buffer
    integer:: i,j

    call random_number(array)
    print *,' Random numbers',array*100
    do i = 1,4096
        do j = 1,4096-i
            if (array(j)>array(j+1)) then
                call swap(array(j), array(j+1))
            endif
        enddo
    enddo
        print *, 'Sorted array', array*100

end program

subroutine swap(x,y)
    real::x,y
    real ::buffer
    buffer = x
    x = y
    y = buffer
end subroutine