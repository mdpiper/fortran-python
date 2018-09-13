# cython

A Fortran example that can be called in Python through Cython.
All options for the example use the `square` function
from the *mathability* module.
It takes an integer array as a parameter
and returns an integer array with the squared values of the inputs.

Here's the gist of the example,
from [Fortran Best Practices](http://www.fortran90.org/src/best-practices.html):
> Notice that we didn't write any C code--we only told Fortran to use the C calling convention when producing the ".o" files, and then we pretended in Cython that the function is implemented in C, when in fact it's linked from Fortran directly. So this is the most direct way of calling Fortran from Python. There is no intermediate step, and no unnecessary processing/wrapping involved.

There are three options for building this example,
as described below.
For additional detail, see the [Makefile](./Makefile).


## Fortran

Build a Fortran main program that calls the `square` function.

Run:

    make f_ex
	./square_ex

Files:

* mathability.f90
* square_ex.f90

This pure Fortran option provides a check that the example code works
as expected.


## C with a Fortran wrapper

Write a Fortran procedure that wraps the `square` function.
Include it in a new module.
Use the *iso_c_binding* intrinsic module,
the `bind(c)` attribute,
and C types in the procedure.
Implement the procedure as a subroutine,
since C only allows scalars to be returned from functions.
Write a C main program to demonstrate that the wrapper
can be called from C.

Run:

    make c_ex
	./wrapper_ex

Files:

* mathability.f90
* wrapper.f90
* wrapper_ex.c

See also
[Fortran Best Practices: Interfacing with C](http://www.fortran90.org/src/best-practices.html#interfacing-with-c).


## Cython

Compile the Fortran code with the `-fPIC` flag,
set up a definition for it in Cython,
then compile and build into a shared object.
See the details in **square.pyx** and **setup.py**.

Run:

    make cython
	python run_square.py

Files:

* mathability.f90
* wrapper.f90
* square.pyx
* setup.py
* run_square.py

See also
[Fortran Best Practices: Using Cython](http://www.fortran90.org/src/best-practices.html#using-cython).


