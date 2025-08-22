program quadratica
    implicit none

    real ::a,b,c
    complex :: discr,xp,xm
    write (*,*) 'Input 3 variables'
    read*, a,b,c 

    discr = b**2 - 4*a*c
    xp = (-b + sqrt(discr) )/(2*a)
    xm = (-b - sqrt(discr) )/(2*a)

    print *, xp, xm
end program