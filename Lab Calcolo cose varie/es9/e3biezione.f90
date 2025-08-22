module bisezione
implicit none 
real :: z
contains

function f1(x) result(f)
real :: f 
real,intent(in) :: x
f=x**2-z
end function f1

recursive function bis(a,b,k,fun) result(m)
real,intent(in) :: a , b ,  k
real :: c , fa , fb , m 

interface
function fun(x) result(f)
real,intent(in) :: x 
real :: f
end function fun
end interface

c=(a+b)/2
fa=fun(a)
fb=fun(b)
m=fun(c)
if (m==0) then 
print*,"gli zeri della funzione sono :" , c , -c
print*, "la radice quadrata del numero è :" , sqrt(z)
stop
else if(abs(m)<k) then
print*, "gli zeri della funzione sono:" , c , -c
print*, "la radice quadrata del numero è :" , sqrt(z)
stop
else if (((m<0) .and. (fa>0)) .or. ((m>0) .and. (fa<0))) then
m=bis(a,c,k,fun)
else if (((m<0) .and. (fb>0)) .or. ((m>0) .and. (fb<0))) then
m=bis(c,b,k,fun)
end if

end function bis

end module bisezione

program root
use bisezione
implicit none
real :: e1 , e2  , k , y 

print*, "IMMETTERE L'ESTREMO INFERIORE DELL'INTERVALLO :"
read*, e1
print*, "IMMETTERE L'ESTREMO SUPERIORE DELL'INTERVALLO:" 
read*, e2
print*, "IMMETTERE L'ORDINE DI GRANDEZZA MINIMO DEL VALORE MEDIO :"
read*, k
print*, "IMMETTERE IL VALORE DEL NUMERO DI CUI CALCOLARE LA RADICE QUADRATA:"
read*,z


y=bis(e1,e2,k,f1) 




end program root
