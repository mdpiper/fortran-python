LOCAL_LIB=../_install/lib

f_ex:
	gfortran heat_ex.f90 -L${LOCAL_LIB} -I${LOCAL_LIB} \
		-Wl,-rpath=${LOCAL_LIB} -lbmif -lbmiheatf -o heat_ex

clean:
	rm -rf *~ *.o *.so *.mod heat_ex
