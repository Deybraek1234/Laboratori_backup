program istogramma
    implicit none
    real :: dx, xmin, xmax, dato
    integer, dimension(:), allocatable :: histo
    integer :: i, ind, fuori, nbin, Ndati
    character(len=100) :: line
    integer :: ios

    ! Leggi parametri istogramma
    print *, 'xmin, xmax, nbin?'
    read *, xmin, xmax, nbin

    dx = (xmax - xmin) / nbin

    ! Conta quanti dati ci sono nel file DATI
    Ndati = 0
    open(unit=1, file='DATI', status='old', action='read')
    do
        read(1, '(A)', iostat=ios) line
        if (ios /= 0) exit
        Ndati = Ndati + 1
    end do
    rewind(1)

    ! Alloca istogramma
    allocate(histo(nbin))
    histo = 0
    fuori = 0

    ! Legge dati e costruisce istogramma
    do i = 1, Ndati
        read(1,*) dato
        ind = int((dato - xmin) / dx) + 1
        if (ind < 1 .or. ind > nbin) then
            fuori = fuori + 1
        else
            histo(ind) = histo(ind) + 1
        end if
    end do

    close(1)

    ! Scrive istogramma in fort.2
    open(unit=2, file='fort.2', status='replace', action='write')
    do i = 1, nbin
        write(2,*) i, xmin + (i - 1) * dx + dx / 2, real(histo(i)) / Ndati * nbin
    end do
    close(2)

    print *, "Numero di dati fuori intervallo: ", fuori
end program istogramma
