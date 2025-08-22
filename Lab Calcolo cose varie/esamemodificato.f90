!Qua si trovano le funzioni che ho scelto 
module funzioni
implicit none
integer, parameter ::rk = SELECTED_REAL_KIND(3)
real, parameter ::pi = 4*atan(1.d0)

contains
function f1(x) result(res)
    real(kind=rk)::x,res
    res = (x**4-2*x**2+5)*(sin(x))**2+x**3*sin(x) !funzione dispari con seno
end function

function f2(x) result(res)
    real(kind=rk)::x, res
    res = 3*cos(2*(x))+5*(x) !funzione dispari con coseno
end function

function f3(x) result(res)
    real(kind=rk)::x, res
    res = 4*log10(x)+1/(1+x**2) !funzione logaritmica
end function
end module 

module err_check
use funzioni
implicit none
!dichiarazione dei valori minmi e ottimali, public e save così persistono tra chiamate e il programma principale li vede
real(kind=rk), public, save::min_err_f1_p1=1000
real(kind=rk), public, save::h_optimal_f1_p1=0.0

real(kind=rk), public, save::min_err_f1_p2=1000
real(kind=rk), public, save::h_optimal_f1_p2=0.0

real(kind=rk), public, save::min_err_f1_p3=1000
real(kind=rk), public, save::h_optimal_f1_p3=0.0

real(kind=rk), public, save::min_err_f2_p1=1000
real(kind=rk), public, save::h_optimal_f2_p1=0.0

real(kind=rk), public, save::min_err_f2_p2=1000
real(kind=rk), public, save::h_optimal_f2_p2=0.0

real(kind=rk), public, save::min_err_f2_p3=1000
real(kind=rk), public, save::h_optimal_f2_p3=0.0

real(kind=rk), public, save::min_err_f3_p1=1000
real(kind=rk), public, save::h_optimal_f3_p1=0.0

real(kind=rk), public, save::min_err_f3_p2=1000
real(kind=rk), public, save::h_optimal_f3_p2=0.0

real(kind=rk), public, save::min_err_f3_p3=1000
real(kind=rk), public, save::h_optimal_f3_p3=0.0

contains
subroutine err_check1(err1, err2, err3, h)
    real(kind=rk), intent(in)::err1, err2, err3, h

    !check per vedere se l'errore e` minore di quello globale
    !in caso affermativo si salva h_ottimale
    if(err1<min_err_f1_p1) then
    min_err_f1_p1 = err1
    h_optimal_f1_p1 = h
    end if

    if(err2<min_err_f1_p2) then
    min_err_f1_p2 = err2
    h_optimal_f1_p2 = h
    end if

    if(err3<min_err_f1_p3) then
    min_err_f1_p3 = err3
    h_optimal_f1_p3 = h
    end if    
end subroutine

subroutine err_check2(err1, err2, err3, h)
    real(kind=rk), intent(in)::err1, err2, err3, h

    if(err1<min_err_f2_p1) then
    min_err_f2_p1 = err1
    h_optimal_f2_p1 = h
    end if

    if(err2<min_err_f2_p2) then
    min_err_f2_p2 = err2
    h_optimal_f2_p2 = h
    end if

    if(err3<min_err_f2_p3) then
    min_err_f2_p3 = err3
    h_optimal_f2_p3 = h
    end if    
end subroutine

subroutine err_check3(err1, err2, err3, h)
    real(kind=rk), intent(in)::err1, err2, err3, h

    if(err1<min_err_f3_p1) then
    min_err_f3_p1 = err1
    h_optimal_f3_p1 = h
    end if

    if(err2<min_err_f3_p2) then
    min_err_f3_p2 = err2
    h_optimal_f3_p2 = h
    end if

    if(err3<min_err_f3_p3) then
    min_err_f3_p3 = err3
    h_optimal_f3_p3 = h
    end if
end subroutine
end module

!Questa subroutine calcola le tre derivate prendendo un punto x e un 'errore' h 
!e la calcola attraverso una subroutine che poi da i 3 risultati deriv1,deriv2,deriv3
module derivate
use funzioni
use err_check
implicit none

