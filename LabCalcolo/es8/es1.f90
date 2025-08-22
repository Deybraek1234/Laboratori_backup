module mod0
implicit none

contains
    recursive function ricerca(a,b) result(mcd)
    integer, intent(in)::a,b
    integer:: mcd

    if(a==0) then
        mcd = b
    else if(b == 0) then
        mcd = a
    else if (mod(a,b)==0) then
        mcd = b
    else 
        mcd = ricerca(b,mod(a,b))
    end if

end function
end module

program minimo
    use mod0
implicit none
    integer :: a, b, c

    Print*, 'Scrivi i due numeri'
    read*, a, b

    if (a==0 .and. b==0) then
        stop
    else
    c=ricerca(a,b)
    end if

    print*, c
end program 