module diffusion

  implicit none

  type :: diffusion_model
     integer :: n_x
     real, pointer :: temperature(:)
  end type diffusion_model

contains

  subroutine initialize(model)
    type (diffusion_model), intent (inout) :: model

    model%n_x = 4
    allocate(model%temperature(model%n_x))
    model%temperature = (/ 3.0, 6.0, 9.0, 12.0 /)
  end subroutine initialize

  subroutine cleanup(model)
    type (diffusion_model), intent (inout) :: model

    deallocate(model%temperature)
  end subroutine cleanup

end module diffusion
