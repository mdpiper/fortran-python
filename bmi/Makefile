BMI_LIB = ../bmi-fortran/_install/lib
FC = gfortran
CC = gcc
CFLAGS = -c -fPIC -I. -I${BMI_LIB}
FFLAGS = -std=f2003
LDFLAGS = -L${BMI_LIB} -Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf
name = bmiheat

cython:
	${FC} ${CFLAGS} ${FFLAGS} iop_${name}.f90
	python setup.py build_ext --inplace
	@date

iop:
	${FC} ${CFLAGS} ${FFLAGS} iop_${name}.f90
	${CC} ${CFLAGS} ${name}_ex.c
	${CC} ${LDFLAGS} *.o -l${FC} -o $@
	@date

clean:
	rm -rf *~ *.o *.so *.mod iop ${name}.c build/
