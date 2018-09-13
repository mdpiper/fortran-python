# cython-string

A Fortran example that can be called in Python through Cython.
All options for the example use the `adverbtize` function
from the *words* module.
It takes a noun as a string parameter
and returns its adverb form (kinda) as a string.

There are two options for building this example,
as described below.
For additional detail, see the [Makefile](./Makefile).


## Fortran

Build a Fortran main program that calls the `adverbtize` function.

Run:

    make f_ex
	./adverbtize_ex

Files:

* words.f90
* adverbtize_ex.f90

This pure Fortran option provides a check that the example code works
as expected.


## C with a Fortran wrapper

Write a Fortran procedure that wraps the `adverbtize` function.
Include it in a new module.
Use the *iso_c_binding* intrinsic module,
the `bind(c)` attribute,
and C types in the procedure.
Implement the procedure as a subroutine.
Write a C main program to demonstrate that the wrapper
can be called from C.

Run:

    make c_ex
	./wrapper_ex

Files:

* words.f90
* wrapper.f90
* wrapper_ex.c

Note that strings have to be passed between C and Fortran
as character arrays; i.e., like:

    character (len=1) :: word(n)

not

	character (len=n) :: word

The length of a string is a hidden parameter in Fortran,
so also pass the length of the string as a parameter
in this formulation.
