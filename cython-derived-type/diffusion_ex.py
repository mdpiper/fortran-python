"""An example of calling Fortran through Cython."""

from f_diffusion import Diffusion


m = Diffusion()
m.initialize()

print('Number of array elements:', m.n_x)
# print('Array values:', m.temperature)