contains 
subroutine df1(x, h, derivvalue, counter)
    real(kind=rk),intent(in)::x,h, derivvalue
    integer, intent(in)::counter
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, err4

    !calcolo della derivata con i tre metodi
    deriv1 = (f1(x+h)-f1(x))/h
    deriv4 = (f1(x)-f1(x-h))/h
    deriv2 = (f1(x+h)-f1(x-h))/(2*h)
    deriv3 = (8*(f1(x+h)-f1(x-h))-(f1(x+2*h)-f1(x-2*h)))/(12*h)

    !calcolo dell'errore assoluto
    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue
    err4 = deriv4 - derivvalue

    call err_check1(abs(err1), abs(err2), abs(err3), h)
    !scrittura di tutto su un file di testo distinto per ogni punto
    write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3, err4
end subroutine
subroutine df2(x, h, derivvalue, counter)
    real(kind=rk),intent(in)::x,h, derivvalue
    integer, intent(in)::counter
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, err4

    deriv1 = (f2(x+h)-f2(x))/h
    deriv4 = (f2(x)-f2(x-h))/h
    deriv2 = (f2(x+h)-f2(x-h))/(2*h)
    deriv3 = (8*(f2(x+h)-f2(x-h))-(f2(x+2*h)-f2(x-2*h)))/(12*h)

    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue
    err4 = deriv4 - derivvalue

    call err_check2(abs(err1), abs(err2), abs(err3), h)
    write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3, err4
end subroutine
subroutine df3(x, h, derivvalue, counter)
    real(kind=rk),intent(in)::x,h, derivvalue
    integer, intent(in)::counter
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, err4

    deriv1 = (f3(x+h)-f3(x))/h
    deriv4 = (f3(x)-f3(x-h))/h
    deriv2 = (f3(x+h)-f3(x-h))/(2*h)
    deriv3 = (8*(f3(x+h)-f3(x-h))-(f3(x+2*h)-f3(x-2*h)))/(12*h)

    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue
    err4 = deriv4 - derivvalue

    call err_check3(abs(err1), abs(err2), abs(err3), h)
    write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3, err4
end subroutine
end module

!programma principale che serve per chiamare la subroutine per 
!calcolare le derivate nei tre 3 diversi
program pippo
use funzioni
use derivate
implicit none
    real(kind=rk), dimension(9):: x
    real(kind=rk)::h
    integer:: i
    integer, parameter::scale = 1E7 !Usato 1E7

    !scegliamo i 3 valori e poi il valore di h che sarà uguale per tutti per paragonarli
    x = [2.34654, 7.36143, 50.0, &
      pi, 8.8, 7.5, &
      -pi,-8.8, 0.01]

do i = 1*scale, 1 ,-1000
    h=i*0.00000001
    call df1(x(1), h, derivvalue = 0.0_rk, counter = 10) !cella 1,1, funzione 1
    call df2(x(2), h, derivvalue = 0.00002492587_rk, counter = 11) !cella 1,2, funzione 2
    call df3(x(3), h, derivvalue = 0.03472757134_rk, counter = 12) !cella 1,3, funzione 3

    call df1(x(4), h, derivvalue = -31.0062766803_rk, counter = 13) !cella 2,1, funzione 1
    call df2(x(5), h, derivvalue = 10.69306698751_rk, counter = 14) !cella 2,2, funzione 2
    call df3(x(6), h, derivvalue = 0.22704715192_rk, counter = 15) !cella 2,3, funzione 3

    call df1(x(7), h, derivvalue = 31.0062766803_rk, counter = 16) ! cella 3,1, funzione 1
    call df2(x(8), h, derivvalue = -0.69306698751_rk, counter = 17) !cella 3,2 funzione 2
    call df3(x(9), h, derivvalue = 173.697796760_rk, counter =18) !cella 3,3 funzione 3
end do

!check per verificare se viene fuori NaN
!if(f3(x3(3)-h)/=f3(x3(3)-h)) then
!print*, 'This number is NaN'
!end if

!scrittura dei valori ottimali su un file apparte
write(unit=20, fmt=*) h_optimal_f1_p1, h_optimal_f1_p2, h_optimal_f1_p3, h_optimal_f2_p1, h_optimal_f2_p2, h_optimal_f2_p3, h_optimal_f3_p1, h_optimal_f3_p2, h_optimal_f3_p3
end program