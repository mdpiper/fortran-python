module wrapper

  use iso_c_binding, only: c_int
  use mathability, only: square

  implicit none

  public c_square

contains

  ! Changed signature from function to subroutine!
  subroutine c_square(array, n, squared) bind(c)
    integer (c_int), intent (in) :: n
    integer (c_int), intent (in) :: array(n)
    integer (c_int), intent (out) :: squared(n)

    squared = square(array)
  end subroutine c_square

end module wrapper
