module metodonewton
implicit none 
real :: z
contains

function f1(x) result(f)
real :: f 
real,intent(in) :: x 
f=x**2-z
end function f1


subroutine bis(x,deltax_0,err,N,fun) 
integer :: i , j
real :: m , deltax, xp , xm , fp , fm , derivata
real,intent(inout) :: x 
real,intent(in) :: err , deltax_0
integer,intent(in) :: N

interface
function fun(x) result(f)
real,intent(in) :: x 
real :: f
end function fun
end interface
                                                                    

do i=1,N

 deltax = deltax_0
 xp = x + deltax
 xm = x - deltax
 fp = fun(xp)
 fm = fun(xm)
 derivata = ( fp - fm ) / (2*deltax)
 
m=x-(fun(x)/derivata)
if (abs(m-x)<err) then
print*, "la radice del numero immesso attraverso il metodo di Newton è :" , x 
print*, "la radice del numero immesso attraverso la funzione intrinseca è :" , sqrt(z)
stop
else 
x=m
cycle
end if
end do

end subroutine bis
end module metodonewton

program Newton
use metodonewton
implicit none
real :: deltax_0, x_0 , err 
integer :: M

print*, "IMMETTERE IL PUNTO DI PARTENZA x_0 :"
read*, x_0
print*, "IMMETTERE IL VALORE DELTAX_0 :"
read*, deltax_0
print*, "IMMETTERE IL VALORE DELL'ERRORE :"
read*, err
print*, "IMMETTERE IL NUMERO DI ITERAZIONI:"
read*, M
print*, "IMMETTERE IL VALORE DI CUI CALCOLARE LA RADICE"
read*, z
call bis(x_0,deltax_0,err,M,f1)
end program Newton
