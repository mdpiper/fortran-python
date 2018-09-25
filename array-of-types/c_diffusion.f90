module c_diffusion

  use, intrinsic :: iso_c_binding
  use diffusion

  implicit none

  integer, parameter :: N_MODELS = 3
  type (diffusion_model), target :: model_array(N_MODELS)
  type (diffusion_model), pointer :: pmodel

contains

  ! Find the next unused model index in the array.
  function c_new() bind(c) result(model_index)
    integer (c_int) :: model_index
    integer :: i

    model_index = 0
    do i = 1, N_MODELS
       if (associated(pmodel, target=model_array(i))) then
          nullify(pmodel)
          model_index = i
       end if
    end do
    model_index = model_index + 1
    pmodel => model_array(model_index)
  end function c_new

  ! Initialize one model in the array, based on the input index.
  subroutine c_initialize(model_index) bind(c)
    integer (c_int), intent(in), value :: model_index

    call initialize(model_array(model_index))
  end subroutine c_initialize

  ! Clean up one model in the array.
  subroutine c_finalize(model_index) bind(c)
    integer (c_int), intent(in), value :: model_index

    call cleanup(model_array(model_index))
  end subroutine c_finalize

  ! Get the number of elements in the temperature array.
  subroutine c_get_grid_x(model_index, n_x) bind(c)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent(out) :: n_x

    n_x = model_array(model_index)%n_x
  end subroutine c_get_grid_x

  ! Get the values of the temperature array for one model.
  subroutine c_get_value(model_index, temperature) bind(c)
    integer (c_int), intent(in), value :: model_index
    type (c_ptr), intent(out) :: temperature

    temperature = c_loc(model_array(model_index)%temperature(1))
  end subroutine c_get_value

  ! Get the current time step in the model.
  subroutine c_get_current_time(model_index, time) bind(c)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent(out) :: time

    time = model_array(model_index)%time
  end subroutine c_get_current_time

  ! Update the model state by one time step.
  subroutine c_update(model_index) bind(c)
    integer (c_int), intent(in), value :: model_index

    call advance(model_array(model_index))
  end subroutine c_update

end module c_diffusion
