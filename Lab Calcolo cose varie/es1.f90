program dotproduct
   implicit none
   real, dimension(2) ::a, b, c, d, e
   real:: product_a, product_b, product_ab, modulo_a, modulo_b, theta_rad, theta_grad
   real, parameter :: pi=4*ATAN(1.d0)
   integer :: i

   print*, 'Vettore a'
   read*, a
   print*, 'Vettore b'
   read*, b

   !Prodotto Scalare
   do i = 1, 2
      product_a = product_a + a(i)*a(i)
      product_b = product_b + b(i)*b(i)
      product_ab = product_ab + a(i)*b(i)
   end do

   d = a*a
   e = b*b
   c = a*b
   print*, c

   Print*, 'Ciclo do ', ' Funzione dotproduct ', ' Funzione sum'
   print*, product_a, dot_product(a,a), sum(d)
   print*, product_b, dot_product(b,b), sum(e)
   print*, product_ab, dot_product(a,b), sum(c)

   !modulo
   modulo_a = sqrt(a(1)**2 + a(2)**2)
   modulo_b = sqrt(b(1)**2 + b(2)**2)

   print*, 'Modulo a', modulo_a
   print*, 'Module b', modulo_b
   aoeuaoeua

   !angolo
   theta_rad = acos(dot_product(a,b)/(modulo_a*modulo_b))
   theta_grad = theta_rad*180/pi
   print*, 'angolo radianti', theta_rad
   print*, 'angolo gradi', theta_grad
end program
