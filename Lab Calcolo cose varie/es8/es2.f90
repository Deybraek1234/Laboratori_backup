module geom
implicit none

type :: punto
    real ::x,y
end type punto

type :: triangolo
    type(punto) :: vertice_A
    type(punto) :: vertice_B
    type(punto) :: vertice_C
end type triangolo
 
interface operator (+)
    module procedure sum_points
end interface operator (+)

interface operator (*)
    module procedure scala
end interface operator(*)

interface operator (-)
    module procedure invert
end interface operator (-)


contains
function sum_points(p,q) result(r)
type(punto), intent(in) :: p,q
type(punto)             :: r
r%x = p%x + q%x
r%y = p%y + q%y
end function sum_points

function invert(p) result(r)
type(punto), intent(in) :: p
type(punto) :: r
r%x = -p%x
r%y = -p%y
end function invert

function scala(p,s) result(r)
    type(punto), intent(in)::p
    real, intent(in):: s
    type(punto)::r

    r%x = p%x * s
    r%y = p%y * s
end function scala
end module geom


program piano
use geom
implicit none
type(punto) :: A,B,C
type(triangolo) :: T1, T2, T3

print*,'coordinate 2D primo vertice'
read*,A
print*,'coordinate 2D secondo vertice'
read*,B
print*,'coordinate 2D terzo vertice'
read*,C
T1 = triangolo(A,B,C)  ! il nome del tipo dati "costruisce" una variabile 
                       ! dello stesso tipo a partire dai 3 campi  
print*,' vertice A: ',T1%vertice_A
print*,' vertice B: ',T1%vertice_B
print*,' vertice C: ',T1%vertice_C


T2%vertice_A = invert(T1%vertice_A)
T2%vertice_B = invert(T1%vertice_B)
T2%vertice_C = invert(T1%vertice_C)

T3%vertice_A = (T2%vertice_A + T2%vertice_B) * 0.5
T3%vertice_B = (T2%vertice_B + T2%vertice_C) * 0.5
T3%vertice_C = (T2%vertice_C + T2%vertice_A) * 0.5

write(unit=20,fmt=*) T2%vertice_A
write(unit=20,fmt=*) T2%vertice_B
write(unit=20,fmt=*) T2%vertice_C
write(unit=20,fmt=*) T2%vertice_A
write(unit=20,fmt=*) 
write(unit=20,fmt=*) 
write(unit=20,fmt=*) T3%vertice_A
write(unit=20,fmt=*) T3%vertice_B
write(unit=20,fmt=*) T3%vertice_C
write(unit=20,fmt=*) T3%vertice_A
print*,'coppie di coordinate dei vertici del triangolo T2', T2

end program piano
