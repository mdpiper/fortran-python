module mathiness

  implicit none
  public square

contains

  function square(number) result (squared)
    integer, intent (in) :: number
    integer :: squared

    squared = number*number
  end function square

end module mathiness
