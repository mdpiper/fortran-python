BMI_LIB = ../bmi-fortran/_install/lib
FC = gfortran
CC = gcc
CFLAGS = -c -fPIC -I. -I${BMI_LIB} -std=f2003
LFLAGS = -L${BMI_LIB} -Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf
name = bmiheat

py_${name}:
	${CC} ${CFLAGS} c_${name}.f90
	python setup.py build_ext --inplace

c_${name}:
	${CC} ${CFLAGS} c_${name}.f90 ${name}_ex.c
	${CC} ${LFLAGS} *.o -l${FC} -o $@

clean:
	rm -rf *~ *.o *.so *.mod c_${name} ${name}.c build/
