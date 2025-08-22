 program harm
 implicit none
! Grafico fatto con dt=0.01, n.step = 10000, massa = 4, kappa = 7, pos(0)/0, vel(0) = 1


 real    :: massa=1.0,kappa=1.0 ! valori di default per massa e cost. elastica
 real    :: dt,ekin,epot
 real    :: pos,vel,vel_parziale,f, omega, pos0, vel0, pos_analitica, velocita
 integer :: nstep,it
 write(unit=*,fmt="(a)",advance="no")"delta t : "   ! il formato (a) chiede che il dato sia trattato come
 read*,dt                                           ! caratteri e advance="no"  sopprime il
 write(unit=*,fmt="(a)",advance="no")"n.step: "     ! carattere "a capo"  alla fine della linea per cui
 read*,nstep                                        ! la prossima operazione di lettura/scrittura inzia
 write(unit=*,fmt="(a)",advance="no")"massa: "      ! sulla stessa riga di schermo di quella corrente
 read*,massa
 write(unit=*,fmt="(a)",advance="no")"kappa: "
 read*,kappa
 write(unit=*,fmt="(a)",advance="no")"pos(0): "
 read*,pos
 write(unit=*,fmt="(a)",advance="no")"vel(0): "
 read*,vel
pos0=pos
vel0=vel
omega=sqrt(kappa/massa)

 it=0        ! step 0 : valori iniziali

 write(unit=1,fmt=*)it,it*dt,pos,vel
 epot =  0.5 * kappa * pos**2
 f    = - kappa * pos
 ekin =  0.5 * massa * vel**2
 write(unit=2,fmt=*)it,dt*it,ekin,epot,ekin+epot

 do it = 1,nstep
    pos = pos + vel * dt + 0.5* f/massa * dt**2
    vel_parziale = vel + 0.5 * dt * f/massa         !  prima parte della formula per le velocita'
    f    = - kappa * pos
    epot =  0.5 * kappa * pos**2
    vel = vel_parziale + 0.5 * dt * f/massa         !  la formula per le velocita' viene completata qui
    pos_analitica=pos0*cos(omega*it*dt)+(vel0/omega)*sin(omega*it*dt)
    velocita = -omega*pos0*sin(omega*it*dt)+vel0*cos(omega*it*dt)
    write(unit=1,fmt=*)it,it*dt,pos,vel, pos_analitica, velocita
    ekin = 0.5 * massa * vel**2
    write(unit=2,fmt=*)it,it*dt,ekin,epot,ekin+epot
    write(unit=3, fmt=*) pos, pos_analitica, abs(pos-pos_analitica), vel, velocita, abs(velocita-vel) !scrive posizione, posizione aalitica, differenza tra i due, velocita formula, velocita analitica, differenza tra i due

 end do
 end program harm
