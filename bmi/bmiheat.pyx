import numpy as np
cimport numpy as np


cdef extern from "c_bmiheat.h":
    int BMI_MAXCOMPNAMESTR
    int bmi_new()
    int bmi_initialize(int model, char *config_file, int n)
    int bmi_finalize(int model)
    int bmi_get_component_name(int model, char *name, int n)


def ok_or_raise(status):
    if status != 0:
        raise RuntimeError('error code {status}'.format(status=status))


cdef class Heat:

    cdef int _bmi

    def __cinit__(self):
        self._bmi = bmi_new()

        if self._bmi < 0:
            raise MemoryError('out of range model index: {}'
                              .format(self._bmi))

    def initialize(self, config_file):
        n = len(config_file)
        cfg_file = bytes(config_file.encode('utf-8')) 
        status = bmi_initialize(self._bmi, cfg_file, n)
        ok_or_raise(status)

    def finalize(self):
        status = bmi_finalize(self._bmi)
        ok_or_raise(status)

    def get_component_name(self):
        name = ' '*BMI_MAXCOMPNAMESTR
        bname = bytes(name.encode('utf-8'))
        ok_or_raise(bmi_get_component_name(self._bmi, bname,
                                           BMI_MAXCOMPNAMESTR))
        return bname.decode('utf-8').rstrip()
