FC = gfortran
CC = gcc
CFLAGS = -c -fPIC -I.
LFLAGS =
name = diffusion

py_${name}:
	${CC} ${CFLAGS} ${name}.f90 c_${name}.f90
	python setup.py build_ext --inplace

c_${name}:
	${CC} ${CFLAGS} ${name}.f90 c_${name}.f90 ${name}_ex.c
	${CC} ${LFLAGS} *.o -l${FC} -o $@

clean:
	rm -rf *~ *.o *.so *.mod c_${name} ${name}.c build/
