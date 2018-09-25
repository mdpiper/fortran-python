"""An example of calling Fortran through Cython."""

from f_diffusion import Diffusion


a = Diffusion()

a.initialize()

time = a.get_current_time()
temperature = a.get_value()
print('Time:', time)
print('Array values:', temperature)

a.update()

time = a.get_current_time()
temperature = a.get_value()
print('Time:', time)
print('Array values:', temperature)

a.finalize()

# Check that number of instances can't exceed N_MODELS=3.
# a = Diffusion()
b = Diffusion()
c = Diffusion()
d = Diffusion()  # should fail
