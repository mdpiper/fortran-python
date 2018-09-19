module diffusion

  implicit none

  type :: diffusion_model
     integer :: n_x
  end type diffusion_model

contains

  subroutine initialize(model)
    type (diffusion_model), intent (inout) :: model

    model%n_x = 42
  end subroutine initialize

end module diffusion
