all: c_ex

f_ex:
	gfortran -c mathability.f90 square_ex.f90
	gfortran *.o -o square_ex

c_ex:
	gcc -c mathability.f90 wrapper.f90 wrapper_ex.c
	gcc *.o -o wrapper_ex

clean:
	rm -f *~ *.o *.mod square_ex wrapper_ex
