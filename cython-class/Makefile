BMI_LIB=../bmi-fortran/_install/lib

f_ex:
	gfortran heat_ex.f90 -L${BMI_LIB} -I${BMI_LIB} \
		-Wl,-rpath=${BMI_LIB} -lbmif -lbmiheatf -o heat_ex

clean:
	rm -rf *~ *.o *.so *.mod heat_ex
