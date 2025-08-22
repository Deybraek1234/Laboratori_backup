program quadratic
    implicit none
    real :: a,b,c
    complex :: Delta
    real :: x1,x2
    complex :: c1,c2
    complex :: Delta_neg
    do
        Print *, 'Input integers in the form ax**2 + bx +c'
        read *, a,b,c 
         if (realpart(Delta(a,b,c))>0) then
            x1 = ((-b+sqrt(real(Delta(a,b,c))))/2*a)
            x2 = ((-b-sqrt(real(Delta(a,b,c))))/2*a)
            Print *, 'x1 = ', x1, 'x2 = ', x2
        else if (realpart(Delta(a,b,c)) == 0) then
            x1 = -b/(2*a)
            Print *, 'x = ', x1
        else
            c1 = ((-b+sqrt(Delta(a,b,c)))/(2*a))
            c2 = ((-b-sqrt(Delta(a,b,c)))/(2*a))
            Print *, 'x1 = ', c1, 'x2 = ', c2
        end if
    enddo
end program quadratic

function Delta(x,y,z)
    complex :: delta
    real, intent(in)::x,y,z
    delta = (y**(2)-4*x*z)
end function Delta 