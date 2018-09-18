program bmiheat_ex

  use bmiheatf
  implicit none

  type (bmi_heat) :: m
  integer :: s
  character (len=BMI_MAXCOMPNAMESTR), pointer :: name
  real :: time0, time1

  write (*,"(a)") "Component info"

  s = m%get_component_name(name)
  write (*,"(a30, a30)") "Component name: ", name

  write (*,"(a)",advance="no") "Initializing..."
  s = m%initialize("")
  write (*,*) "Done."

  s = m%get_start_time(time0)
  write (*,"(a30, f8.2)") "Start time:", time0
  s = m%get_end_time(time1)
  write (*,"(a30, f8.2)") "End time:", time1

  write (*,"(a)", advance="no") "Finalizing..."
  s = m%finalize()
  write (*,*) "Done"

end program bmiheat_ex
