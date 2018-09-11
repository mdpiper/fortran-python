# cython

An example that can be called through `cython`.

## Fortran

To compile, link into an executable, and run the example in Fortran:

    gfortran -c mathability.f90 square_ex.f90
    gfortran *.o -o square_ex
    ./square_ex

## C with a Fortran wrapped

A Fortran module using `iso_c_binding` wraps the `square` function above,
which is then called from a C program.

    gcc -c mathability.f90 wrapper.f90 wrapper_ex.c
    gcc *.o -o wrapper_ex
    ./wrapper_ex
