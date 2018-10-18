from distutils.core import setup, Extension
from Cython.Build import cythonize


bmi_lib = '../bmi-fortran/_install/lib'
ext_modules = [
        Extension(
            'bmi_heat',
            ['bmiheat.pyx'],
            libraries=['bmif', 'bmiheatf'],
            library_dirs=[bmi_lib],
            runtime_library_dirs=[bmi_lib],
            include_dirs=['.', bmi_lib],
            extra_objects=['bmi_interoperability.o'],
            language='c'
        )
]

setup(
    ext_modules=cythonize(ext_modules),
)
