module metodonewton
implicit none 
contains

function f1(x) result(f)
real :: f 
real,intent(in) :: x 
f=x**2-6
end function f1


function f2(x) result(f)
real :: f
real,intent(in) :: x
f=2*x
end function f2



subroutine bis(x,err,N) 
integer :: i
real :: m
real,intent(inout) :: x 
real,intent(in) :: err 
integer,intent(in) :: N

do i=1,N
m=x-(f1(x)/f2(x))
if (abs(m-x)<err) then
print*, x , sqrt(6.0)
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
real :: x_0 , err , z
integer :: M

print*, "IMMETTERE IL PUNTO DI PARTENZA x_0 :"
read*, x_0
print*, "IMMETTERE IL VALORE DELL'ERRORE :"
read*, err
print*, "IMMETTERE IL NUMERO DI ITERAZIONI:"
read*, M
call bis(x_0,err,M)
end program Newton
