# bmi

Wrap the sample implementation of the CSDMS Fortran BMI
with interoperability code
and call from Python through Cython.

So,  
Fortran model ->
Fortran BMI ->
Fortran-C interoperability layer ->
Cython ->
Python.

## Run

    make
    python bmiheat_ex.py

## Files

`libbmif.so`  
`libbmiheatf.so`

These are the libraries containing the sample implementation
installed by [bmi-fortran](https://github.com/csdms/bmi-fortran).

`test.cfg`

A sample configuration file for the *heat* model.

`c_bmiheat.f90`

The Fortran 2003 interoperability code that wraps the Fortran BMI,
allowing it to be called from C.
Special and more restrictive rules must be followed in this layer,
a responsibility which shouldn't be placed on the model developer
writing their BMI.

`c_bmiheat.h`  
`bmiheat_ex.c`

A C example of using the interoperability layer.
The header file defines function prototypes for the procedures
exposed by the interoperability layer.
This header file is also used by Cython, below.

`bmiheat.pyx`

The Cython code that wraps the interoperabilty code.

`setup.py`

Cythonizes `bmiheat.pyx`.
Need to link to the libraries installed by bmi-fortran.
If they're installed in a nonstandard location,
that directory needs to be included.

`bmiheat_ex.py`

A Python example that calls the Fortran *heat* model.
Whoa!
