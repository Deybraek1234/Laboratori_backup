program test
implicit none
    integer, pointer :: pt(:)
    integer :: i

do i = 1,10000
    allocate(pt(i))
    nullify(pt)
end do

end program