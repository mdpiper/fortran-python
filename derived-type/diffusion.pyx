import numpy as np
cimport numpy as np
cimport cython


cdef extern from "diffusion_ex.c":
    ctypedef struct diffusion_model:
        np.int_t n_x


cdef extern:
    void c_initialize(diffusion_model *m)


cdef class Diffusion:

    cdef public diffusion_model model

    def __cinit__(self):
        pass

    def initialize(self):
        c_initialize(&self.model);

    @property
    def n_x(self):
        return self.model.n_x
