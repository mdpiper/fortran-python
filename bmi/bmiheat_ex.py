"""An example of calling a Fortran BMI through Cython."""

from bmi_heat import Heat


config_file = ''

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

# Finalize the model.
m.finalize()

# Check that number of instances can't exceed N_MODELS=3.
# a = Heat()
# b = Heat()
# c = Heat()  # should fail with index=-1
