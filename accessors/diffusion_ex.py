"""An example of calling Fortran through Cython."""

from f_diffusion import Diffusion


m = Diffusion()

m.initialize()
n_x = m.get_grid_x()
temperature = m.get_value()
start_time = m.get_current_time()

print('Number of array elements:', n_x)
print('Array values:', temperature)
print('Start time:', start_time)
