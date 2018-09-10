module mathability

  implicit none
  public square

contains

  function square(array) result (squared)
    integer, intent (in) :: array(:)
    integer :: squared(size(array))
    integer :: i

    do i = 1, size(array)
       squared(i) = array(i)*array(i)
    enddo
  end function square

end module mathability
