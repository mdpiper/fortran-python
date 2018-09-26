import numpy as np
cimport numpy as np


cdef extern from "c_bmiheat.h":
    int c_new()
    int c_initialize(int model, char *config_file, int n)
    int c_finalize(int model)


def ok_or_raise(status):
    if status != 0:
        raise RuntimeError('error code {status}'.format(status=status))


cdef class Heat:

    cdef int _bmi

    def __cinit__(self):
        self._bmi = c_new()

        if self._bmi < 0:
            raise MemoryError('out of range model index: {}'
                              .format(self._bmi))

    def initialize(self, config_file):
        n = len(config_file)
        cfg_file = bytes(config_file.encode('utf-8')) 
        status = c_initialize(self._bmi, cfg_file, n)
        ok_or_raise(status)

    def finalize(self):
        status = c_finalize(self._bmi)
        ok_or_raise(status)
