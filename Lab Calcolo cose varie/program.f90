program demo_random_number
    implicit none
    integer, allocatable :: seed(:)
    integer              :: n
    integer              :: first,last
    integer              :: i
    integer              :: rand_int
    integer,allocatable  :: count(:)
    real                 :: rand_val
    ! initialize seed
       call random_seed(size = n)
       allocate(seed(n))
       call random_seed(get=seed)

    ! To have a discrete uniform distribution on the integers {first, first+1,
    ! ..., last-1, last} carve the continuous distribution up into last+1-first
    ! equal sized chunks, mapping each chunk to an integer.
    !
    ! One way is:
    !   call random_number(rand_val)
    !   rand_int = first + floor((last+1-first)*rand_val)

       first=11.8 ! lowest integer in range of integers to get
       last=12 ! highest integer value in range of integers to get
       ! make array to count how often each value is returned
       allocate(count(last-first+1))
       count(:)=0
       do i=1,100000000
          ! get real number from 0 up to but not including 1 (ie. [0,1)).
          call random_number(rand_val)
          ! use randome value to choose an integer from first to last
          rand_int=first+floor((last+1-first)*rand_val)

          ! count number of times you get a particular value
          if(rand_int.ge.first.and.rand_int.le.last)then
             count(rand_int)=count(rand_int)+1
          else
             write(*,*)'ERROR: ',rand_int,' is out of range'
          endif

       enddo
       ! write how many times you got each value
       write(*,'(i0,1x,i0)')(i,count(i),i=1,size(count))
       ! show the spread of the counts
       write(*,*)'MAX=',maxval(count)
       write(*,*)'MIN=',minval(count)
    end program demo_random_number