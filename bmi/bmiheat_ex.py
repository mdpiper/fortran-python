"""An example of calling a Fortran BMI through Cython."""

from bmi_heat import Heat


config_file = ''


m = Heat()

m.initialize(config_file)
m.finalize()

# Check that number of instances can't exceed N_MODELS=3.
a = Heat()
b = Heat()
c = Heat()  # should fail with index=-1
