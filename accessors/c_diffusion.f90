module c_diffusion

  use, intrinsic :: iso_c_binding
  use diffusion

  implicit none

  ! Note that I'm replacing, not extending, diffusion_model.
  type, bind(c) :: c_diffusion_model
     integer (kind=c_int) :: n_x
     type (c_ptr) :: temperature
     real (kind=c_float) :: time
  end type c_diffusion_model

contains

  subroutine c_initialize(c_model) bind(c)
    type (c_diffusion_model), intent(inout) :: c_model

    type (diffusion_model) :: model

    call initialize(model)
    c_model%n_x = model%n_x
    c_model%temperature = c_loc(model%temperature(1))
    c_model%time = model%time
  end subroutine c_initialize

  subroutine c_get_grid_x(c_model, n_x) bind(c)
    type (c_diffusion_model), intent(inout) :: c_model
    integer (c_int), intent(out) :: n_x

    n_x = c_model%n_x
  end subroutine c_get_grid_x

  subroutine c_get_value(c_model, temperature) bind(c)
    type (c_diffusion_model), intent(inout) :: c_model
    type (c_ptr), intent(out) :: temperature

    temperature = c_model%temperature
  end subroutine c_get_value

  subroutine c_get_current_time(c_model, time) bind(c)
    type (c_diffusion_model), intent(inout) :: c_model
    real (c_float), intent(out) :: time

    time = c_model%time
  end subroutine c_get_current_time

end module c_diffusion
