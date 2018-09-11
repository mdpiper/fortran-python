import numpy as np
cimport numpy as np
cimport cython


cdef extern:
    void c_square(int *x, int *n, int *r)


def square(np.ndarray[int, ndim=1, mode="c"] x not None):
    cdef np.ndarray[int, ndim=1, mode="c"] r = np.empty_like(x)
    cdef int n
    n = len(x)
    c_square(&x[0], &n, &r[0])
    return r
