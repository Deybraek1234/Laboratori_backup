module mod0
implicit none
contains
    function fibi(n) result (res)
        integer, intent(in) ::n
        integer :: i, res
        real :: buffer, last_num
        
        last_num = 1
        res = 1
        do i = 1,n
            buffer = res
            res = last_num + res
            last_num = buffer
        end do
        res = res
    end function
end module

program fib
use mod0
implicit none
    integer :: res, n

    Print*, 'How many sums'
    read*, n
    print*, fibi(n)
end program



