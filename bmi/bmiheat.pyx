from libc.stdlib cimport malloc, free
import numpy as np
cimport numpy as np


cdef extern from "c_bmiheat.h":
    int BMI_MAXCOMPNAMESTR
    int BMI_MAXVARNAMESTR
    int BMI_MAXUNITSSTR
    int bmi_new()
    int bmi_initialize(int model, char *config_file, int n)
    int bmi_finalize(int model)
    int bmi_get_component_name(int model, char *name, int n)
    int bmi_get_input_var_name_count(int model, int *n)
    int bmi_get_input_var_names(int model, char **names)
    int bmi_get_output_var_name_count(int model, int *n)
    int bmi_get_output_var_names(int model, char **names)
    int bmi_get_start_time(int model, float *time)
    int bmi_get_end_time(int model, float *time)
    int bmi_get_current_time(int model, float *time)
    int bmi_get_time_step(int model, float *time_step)
    int bmi_get_time_units(int model, char *time_units, int n)


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

    cpdef int get_input_var_name_count(self):
        cdef int count = 0
        ok_or_raise(<int>bmi_get_input_var_name_count(self._bmi, &count))
        return count

    def get_input_var_names(self):
        cdef list py_names = []
        cdef char** names
        cdef int i
        cdef int count
        cdef int status = 1

        ok_or_raise(<int>bmi_get_input_var_name_count(self._bmi, &count))

        try:
            names = <char**>malloc(count * sizeof(char*))
            names[0] = <char*>malloc(count * BMI_MAXVARNAMESTR * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + BMI_MAXVARNAMESTR

            ok_or_raise(<int>bmi_get_input_var_names(self._bmi, names))

            for i in range(count):
                py_names.append(names[i].decode('utf-8'))

        except Exception:
            raise

        finally:
            free(names)

        return tuple(py_names)

    cpdef int get_output_var_name_count(self):
        cdef int count = 0
        ok_or_raise(<int>bmi_get_output_var_name_count(self._bmi, &count))
        return count

    def get_output_var_names(self):
        cdef list py_names = []
        cdef char** names
        cdef int i
        cdef int count
        cdef int status = 1

        ok_or_raise(<int>bmi_get_output_var_name_count(self._bmi, &count))

        try:
            names = <char**>malloc(count * sizeof(char*))
            names[0] = <char*>malloc(count * BMI_MAXVARNAMESTR * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + BMI_MAXVARNAMESTR

            ok_or_raise(<int>bmi_get_output_var_names(self._bmi, names))

            for i in range(count):
                py_names.append(names[i].decode('utf-8'))

        except Exception:
            raise

        finally:
            free(names)

        return tuple(py_names)

    def get_start_time(self):
        cdef float time
        ok_or_raise(<int>bmi_get_start_time(self._bmi, &time))
        return time

    def get_end_time(self):
        cdef float time
        ok_or_raise(<int>bmi_get_end_time(self._bmi, &time))
        return time

    def get_current_time(self):
        cdef float time
        ok_or_raise(<int>bmi_get_current_time(self._bmi, &time))
        return time

    def get_time_step(self):
        cdef float step
        ok_or_raise(<int>bmi_get_time_step(self._bmi, &step))
        return step

    def get_time_units(self):
        units = ' '*BMI_MAXUNITSSTR
        bunits = bytes(units.encode('utf-8'))
        ok_or_raise(bmi_get_time_units(self._bmi, bunits,
                                       BMI_MAXUNITSSTR))
        return bunits.decode('utf-8').rstrip()
