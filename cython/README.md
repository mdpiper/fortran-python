# cython

A Fortran example that can be called in Python through `cython`.

Here's the gist of the example,
from [Fortran Best Practices](http://www.fortran90.org/src/best-practices.html):
> Notice that we didn't write any C code--we only told Fortran to use the C calling convention when producing the ".o" files, and then we pretended in Cython that the function is implemented in C, when in fact it's linked from Fortran directly. So this is the most direct way of calling Fortran from Python. There is no intermediate step, and no unnecessary processing/wrapping involved.


There are three options for building this example,
as described below.
For additional detail, see the [Makefile](./Makefile).


## Fortran

Build a Fortran main program that calls the `square` function
from the *mathability* module.

Run:

    make f_ex
	./square_ex

Files:

* mathability.f90
* square_ex.f90


## C with a Fortran wrapped

Use the *iso_c_binding* intrinsic module
in a new Fortran module that wraps the `square` function,
using C types, and converting it into a subroutine
(for array outputs in C).
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

Compile the Fortran code above
(with the `-fPIC` flag),
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


