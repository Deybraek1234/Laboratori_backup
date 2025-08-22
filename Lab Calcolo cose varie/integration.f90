program integration
implicit none
    real :: integration_value, upper_bound, lower_bound, delta_area, current_interval, previous_interval, average_interval, image_average_interval, area_average_interval
    integer :: i, N

    print*, 'How many intervals?'
    read*, N
    print*, 'Lower and upper bounds?'
    read*, lower_bound, upper_bound

    !equation y = x
    previous_interval = 0
    integration_value = 0
print*, previous_interval
    do i = 1,N
        current_interval = lower_bound + real(i)/real(N)*(upper_bound-lower_bound)
        average_interval = (current_interval - previous_interval) / 2
        ! y = x
        image_average_interval = average_interval
        area_average_interval = image_average_interval * (current_interval - previous_interval)
        integration_value = integration_value + area_average_interval
        print*, i, previous_interval, current_interval, area_average_interval, image_average_interval, integration_value
        previous_interval = current_interval
    end do
    print*, 'Final total is:', integration_value
end program
