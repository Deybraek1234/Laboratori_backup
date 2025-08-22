module gravitazione
implicit none
integer,parameter :: kr=selected_real_kind(15), nbody=2
real(kind=kr),parameter :: G=6.673E-11_kr  ! costante di gravitazione universale in unita' SI
real(kind=kr),dimension(nbody) :: mass

contains
  subroutine interazione(pos,f,epot)
! questa subroutine andrà chiamata in sostituzione delle linee del programma dell' oscillatore
! in cui veniva calcolata la forza e l'energia potenziale
   real(kind=kr), intent(in), dimension(:,:) :: pos
   real(kind=kr), intent(out) :: epot
   real(kind=kr), intent(out), dimension(:,:) :: f
   real(kind=kr), dimension(size(pos,1)) :: posij
   real(kind=kr) :: rij
   integer ::i,j
   epot = 0
   f    = 0
   do i=1,nbody
      do j=1,nbody
         if( i==j ) cycle
         posij(:)  = pos(:,j)-pos(:,i)
         rij=sqrt( dot_product(posij,posij) )
         epot   = epot   -(G*mass(i)*mass(j))/rij
         f(:,i) = f(:,i) +(G*mass(i)*mass(j)) * posij(:)/rij**3
      end do
   end do
   epot = epot/2    ! divisione per 2 perche' tutti i contributi di
                    ! ciascuna coppia sono stati contati due volte: (i,j) e (j,i)                                                            

  end subroutine interazione
end module gravitazione

program oscillatore
use gravitazione, massa => mass
    implicit none
        
     !real    :: kappa=1.0 ! valori di default per massa e cost. elastica
     real(kind=kr)    :: dt,ekin,epot
     real(kind=kr), dimension(3,nbody):: pos,vel,f !prima componente x seconda y
     integer :: nstep,it
     write(unit=*,fmt="(a)",advance="no")"delta t : "   ! il formato (a) chiede che il dato sia trattato come 
     read*,dt                                           ! caratteri e advance="no"  sopprime il  
     write(unit=*,fmt="(a)",advance="no")"n.step: "     ! carattere "a capo"  alla fine della linea per cui 
     read*,nstep                                        ! la prossima operazione di lettura/scrittura inzia
     write(unit=*,fmt="(a)",advance="no")"massa: "      ! sulla stessa riga di schermo di quella corrente
     read*,massa
     !write(unit=*,fmt="(a)",advance="no")"kappa: "
     !read*,kappa
     write(unit=*,fmt="(a)",advance="no")"pos(0)(x,y,z): "
     read*,pos
     write(unit=*,fmt="(a)",advance="no")"vel(0)(x,y,z): "
     read*,vel
    
     it=0        ! step 0 : valori iniziali
    
     write(unit=1,fmt=*)it,it*dt,pos,vel
     call interazione(pos,f,epot)
     ekin =  sum(0.5 * spread(massa,1,3) * vel**2)/2
     write(unit=2,fmt=*)it,dt*it,ekin,epot,ekin+epot
     
     do it = 1,nstep
        pos = pos + vel * dt + 0.5* f/spread(massa,1,3) * dt**2
        vel = vel + 0.5 * dt * f/spread(massa,1,3)         !  prima parte della formula per le velocita'
        call interazione(pos,f,epot)
        vel = vel + 0.5 * dt * f/spread(massa,1,3)         !  la formula per le velocita' viene completata qui
        write(unit=1,fmt=*)it,it*dt,pos,vel
        ekin = sum(0.5 * spread(massa,1,3) * vel**2)
        write(unit=2,fmt=*)it,it*dt,ekin,epot,ekin+epot
     end do
    
    end program
    