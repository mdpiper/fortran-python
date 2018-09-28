"""An example of calling a Fortran BMI through Cython."""

from bmi_heat import Heat


config_file = ''


m = Heat()
print(m.get_component_name())

m.initialize(config_file)

print('In:', m.get_input_var_names())
print('Out:', m.get_output_var_names())

print('Start time:', m.get_start_time())
print('End time:', m.get_end_time())
print('Current time:', m.get_current_time())
print('Time step:', m.get_time_step())
print('Time units:', m.get_time_units())

m.finalize()

# Check that number of instances can't exceed N_MODELS=3.
# a = Heat()
# b = Heat()
# c = Heat()  # should fail with index=-1
