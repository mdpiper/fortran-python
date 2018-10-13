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
print(' - rank:', m.get_grid_rank(grid_id))
grid_shape = m.get_grid_shape(grid_id)
print(' - shape:', grid_shape)
print(' - size:', m.get_grid_size(grid_id))
print(' - spacing:', m.get_grid_spacing(grid_id))
print(' - origin:', m.get_grid_origin(grid_id))
print(' - variable type:', m.get_var_type(var_name))
print(' - units:', m.get_var_units(var_name))
print(' - itemsize:', m.get_var_itemsize(var_name))
print(' - nbytes:', m.get_var_nbytes(var_name))

print(' - values (gridded):')
val = m.get_value(var_name)
print(val.reshape(np.roll(grid_shape, 1)))

# Get the grid_id for the plate_surface__thermal_diffusivity variable.
var_name = 'plate_surface__thermal_diffusivity'
print('Variable {}'.format(var_name))
grid_id = m.get_var_grid(var_name)
print(' - grid id:', grid_id)

# Get grid and variable info for plate_surface__thermal_diffusivity.
print(' - grid type:', m.get_grid_type(grid_id))
print(' - rank:', m.get_grid_rank(grid_id))
print(' - size:', m.get_grid_size(grid_id))
print(' - x:', m.get_grid_x(grid_id))
print(' - y:', m.get_grid_y(grid_id))
print(' - z:', m.get_grid_z(grid_id))
print(' - connectivity:', m.get_grid_connectivity(grid_id))
print(' - offset:', m.get_grid_offset(grid_id))
print(' - variable type:', m.get_var_type(var_name))
print(' - units:', m.get_var_units(var_name))
print(' - itemsize:', m.get_var_itemsize(var_name))
print(' - nbytes:', m.get_var_nbytes(var_name))

print(' - values:')
val = m.get_value(var_name)
print(val)

# Finalize the model.
m.finalize()

# Check that number of instances can't exceed N_MODELS=3.
# a = Heat()
# b = Heat()
# c = Heat()  # should fail with index=-1
