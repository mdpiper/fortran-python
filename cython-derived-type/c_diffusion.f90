module c_diffusion

  use, intrinsic :: iso_c_binding
  use diffusion

  implicit none

  ! Note that I'm replacing, not extending, diffusion_model.
  type, bind(c) :: c_diffusion_model
     integer (kind=c_int) :: n_x
  end type c_diffusion_model

contains

  subroutine c_initialize(c_model) bind(c)
    type(c_diffusion_model), intent (inout) :: c_model

    type(diffusion_model) :: model

    call initialize(model)
    c_model%n_x = model%n_x
  end subroutine c_initialize

end module c_diffusion
