!prendi intervallo di dati, prendi regola da usare, load data into array and sort, take interval divide the data, ask if take left or right, calculate numbers and say data points in each column
!List of things to implement:
! 1. Take rule to use for histogram
! 2. take data and sort it. Take min and max for intervals
! 3. (optional) ask if right or left should be included
! 4. array support

!!take data interval (take min and max), section the interval, add amount of arguments per division
program Histogram_rule_devisions
implicit none
    character(len=100):: histogram_rule
    integer:: array_dimension

!takes in data from file and turns it into array
    print*, 'How many data points?'
    read*, array_dimension
    call datareadin(array_dimension)

end program Histogram_rule_devisions

!creates data array with N elements and sorts
subroutine datareadin(array_dimension)
implicit none
    integer, intent(in) :: array_dimension
    integer :: i
    real, dimension(array_dimension):: data_array

    open(unit = array_dimension, file = 'data.txt', status='old')
    read(array_dimension,*) data_array
    close(unit=array_dimension)
    call Sort(array_dimension,data_array)

end subroutine datareadin

!takes in array and sorts it
subroutine Sort(array_dimension,data_array)
implicit none
    integer, intent(in)::array_dimension
    integer :: i, j
    real, dimension(array_dimension),intent(inout):: data_array
    print*,'Unsorted data array', data_array
    do i = 1,array_dimension
        do j = 1,array_dimension-i
            if (data_array(j)>data_array(j+1)) then
                call swap(data_array(j), data_array(j+1))
            endif
        enddo
    enddo
        print *, 'Sorted data array:', data_array

    call Histogram_setup(array_dimension, data_array)

contains 
subroutine swap(x,y)
    real::x,y
    real ::buffer
    buffer = x
    x = y
    y = buffer
end subroutine swap
end subroutine Sort

!Sets up histogram rules and divisions by taking in sorted data array and dimensions
recursive subroutine Histogram_setup(array_dimension, data_array)
implicit none  
!variables taken in
    integer, intent(in)::array_dimension
    real, dimension(array_dimension), intent(in) :: data_array
!variables needed for this specific subroutine
    character(len=100) ::histogram_rule
    integer :: i, j, interval_selected, previous_interval, histogram_total_intervals, biggest_smallest_number
    real::histogram_range, element_selected, histogram_interval_spacing, histogram_interval_cutoff, interval_counter, interval_counter_buffer


    Print*, 'Please select method for histogram divisions (Square root, Sturges, Rice, Scott, Freedman-Diaconis):'
    read(*,'(A)') histogram_rule

    if (histogram_rule == 'Square root') then
    interval_selected = 0
    previous_interval = 0

    histogram_range = data_array(array_dimension)-data_array(1)
    histogram_total_intervals = nint(sqrt(real(array_dimension)+1))
    histogram_interval_spacing = (histogram_range)/(int(sqrt(real(array_dimension)))+1)
    

    do i = 1,histogram_total_intervals
        previous_interval = interval_selected
        interval_selected = i*array_dimension/histogram_total_intervals
        histogram_interval_cutoff = i*histogram_range/histogram_total_intervals
        interval_counter = 0
        

        do j = 1, array_dimension
            if(data_array(j)<=histogram_interval_cutoff) then
                interval_counter = interval_counter + 1
            endif
        end do

        Print*, 'Low bound', data_array(previous_interval)
        print*, 'Number of elements:', int(interval_counter-interval_counter_buffer)
        print*, 'High bound', data_array(interval_selected)
        interval_counter_buffer = interval_counter
    end do
    
    else if (histogram_rule == 'Sturges') then
    print*, 'Sturges'
    interval_selected = 0
    previous_interval = 0
    hnumber_devisions = floor(log2(n))+1
    histogram_range = data_array(array_dimension) - data_array(1)
    histogram_total_intervals = 


    else if(histogram_rule == 'Rice') then
    print*, 'Rice'

    else if(histogram_rule == 'Scott') then
    print*, 'Scott'

    else if(histogram_rule == 'Freedman-Diaconis') then
    print*, 'f-d'

    else 
    print*, 'Not recognized please input again'
    call Histogram_setup(array_dimension, data_array)
    end if
end subroutine Histogram_setup
