module rand 
implicit none
contains 
subroutine swap(x,y)
    real::x,y
    real ::buffer
    buffer = x
    x = y
    y = buffer
end subroutine

subroutine media(data,n_dati)
    real::med
    real, dimension(100)::numeri
    real, dimension(:), intent(out)::data
    integer :: i, j
    integer, intent(in)::n_dati
    med = 0

    do i = 1,n_dati
    call random_number(numeri)
    med = sum(numeri)/100
    data(i) = med
    end do

    do i = 1,n_dati
        do j = 1,n_dati-i
            if (data(j)>data(j+1)) then
                call swap(data(j), data(j+1))
            endif
        enddo
    enddo

    do i = 1,n_dati
        write(2,*) data(i)
    end do
end subroutine
end module


program istogramma
use rand
implicit none
    integer::n_dati, i, fuori, nbin, ind, ios
    real, dimension(:), allocatable::histo
    real, dimension(:), allocatable ::dato
    real::dati
    real::dx,xmin,xmax, currentLine
    
    print*, 'Quanti dati?'
    read*, n_dati

    allocate(dato(n_dati))

    call media(dato,n_dati)

    read(2,*) xmin

    do i = 1, n_dati
        read(2, *) currentLine
        xmax = currentLine
    end do

    print*, xmax, xmin
    dx = (xmax-xmin)/n_dati

    do i = 1,n_dati
  read(2,*)dati
  ind = int((dati-xmin)/dx) + 1
  if ( ind>nbin .or. ind <1)then
    fuori = fuori + 1
  else
    histo(ind) = histo(ind) + 1
  end if
end do

do i=1,nbin
  write(2,*) i, xmin+(i-1)*dx+dx/2,real(histo(i))/n_dati*nbin
end do

end program