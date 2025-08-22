!Qua si trovano le funzioni che ho scelto 
module funzioni
implicit none
integer, parameter ::rk = SELECTED_REAL_KIND(4) !così si può facilmente cambiare la precisione che si vuole
real, parameter ::pi = 4*atan(1.d0)

contains
function f1(x) result(res)
    real(kind=rk)::x,res
    res = (x**4-2*x**2+5)*(sin(x))**2+x**3*sin(x) !funzione pari con seno
end function

function f2(x) result(res)
    real(kind=rk)::x, res
    res = 3*cos(2*(x))+5*(x) !dispari pari con coseno
end function

function f3(x) result(res)
    real(kind=rk)::x, res
    res = 4*log10(x)+1/(1+x**2) !funzione logaritmica
end function
end module 

module err_check
use funzioni
implicit none
!dichiarazione degli errori minmi e valori di h ottimali, save così persistono tra chiamate 
real(kind=rk), dimension(9), save::min_err_fp=1000
real(kind=rk), dimension(9), save::h_optimal_fp=0.0
character(len=11), dimension(9), save::metodo_migliore_fp

contains
subroutine err_checker(min_err, h, counter, metodo)
    real(kind=rk), intent(in):: min_err, h
    integer, intent(in)::counter
    character(len=11)::metodo
    !per associare ad un elemento dell'array 'min_err_fp' a partire dal counter
    integer::id

    id = counter-9
    !check per vedere se l'errore e' minore di quello globale si usa il valore di
    !id per prendere il valore minimo corrispondente al counter e verificare se 
    !l'errore calcolato da quella iterazione do e' minore di quello globale salvato
    select case (counter)  !programma sceglie il caso
    case(10)
        if (min_err<min_err_fp(id)) then  !se l'errore passato è minore di quello globale
            min_err_fp(id) = min_err      !questo errore viene salvato
            h_optimal_fp(id) = h          !il valore di h ottimale viene salvato
            metodo_migliore_fp(id)=metodo !si salva il metodo migliore
        end if
    case(11)
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(12) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(13) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(14) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(15) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(16) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(17) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    case(18) 
        if (min_err<min_err_fp(id)) then
            min_err_fp(id) = min_err
            h_optimal_fp(id) = h
            metodo_migliore_fp(id)=metodo
        end if
    end select 
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
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, min_err
    character(len=11)::metodo

    !calcolo della derivata con i tre metodi
    deriv1 = (f1(x+h)-f1(x))/h
    deriv4 = (f1(x)-f1(x-h))/h
    deriv2 = (f1(x+h)-f1(x-h))/(2*h)
    deriv3 = (8*(f1(x+h)-f1(x-h))-(f1(x+2*h)-f1(x-2*h)))/(12*h)

    !calcolo dell'errore
    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue

    min_err = min(abs(err1), abs(err2), abs(err3))   !si sceglie il valore meno distante dallo zero

    if(min_err == abs(err1)) then                    !per salvare il metodo meno distante da zero
        metodo = 'Incremento'
    else if(min_err == abs(err2)) then
        metodo = 'Simmetrica'
    else if(min_err == abs(err3)) then
        metodo = 'Richardson'
    end if
    !chiamata per vedere se l'errore è minore di uello globale
    call err_checker(min_err, h, counter, metodo)
    !scrittura di tutto su un file di testo distinto per ogni punto
    !sono commentati così non creano 30GB di file ogni volta
    !write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3
end subroutine
subroutine df2(x, h, derivvalue, counter)
    real(kind=rk),intent(in)::x, h, derivvalue
    integer, intent(in)::counter
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, min_err
    character(len=11)::metodo

    deriv1 = (f2(x+h)-f2(x))/h
    deriv4 = (f2(x)-f2(x-h))/h
    deriv2 = (f2(x+h)-f2(x-h))/(2*h)
    deriv3 = (8*(f2(x+h)-f2(x-h))-(f2(x+2*h)-f2(x-2*h)))/(12*h)

    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue

    min_err = min(abs(err1), abs(err2), abs(err3))

    if(min_err == abs(err1)) then
        metodo = 'Incremento'
    else if(min_err == abs(err2)) then
        metodo = 'Simmetrica'
    else if(min_err == abs(err3)) then
        metodo = 'Richardson'
    end if
    
    call err_checker(min_err, h, counter, metodo)
    !call err_checker(x, min_err, h, counter,)
    !write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3
end subroutine
subroutine df3(x, h, derivvalue, counter)
    real(kind=rk),intent(in)::x,h, derivvalue
    integer, intent(in)::counter
    real(kind=rk):: deriv1, deriv2, deriv3, err1, err2, err3, deriv4, min_err
    character(len=11)::metodo

    deriv1 = (f3(x+h)-f3(x))/h
    deriv4 = (f3(x)-f3(x-h))/h
    deriv2 = (f3(x+h)-f3(x-h))/(2*h)
    deriv3 = (8*(f3(x+h)-f3(x-h))-(f3(x+2*h)-f3(x-2*h)))/(12*h)

    err1 = deriv1 - derivvalue
    err2 = deriv2 - derivvalue
    err3 = deriv3 - derivvalue

    min_err = min(abs(err1), abs(err2), abs(err3))
    if(min_err == abs(err1)) then
        metodo = 'Incremento'
    else if(min_err == abs(err2)) then
        metodo = 'Simmetrica'
    else if(min_err == abs(err3)) then
        metodo = 'Richardson'
    end if
    
    call err_checker(min_err, h, counter, metodo)
    !call err_checker(x, min_err, h, counter)
    !write(unit=counter, fmt=*) h, x, deriv1, deriv2, deriv3, deriv4, err1, err2, err3
end subroutine
end module

!programma principale che serve per chiamare la subroutine per 
!calcolare le derivate nei tre 3 punti diversi
program pippo
use funzioni
use derivate
implicit none
    real(kind=rk), dimension(9):: x, derivvalue
    real(kind=rk)::h
    integer:: i
    integer, parameter::scale = 1E7!Usato 1E7

    !scegliamo i 3 valori e poi il valore di h che sarà uguale per tutti per paragonarli
    x = [2.34654, 7.36143, 50.0, &
         pi, 8.8, 7.5, &
        -pi,-8.8, 0.01]

    !valori attesi delle derivate in ogni punto
    derivvalue = [0.0, 0.00002492587, 0.03472757134, &
                  -31.0062766803, 10.69306698751, 0.22704715192, &
                   31.0062766803, -0.69306698751, 173.697796760]

do i = 1*scale, 1 ,-1
    h=i*(0.1/scale)
    call df1(x(1), h, derivvalue(1), 10) !cella 1,1, funzione 1
    call df2(x(2), h, derivvalue(2), 11) !cella 1,2, funzione 2
    call df3(x(3), h, derivvalue(3), 12) !cella 1,3, funzione 3

    call df1(x(4), h, derivvalue(4), 13) !cella 2,1, funzione 1
    call df2(x(5), h, derivvalue(5), 14) !cella 2,2, funzione 2
    call df3(x(6), h, derivvalue(6), 15) !cella 2,3, funzione 3

    call df1(x(7), h, derivvalue(7), 16) ! cella 3,1, funzione 1
    call df2(x(8), h, derivvalue(8), 17) !cella 3,2 funzione 2
    call df3(x(9), h, derivvalue(9), 18) !cella 3,3 funzione 3
end do

!scrittura dei valori ottimali su un file apparte
write(unit=20, fmt=*) h_optimal_fp
write(unit=20, fmt=*) metodo_migliore_fp
end program