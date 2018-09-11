from distutils.core import setup, Extension
from Cython.Build import cythonize


setup(
    ext_modules = cythonize([
        Extension('f_square',
                  ['square.pyx'],
                  extra_objects=['mathability.o', 'wrapper.o'],
                  language='c'
              )
    ])
)
