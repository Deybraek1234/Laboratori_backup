program Variance
implicit none
    real :: sum, sum_squared, input, lunghezza_p
    integer :: N, i

    lunghezza_p = 0.991
    sum = 0

   print*, 'Input total number of data points:'
   read*, N
    
    call Create_array(N)


   call Calculation(sum, sum_squared, N, lunghezza_p)

end program Variance 

subroutine Create_array(N) result(average_array)
    implicit none  
    integer, intent(none)::N
    real, dimension(N) :: array

    call Readin(N)
end subroutine Create_array


subroutine Calculation(sum, sum_squared, N, lunghezza_p)
   implicit none
   INTEGER, PARAMETER :: rk = SELECTED_REAL_KIND(15, 307)

      real, intent(in) :: sum, sum_squared, lunghezza_p
      integer, intent(in):: N
      real(rk) ::var_periodo, standard_deviation, rN, average_periodosingolo, variance_lunghezzafilo, mean_multiperiodi, errore_g, errore_periodo, accelerazione_g, mean
      real(rk), parameter:: pi = 4*atan(1.d0)

      !per divisione tra reali
      rN = N
      !changes from relative error to variance for lunghezza_filo
      variance_lunghezzafilo = 0.001/sqrt(3.0)
      !calculates average of 5 oscillazioni
      mean_multiperiodi = sum/rN
      !calculates variance
      var_periodo = (sum_squared - (sum**2/(rN)))/(rN-1)
      !calculates stanard deviation
      standard_deviation = sqrt(var_periodo)
      !takes average of 5 oscillazioni and finds 1 oscillazione
      average_periodosingolo = mean_multiperiodi/5
      !takes the standard deviation and divides it by 5 to find error on oscillazione singolo
      errore_periodo = standard_deviation/5
      !takes average_periodo singolo and lunghezza_p and calculates g
      accelerazione_g = 4*pi**2*(lunghezza_p/average_periodosingolo**2)
      !calculates error for g
      errore_g = sqrt(accelerazione_g**2 * ((variance_lunghezzafilo**2/lunghezza_p**2)+4*(errore_periodo**2/average_periodosingolo**2)))

      print*, 'Mean is:', mean_multiperiodi
      print*, 'Variance is:', var_periodo
      print*, 'Standard Deviation is:', standard_deviation
      print*, 'Periodo singolo is:', average_periodosingolo, '+-', errore_periodo
      print*, 'G is:', accelerazione_g, '+- variansa', errore_g
end subroutine
