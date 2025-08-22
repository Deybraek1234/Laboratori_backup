module functions
implicit none
integer, parameter :: kr=SELECTED_REAL_KIND(6)

contains 
real function f(x) result(res)
    real, intent(in):: x 
    res = x**4
end function

subroutine integration(u_bound,l_bound,n_intervals)
    real(kind=kr), intent(in):: u_bound, l_bound 
    integer, intent(in)::n_intervals
    real(kind=kr):: sum_total, interval_width
    integer::i
    
    interval_width = (u_bound-l_bound)/real(n_intervals)
    sum_total = (f(u_bound)+f(l_bound))/2
    do i = 1,n_intervals-1
        sum_total = sum_total + f(i*interval_width)
    end do

    sum_total = sum_total*interval_width
    print*, 'Integral, trapazoid rule =', sum_total
end subroutine

subroutine intsimpson(u_bound,l_bound,n_intervals)
    real(kind=kr), intent(in)::u_bound, l_bound
    integer, intent(in)::n_intervals
    real(kind=kr):: sum_total, interval_width
    integer::i

    interval_width = (u_bound-l_bound)/real(n_intervals)

    sum_total = f(u_bound)+f(l_bound)
    do i = 3, n_intervals-2, 2
        sum_total = sum_total + 2*f(l_bound+i*interval_width)
    end do
    do i = 2, n_intervals-2,2
        sum_total = sum_total + 4*f(l_bound+i*interval_width)
    end do
    sum_total = sum_total*(interval_width/3.0)
    print*, "Integral, Simpson's rule=", sum_total
end subroutine
end module


program int
use functions
implicit none
    real::u_bound, l_bound
    integer:: n_intervals

    print*, 'Lower bound?'
    read*, l_bound
    print*, 'Upper bound?'
    read*, u_bound
    print*, 'Number of intervals?(has to be even)'
    read*, n_intervals

    call integration(u_bound, l_bound, n_intervals)
    call intsimpson(u_bound, l_bound, n_intervals)
end program