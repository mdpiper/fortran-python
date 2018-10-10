BMI_LIB = ../bmi-fortran/_install/lib
FC = gfortran
CC = gcc
CFLAGS = -c -fPIC -I. -I${BMI_LIB}
FFLAGS = -std=f2003
LFLAGS = -L${BMI_LIB} -Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf
name = bmiheat

py_${name}:
	${FC} ${CFLAGS} ${FFLAGS} c_${name}.f90
	python setup.py build_ext --inplace

c_${name}:
	${FC} ${CFLAGS} ${FFLAGS} c_${name}.f90
	${CC} ${CFLAGS} ${name}_ex.c
	${CC} ${LFLAGS} *.o -l${FC} -o $@

clean:
	rm -rf *~ *.o *.so *.mod c_${name} ${name}.c build/
