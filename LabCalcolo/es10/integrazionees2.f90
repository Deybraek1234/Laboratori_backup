module functions
implicit none
integer, parameter :: kr=SELECTED_REAL_KIND(6)

contains 
real(kr) function f(x) result(res)
    real, intent(in):: x 
    res = exp(-x**(2))
end function

subroutine integration(u_bound,l_bound,n_intervals)
    real(kind=kr), intent(in):: u_bound, l_bound 
    integer, intent(in)::n_intervals
    real(kind=kr):: sum_total, interval_width
    integer::i
    
    interval_width = (u_bound-l_bound)/real(n_intervals)
    do i = n_intervals-1,1, -1
        sum_total = sum_total + f(l_bound+i*interval_width)
    end do
    sum_total = sum_total + (f(u_bound)+f(l_bound))/2
    sum_total = sum_total*interval_width
    print*, 'Integral =', sum_total
end subroutine
end module


program int
use functions
implicit none
    real::u_bound, l_bound
    integer:: n_intervals

    print*, 'Number of intervals?'
    read*, n_intervals

    u_bound = 1000
    l_bound = -1000
    call integration(u_bound, l_bound, n_intervals)
end program