BMI_LIB = ../bmi-fortran/_install/lib
BMI_INC = ../bmi-fortran/_install/include
FC = gfortran
CC = gcc
CFLAGS = -c -fPIC -I. -I${BMI_INC}
FFLAGS = -std=f2003
LDFLAGS = -L${BMI_LIB} -Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf
name = bmiheat

cython:
	${FC} ${CFLAGS} ${FFLAGS} bmi_interoperability.f90
	python setup.py build_ext --inplace
	@date

iop:
	${FC} ${CFLAGS} ${FFLAGS} bmi_interoperability.f90
	${CC} ${CFLAGS} ${name}_ex.c
	${CC} ${LDFLAGS} *.o -l${FC} -o $@
	@date

clean:
	rm -rf *~ *.o *.so *.mod iop ${name}.c build/ .pytest_cache __pycache__
