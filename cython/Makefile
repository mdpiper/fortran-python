cython:
	gcc -c -fPIC mathability.f90 wrapper.f90
	python setup.py build_ext --inplace

c_ex:
	gcc -c mathability.f90 wrapper.f90 wrapper_ex.c
	gcc *.o -o wrapper_ex

f_ex:
	gfortran -c mathability.f90 square_ex.f90
	gfortran *.o -o square_ex

clean:
	rm -rf *~ *.o *.so *.mod square_ex wrapper_ex build square.c
