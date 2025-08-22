module mymod
implicit none
integer, parameter:: rk = SELECTED_REAL_KIND(6)

contains
real function f(x, z) result(res)
    real, intent(in) :: x, z
    res = x**2-z
end function

recursive subroutine cercazeri (a,b,epsilon, tentativi, z, errore)
    real(kind=rk),intent(in)::epsilon, errore
    real(kind=rk)::x_m, z, fm
    real(kind=rk)::x_finale
    real(kind=rk), intent(inout)::a,b
    integer, intent(inout) :: tentativi
    integer :: i

    x_m = (a+b)/2.0
    fm = f(x_m,z)
    i = i+1

if (i == tentativi)then 
    print*, "Numero Massimo di iterazioni raggiunti, il tuo numero è:", x_m
    stop
else
    if (abs(fm)<=epsilon) then
        x_finale = x_m
        print*, "Il rusultato finale è", x_finale
    else
        if(fm>0)then
            b = x_m
            call cercazeri(a,x_m,epsilon, tentativi, z, errore)
        else if (fm<0) then
            a = x_m
            call cercazeri(x_m,b,epsilon, tentativi, z, errore)
        end if
    end if
end if

end subroutine
end module


program radicequadrata
use mymod
implicit none
    real::a,b, epsilon, z, errore
    integer :: tentativi

    print*, 'Numero per cui cercare la radice?'
    read*, z
    print*, 'Epsilon?'
    read*, epsilon
    print*, 'Quanti tentativi?'
    read*, tentativi

    errore = 0
    a = 0
    b = z

    print*, a,b, f(a,z), f(b,z)
    call cercazeri(a,b,epsilon, tentativi, z, errore)
end program