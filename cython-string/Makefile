cython:
	gcc -c -fPIC words.f90 wrapper.f90
	python setup.py build_ext --inplace

c_ex:
	gcc -c words.f90 wrapper.f90 wrapper_ex.c
	gcc *.o -o wrapper_ex -lgfortran

f_ex:
	gfortran -c words.f90 adverbtize_ex.f90
	gfortran *.o -o adverbtize_ex

clean:
	rm -rf *~ *.o *.so *.mod adverbtize_ex wrapper_ex build adverbtize.c
