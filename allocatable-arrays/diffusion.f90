module diffusion

  implicit none

  type :: diffusion_model
     integer :: n_x
     real, allocatable :: temperature(:)
     real :: time
  end type diffusion_model

contains

  subroutine initialize(model)
    type (diffusion_model), intent (inout) :: model

    model%n_x = 4
    allocate(model%temperature(model%n_x))
    model%temperature = (/ 3.0, 6.0, 9.0, 12.0 /)
    model%time = 0.0
  end subroutine initialize

  subroutine cleanup(model)
    type (diffusion_model), intent (inout) :: model

    deallocate(model%temperature)
  end subroutine cleanup

  subroutine advance(model)
    type (diffusion_model), intent (inout) :: model

    model%temperature = model%temperature + 1.0
    model%time = model%time + 1.0
  end subroutine advance

end module diffusion
