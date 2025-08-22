program sort
    implicit none

   !integer::array_random(100)
    !call random_number(array_random)

    integer, dimension(4) ::array_test
    integer::a,b

    array_test = (/1,2,3,4/)

    a = array_test(1:1)
    b = array_test(1:2)
    write (*,*) a+b
    
end program

!subroutine swap(x,y)
!    integer intent(out)::x,y
!    integer::buffer
!    buffer = x
!    x = y
!    y = buffer 
!end subroutine

!subroutine increment(var, incr)
!    implicit none
!    integer(inout)::var
!    integer(in)::incr
!    var = var + incr
!end subroutine