module c_bmiheat

  use, intrinsic :: iso_c_binding
  use bmiheatf

  implicit none

  integer, parameter :: N_MODELS = 3
  type (bmi_heat), target :: model_array(N_MODELS)
  type (bmi_heat), pointer :: pmodel

contains

  ! Find the next unused model index in the array.
  function bmi_new() bind(c) result(model_index)
    integer (c_int) :: model_index
    integer :: i

    model_index = 0
    do i = 1, N_MODELS
       if (associated(pmodel, target=model_array(i))) then
          nullify(pmodel)
          model_index = i
       end if
    end do
    if (model_index.eq.N_MODELS) then
       model_index = -1
    else
       model_index = model_index + 1
       pmodel => model_array(model_index)
    end if
  end function bmi_new

  ! Initialize one model in the array, based on the input index.
  function bmi_initialize(model_index, config_file, n) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (in), value :: n
    character (len=1, kind=c_char), intent (in) :: config_file(n)
    integer (c_int) :: i, status
    character (len=n, kind=c_char) :: config_file_

    ! Convert `config_file` from rank-1 array to scalar.
    do i = 1, n
       config_file_(i:i) = config_file(i)
    enddo

    status = model_array(model_index)%initialize(config_file_)
  end function bmi_initialize

  ! Clean up one model in the array.
  function bmi_finalize(model_index) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int) :: status

    status = model_array(model_index)%finalize()
  end function bmi_finalize

  ! Get the component name attribute.
  function bmi_get_component_name(model_index, name, n) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (in), value :: n
    character (len=1, kind=c_char), intent (out) :: name(n)

    integer (c_int) :: i, status
    character (len=n, kind=c_char), pointer :: pname
    character (len=n, kind=c_char) :: name_

    status = model_array(model_index)%get_component_name(pname)

    ! Cast `pname` back to a string, dereferences `pname`.
    name_ = pname

    ! Load the `name_` string, trimmed, back into `name` for output.
    do i = 1, len(trim(name_))
        name(i) = name_(i:i)
    enddo
    name = name//C_NULL_CHAR
  end function bmi_get_component_name

  ! Get the number of input variables.
  function bmi_get_input_var_name_count(model_index, count) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (out) :: count
    integer (c_int) :: status

    count = input_item_count  ! defined in bmi_heat.f90
    status = BMI_SUCCESS
  end function bmi_get_input_var_name_count

  ! Get the names of the input variables.
  function bmi_get_input_var_names(model_index, names) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    type (c_ptr), dimension(input_item_count),  intent(out) :: names
    integer (c_int) :: status, i
    character (len=BMI_MAXVARNAMESTR), dimension(:), pointer :: pnames

    status = model_array(model_index)%get_input_var_names(pnames)

    do i = 1, input_item_count
       pnames(i) = trim(pnames(i))//C_NULL_CHAR
       names(i) = c_loc(pnames(i))
    enddo
  end function bmi_get_input_var_names

  ! Get the number of output variables.
  function bmi_get_output_var_name_count(model_index, count) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (out) :: count
    integer (c_int) :: status

    count = output_item_count  ! defined in bmi_heat.f90
    status = BMI_SUCCESS
  end function bmi_get_output_var_name_count

  ! Get the names of the output variables.
  function bmi_get_output_var_names(model_index, names) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    type (c_ptr), dimension(output_item_count),  intent(out) :: names
    integer (c_int) :: status, i
    character (len=BMI_MAXVARNAMESTR), dimension(:), pointer :: pnames

    status = model_array(model_index)%get_output_var_names(pnames)

    do i = 1, output_item_count
       pnames(i) = trim(pnames(i))//C_NULL_CHAR
       names(i) = c_loc(pnames(i))
    enddo
  end function bmi_get_output_var_names

  ! Get the model start time.
  function bmi_get_start_time(model_index, time) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (out) :: time
    integer (c_int) :: status

    status = model_array(model_index)%get_start_time(time)
  end function bmi_get_start_time

  ! Get the model stop time.
  function bmi_get_end_time(model_index, time) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (out) :: time
    integer (c_int) :: status

    status = model_array(model_index)%get_end_time(time)
  end function bmi_get_end_time

  ! Get the current model time.
  function bmi_get_current_time(model_index, time) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (out) :: time
    integer (c_int) :: status

    status = model_array(model_index)%get_current_time(time)
  end function bmi_get_current_time

  ! Get the model time step.
  function bmi_get_time_step(model_index, time_step) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (out) :: time_step
    integer (c_int) :: status

    status = model_array(model_index)%get_time_step(time_step)
  end function bmi_get_time_step

  ! Get the model time units.
  function bmi_get_time_units(model_index, time_units, n) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (in), value :: n
    character (len=1, kind=c_char), intent (out) :: time_units(n)

    integer (c_int) :: i, status
    character (len=n, kind=c_char) :: time_units_

    ! Convert `time_units` from rank-1 array to scalar.
    do i = 1, n
       time_units_(i:i) = time_units(i)
    enddo

    status = model_array(model_index)%get_time_units(time_units_)

    ! Load the `time_units_` result back into `time_units` for output.
    do i = 1, len(trim(time_units_))
        time_units(i) = time_units_(i:i)
    enddo
    time_units = time_units//C_NULL_CHAR
  end function bmi_get_time_units

  ! Advance the model by one time step.
  function bmi_update(model_index) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int) :: status

    status = model_array(model_index)%update()
  end function bmi_update

  ! Advance the model by a fraction of a time step.
  function bmi_update_frac(model_index, time_frac) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (in), value :: time_frac
    integer (c_int) :: status

    status = model_array(model_index)%update_frac(time_frac)
  end function bmi_update_frac

  ! Advance the model to a time in the future.
  function bmi_update_until(model_index, time_later) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    real (c_float), intent (in), value :: time_later
    integer (c_int) :: status

    status = model_array(model_index)%update_until(time_later)
  end function bmi_update_until

  ! Get the grid identifier for a given variable.
  function bmi_get_var_grid(model_index, var_name, n, grid_id) bind(c) result(status)
    integer (c_int), intent(in), value :: model_index
    integer (c_int), intent (in), value :: n
    character (len=1, kind=c_char), intent (in) :: var_name(n)
    integer (c_int), intent (out) :: grid_id
    integer (c_int) :: i, status
    character (len=n, kind=c_char) :: var_name_

    ! Convert `var_name` from rank-1 array to scalar.
    do i = 1, n
       var_name_(i:i) = var_name(i)
    enddo

    status = model_array(model_index)%get_var_grid(var_name_, grid_id)
  end function bmi_get_var_grid

end module c_bmiheat
