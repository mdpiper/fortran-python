import numpy as np
cimport numpy as np
cimport cython


ctypedef struct diffusion_model:
    int n_x


cdef extern:
    void c_initialize(diffusion_model *x);


cdef class Diffusion:

    cdef public diffusion_model model

    def __cinit__(self):
        pass

    def initialize(self):
        c_initialize(&self.model);
