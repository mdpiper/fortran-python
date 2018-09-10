program square_ex

  use mathability, only: square
  implicit none

  integer, parameter :: n = 5
  integer :: i
  integer :: x(n) = (/(i, i = 1, n)/)
  integer :: r(n)

  r = square(x)
  
  write(*,*) "Square array example"
  write(*,*) "Numbers: ", x
  write(*,*) "Their squares: ", r

end program square_ex
