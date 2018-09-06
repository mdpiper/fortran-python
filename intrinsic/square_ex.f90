program square_ex

  use mathiness, only: square
  implicit none

  integer, parameter :: x = 5
  integer :: r

  r = square(x)
  
  write(*,*) "Square example"
  write(*,*) "A number: ", x
  write(*,*) "Its square: ", r

end program square_ex
