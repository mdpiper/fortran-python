"""An example of calling a Fortran BMI through Cython."""

import numpy as np
from bmi_heat import Heat


config_file = 'test.cfg'


np.set_printoptions(formatter={'float': '{: 6.1f}'.format})

# Instantiate a model and get its name.
m = Heat()
print(m.get_component_name())

# Initialize the model.
m.initialize(config_file)

# List the model's echange items.
print('Input vars:', m.get_input_var_names())
print('Output vars:', m.get_output_var_names())

# Get time information from the model.
print('Start time:', m.get_start_time())
print('End time:', m.get_end_time())
print('Current time:', m.get_current_time())
print('Time step:', m.get_time_step())
print('Time units:', m.get_time_units())

# Advance the model by one time step.
m.update()
print('Current time:', m.get_current_time())

# Advance the model by a fractional time step.
m.update_frac(0.75)
print('Current time:', m.get_current_time())

# Advance the model until a later time.
m.update_until(10.0)
print('Current time:', m.get_current_time())

# Get the grid_id for the plate_surface__temperature variable.
var_name = 'plate_surface__temperature'
print('Variable {}'.format(var_name))
grid_id = m.get_var_grid(var_name)
print(' - grid id:', grid_id)

# Get grid and variable info for plate_surface__temperature.
print(' - grid type:', m.get_grid_type(grid_id))
grid_rank = m.get_grid_rank(grid_id)
print(' - rank:', grid_rank)
grid_shape = np.empty(grid_rank, dtype=np.int32)
m.get_grid_shape(grid_id, grid_shape)
print(' - shape:', grid_shape)
grid_size = m.get_grid_size(grid_id)
print(' - size:', grid_size)
grid_spacing = np.empty(grid_rank, dtype=np.float64)
m.get_grid_spacing(grid_id, grid_spacing)
print(' - spacing:', grid_spacing)
grid_origin = np.empty(grid_rank, dtype=np.float64)
m.get_grid_origin(grid_id, grid_origin)
print(' - origin:', grid_origin)
print(' - variable type:', m.get_var_type(var_name))
print(' - units:', m.get_var_units(var_name))
print(' - itemsize:', m.get_var_itemsize(var_name))
print(' - nbytes:', m.get_var_nbytes(var_name))

# Get the temperature values.
val = np.empty(grid_shape, dtype=np.float32)
m.get_value(var_name, val)
print(' - values (streamwise):')
print(val)
print(' - values (gridded):')
print(val.reshape(np.roll(grid_shape, 1)))

# Set new temperature values.
new = np.arange(grid_size, dtype=np.float32)  # 'real*4 in Fortran
m.set_value(var_name, new)
check = np.empty(grid_shape, dtype=np.float32)
m.get_value(var_name, check)
print(' - new values (set/get, streamwise):');
print(check)

# Get a reference to the temperature values and check that it updates.
print(' - values (by ref, streamwise) at time {}:'.format(m.get_current_time()))
ref = m.get_value_ptr(var_name)
print(ref)
m.update()
print(' - values (by ref, streamwise) at time {}:'.format(m.get_current_time()))
print(ref)

# Get the grid_id for the plate_surface__thermal_diffusivity variable.
var_name = 'plate_surface__thermal_diffusivity'
print('Variable {}'.format(var_name))
grid_id = m.get_var_grid(var_name)
print(' - grid id:', grid_id)

# Get grid and variable info for plate_surface__thermal_diffusivity.
print(' - grid type:', m.get_grid_type(grid_id))
grid_rank = m.get_grid_rank(grid_id)
print(' - rank:', grid_rank)
print(' - size:', m.get_grid_size(grid_id))
grid_x = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_x(grid_id, grid_x)
print(' - x:', grid_x)
grid_y = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_y(grid_id, grid_y)
print(' - y:', grid_y)
grid_z = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_z(grid_id, grid_z)
print(' - z:', grid_z)
grid_connectivity = np.empty(max(grid_rank, 1), dtype=np.int32)
m.get_grid_connectivity(grid_id, grid_connectivity)
print(' - connectivity:', grid_connectivity)
grid_offset = np.empty(max(grid_rank, 1), dtype=np.int32)
m.get_grid_offset(grid_id, grid_offset)
print(' - offset:', grid_offset)
print(' - variable type:', m.get_var_type(var_name))
print(' - units:', m.get_var_units(var_name))
print(' - itemsize:', m.get_var_itemsize(var_name))
print(' - nbytes:', m.get_var_nbytes(var_name))

# Get the diffusivity values.
val = np.empty(1, dtype=np.float32)
m.get_value(var_name, val)
print(' - values:')
print(val)

# Get the grid_id for the model__identification_number variable.
var_name = 'model__identification_number'
print('Variable {}'.format(var_name))
grid_id = m.get_var_grid(var_name)
print(' - grid id:', grid_id)

# Get grid and variable info for model__identification_number.
print(' - grid type:', m.get_grid_type(grid_id))
grid_rank = m.get_grid_rank(grid_id)
print(' - rank:', grid_rank)
print(' - size:', m.get_grid_size(grid_id))
grid_x = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_x(grid_id, grid_x)
print(' - x:', grid_x)
grid_y = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_y(grid_id, grid_y)
print(' - y:', grid_y)
grid_z = np.empty(max(grid_rank, 1), dtype=np.float64)
m.get_grid_z(grid_id, grid_z)
print(' - z:', grid_z)
grid_connectivity = np.empty(max(grid_rank, 1), dtype=np.int32)
m.get_grid_connectivity(grid_id, grid_connectivity)
print(' - connectivity:', grid_connectivity)
grid_offset = np.empty(max(grid_rank, 1), dtype=np.int32)
m.get_grid_offset(grid_id, grid_offset)
print(' - offset:', grid_offset)
print(' - variable type:', m.get_var_type(var_name))
print(' - units:', m.get_var_units(var_name))
print(' - itemsize:', m.get_var_itemsize(var_name))
print(' - nbytes:', m.get_var_nbytes(var_name))

# Get the model id.
val = np.empty(1, dtype=np.int32)
m.get_value(var_name, val)
print(' - values:')
print(val)

# Set new model id.
new = np.array(42, dtype=np.intc)
m.set_value(var_name, new)
check = np.empty(1, dtype=np.int32)
m.get_value(var_name, check)
print(' - new values (set/get):');
print(check)

# Finalize the model.
m.finalize()

# Check that number of instances can't exceed N_MODELS=3.
# a = Heat()
# b = Heat()
# c = Heat()  # should fail with index=-1
