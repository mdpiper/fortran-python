BMI_LIB = ../bmi-fortran/_install/lib

FC = gfortran
CFLAGS = -c -I${BMI_LIB}
LFLAGS = -L${BMI_LIB} -Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf

bmiheat_ex:
	${FC} ${CFLAGS} bmiheat_ex.f90
	${FC} ${LFLAGS} bmiheat_ex.o -o $@

heat_ex:
	gfortran heat_ex.f90 -L${BMI_LIB} -I${BMI_LIB} \
		-Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf -o heat_ex

clean:
	rm -rf *~ *.o *.so *.mod heat_ex bmiheat_ex
