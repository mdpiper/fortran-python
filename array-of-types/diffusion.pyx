import numpy as np
cimport numpy as np
cimport cython


cdef extern from "c_diffusion.h":
    int c_new()
    void c_initialize(int model)
    void c_finalize(int model)
    void c_get_grid_x(int model, int *nx)
    void c_get_value(int model, float **val)
    void c_get_current_time(int model, float *time)
    void c_update(int model)


cdef class Diffusion:

    cdef int model

    def __cinit__(self):
        self.model = c_new()

        if self.model < 0:
            raise MemoryError('Model index out of range.')

    def initialize(self):
        c_initialize(self.model)

    def finalize(self):
        c_finalize(self.model)

    cpdef int get_grid_x(self):
        cdef int n_x
        <void>c_get_grid_x(self.model, &n_x)
        return n_x

    cpdef get_value(self):
        cdef int n_x = self.get_grid_x()
        cdef float *temperature
        <void>c_get_value(self.model, &temperature)
        return np.asarray(<float[:n_x]>temperature)

    cpdef float get_current_time(self):
        cdef float time
        <void>c_get_current_time(self.model, &time)
        return time

    def update(self):
        c_update(self.model)
