"""An example of calling Fortran through Cython."""

from f_diffusion import Diffusion


x = Diffusion()
x.initialize()

print('The answer is:', x.model['n_x'])
