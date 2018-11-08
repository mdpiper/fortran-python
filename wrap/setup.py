#! /usr/bin/env python
import os
import sys
import subprocess
import numpy as np

from setuptools import find_packages, setup
from distutils.extension import Extension

from numpy.distutils.fcompiler import new_fcompiler


common_flags = {
    "include_dirs": [
        np.get_include(),
        os.path.join(sys.prefix, "include"),
    ],
    "library_dirs": [
    ],
    "define_macros": [
    ],
    "undef_macros": [
    ],
    "extra_compile_args": [
    ],
    "language": "c",
}

libraries = [
    'bmif',
    'bmiheatf',
]

ext_modules = [
    Extension(
        name="bmi_heatf",
        sources=["heatf.pyx"],
        # libraries=libraries + ["bmi_heat"],
        libraries=libraries,
        extra_objects=['bmi_interoperability.o'],
        **common_flags,
    ),
]


def build_interoperability():
    compiler = new_fcompiler()
    compiler.customize()
    compiler.add_include_dir(os.path.join(sys.prefix, 'lib'))

    cmd = compiler.compiler_f90
    cmd.append(compiler.compile_switch)
    for include_dir in compiler.include_dirs:
        cmd.append('-I{}'.format(include_dir))
    cmd.append('bmi_interoperability.f90')

    subprocess.call(cmd)


if 'develop' in sys.argv:
    build_interoperability()


setup(
    name="bmi_heatf",
    author="Mark Piper",
    description="Python wrapper for BMI-ed Fortran heat model",
    setup_requires=['cython'],
    ext_modules=ext_modules,
    packages=find_packages(),
)
