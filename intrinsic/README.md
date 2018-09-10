# intrinsic

An example that uses only Fortran intrinsic types.

To compile, link into an executable, and run the example in Fortran:

    gfortran -c mathiness.f90 square_ex.f90
    gfortran *.o -o square_ex
	./square_ex

Alternately, compile and link into a shared object with `f2py`,
then run an example in Python:

    f2py -c mathiness.f90 -m fmathiness
	python square_ex.py
