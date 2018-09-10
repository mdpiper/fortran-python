# cython

An example that can be called through `cython`.

To compile, link into an executable, and run the example in Fortran:

    gfortran -c mathability.f90 square_ex.f90
    gfortran *.o -o square_ex
	./square_ex
