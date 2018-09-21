import numpy as np
cimport numpy as np
cimport cython


cdef extern from "c_diffusion.h":
    ctypedef struct diffusion_model:
        pass


cdef extern from "c_diffusion.h":
    void c_initialize(diffusion_model *m)
    void c_get_grid_x(diffusion_model *m, int *n);
    void c_get_value(diffusion_model *m, float **t);
    void c_get_current_time(diffusion_model *m, float *time);


cdef class Diffusion:

    cdef diffusion_model model

    def __cinit__(self):
        pass

    def initialize(self):
        c_initialize(&self.model)

    cpdef int get_grid_x(self):
        cdef int n_x
        <void>c_get_grid_x(&self.model, &n_x)
        return n_x

    cpdef get_value(self):
        cdef int n_x = self.get_grid_x()
        cdef float *temperature
        <void>c_get_value(&self.model, &temperature)
        return np.asarray(<float[:n_x]>temperature)

    cpdef float get_current_time(self):
        cdef float time
        <void>c_get_current_time(&self.model, &time)
        return time
