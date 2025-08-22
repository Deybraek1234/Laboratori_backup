program circle
    implicit none
    real :: a, Area
    print *, 'Hello, please input the radius'
    read *, a 
    Print *, 'Circle''s area: ', Area(a)
end program circle
function Area(radius)
    implicit none
    real :: Area
    real :: pi=3.14
    real, intent (in)::radius
    Area = pi*radius**2
end function Area