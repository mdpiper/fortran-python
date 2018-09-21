"""An example of calling Fortran through Cython."""

from f_diffusion import Diffusion


m = Diffusion()

m.initialize()
n_x = m.get_grid_x()
temperature = m.get_value()

print('Number of array elements:', n_x)
print('Array values:', temperature)
