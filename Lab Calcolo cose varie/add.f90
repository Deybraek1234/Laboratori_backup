program area_circle
    implicit none

    real, parameter :: pi = 3.14

    type circle
        real :: r
    end type circle

    type(circle) :: circle1

    print *, 'Input radius'
    read(*,*) = circle1%r 

    write (*,*) = pi*r**2
end program area_circle
