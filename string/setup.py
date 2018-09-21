from distutils.core import setup, Extension
from Cython.Build import cythonize


setup(
    ext_modules = cythonize([
        Extension('f_adverbtize',
                  ['adverbtize.pyx'],
                  libraries=['gfortran'],
                  extra_objects=['words.o', 'wrapper.o'],
                  language='c'
              )
    ])
)
