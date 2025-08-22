module mod_calcolo
    implicit none
    
    contains
    real function calcolo(dati, pesi) result (res)
        real, dimension(:), intent(in)::dati, pesi 
        integer :: grandezza
        real:: total_sum
    
        grandezza = size(dati)
    
        total_sum = sum(dati*pesi)/sum(pesi)

        !do i = 1, grandezza
        !    total_sum = (dati(i)*pesi(i))/sum(pesi)
        !end do
    
        res = total_sum
    end function
end module mod_calcolo
        

program mediapesata
use mod_calcolo
implicit none 
    real, dimension(:), allocatable :: dati, pesi
    integer :: N, i

    Print*, 'Quanti dati?'
    read*, N
    allocate(dati(N), pesi(N))

    do i = 1,N
        print*, 'Dato e Peso', i
        read*, dati(i), pesi(i)
    end do 

    print*, "Media pesata è", calcolo(dati, pesi)

end program

