from distutils.core import setup, Extension
from Cython.Build import cythonize


setup(
    ext_modules = cythonize([
        Extension('f_diffusion',
                  ['diffusion.pyx'],
                  extra_objects=['diffusion.o', 'c_diffusion.o'],
                  language='c'
              )
    ])
)
