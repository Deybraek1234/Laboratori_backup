 program harm
 implicit none

 real    :: massa=1.0  ! valori di default per massa e cost. elastica
 real    :: dt,ekin,epot
 real    :: alfa, angolo, vel, acc, lunghezza, vel_parziale
 real, parameter :: pi=4.D0*DATAN(1.D0), g = 9.80665
 integer :: nstep,it
 write(unit=*,fmt="(a)",advance="no")"delta t : "   ! il formato (a) chiede che il dato sia trattato come
 read*,dt                                           ! caratteri e advance="no"  sopprime il
 write(unit=*,fmt="(a)",advance="no")"n.step: "     ! carattere "a capo"  alla fine della linea per cui
 read*,nstep                                        ! la prossima operazione di lettura/scrittura inzia
 write(unit=*,fmt="(a)",advance="no")"massa: "      ! sulla stessa riga di schermo di quella corrente
 read*,massa
 write(unit=*,fmt="(a)",advance="no")"lunghezza: "
 read*,lunghezza
 write(unit=*,fmt="(a)",advance="no")"Angolo rispetto alla verticale: "
 read*,angolo
 write(unit=*,fmt="(a)",advance="no")"vel(0): "
 read*,vel
 alfa = angolo * pi/180
 acc = -(g/lunghezza)*sin(alfa)


 it=0        ! step 0 : valori iniziali
 write(unit=7,fmt=*)it,it*dt,alfa,vel
 epot =  massa*g*lunghezza*(1-cos(alfa))
 acc = -(g/lunghezza)*sin(alfa)
 ekin =  0.5 * massa * (vel*lunghezza)**2
 write(unit=8,fmt=*)it,dt*it,ekin,epot,ekin+epot

 do it = 1,nstep
    alfa = alfa + vel*dt + 0.5*acc*dt**2
    vel_parziale = vel + 0.5 * dt * acc         !  prima parte della formula per le velocita'
    acc = -(g/lunghezza)*sin(alfa)
    epot =  massa*g*lunghezza*(1-cos(alfa))
    vel = vel_parziale + 0.5 * dt * acc         !  la formula per le velocita' viene completata qui
    write(unit=7,fmt=*)it,it*dt,alfa,vel
    ekin = 0.5 * massa*(vel*lunghezza)**2
    write(unit=8,fmt=*)it,it*dt,ekin,epot,ekin+epot

 end do
 end program harm
