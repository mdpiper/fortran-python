FC = gfortran
CC = gcc
CFLAGS = -c
LFLAGS =
name = diffusion

c_${name}:
	${CC} ${CFLAGS} ${name}.f90 c_${name}.f90 ${name}_ex.c
	${CC} ${LFLAGS} *.o -o $@

clean:
	rm -rf *~ *.o *.so *.mod c_${name}
