from libc.stdlib cimport malloc, free
import numpy as np
cimport numpy as np


cdef extern from "c_bmiheat.h":
    int BMI_MAX_COMPONENT_NAME
    int BMI_MAX_VAR_NAME
    int BMI_MAX_TYPE_NAME
    int BMI_MAX_UNITS_NAME
    int bmi_new()
    int bmi_initialize(int model, char *config_file, int n)
    int bmi_finalize(int model)
    int bmi_get_component_name(int model, char *name, int n)
    int bmi_get_input_var_name_count(int model, int *n)
    int bmi_get_input_var_names(int model, char **names, int n)
    int bmi_get_output_var_name_count(int model, int *n)
    int bmi_get_output_var_names(int model, char **names, int n)
    int bmi_get_start_time(int model, float *time)
    int bmi_get_end_time(int model, float *time)
    int bmi_get_current_time(int model, float *time)
    int bmi_get_time_step(int model, float *time_step)
    int bmi_get_time_units(int model, char *time_units, int n)
    int bmi_update(int model)
    int bmi_update_frac(int model, float time_frac)
    int bmi_update_until(int model, float time_later)
    int bmi_get_var_grid(int model, char *var_name, int n, int *grid_id)
    int bmi_get_grid_type(int model, int grid_id, char *type, int n)
    int bmi_get_grid_rank(int model, int grid_id, int *rank)
    int bmi_get_grid_shape(int model, int grid_id, int *shape, int rank)
    int bmi_get_grid_size(int model, int grid_id, int *size)
    int bmi_get_grid_spacing(int model, int grid_id, float *spacing, int rank)
    int bmi_get_grid_origin(int model, int grid_id, float *origin, int rank)
    int bmi_get_grid_x(int model, int grid_id, float *x, int size)
    int bmi_get_grid_y(int model, int grid_id, float *y, int size)
    int bmi_get_grid_z(int model, int grid_id, float *z, int size)
    int bmi_get_grid_connectivity(int model, int grid_id, int *conn, int size)
    int bmi_get_grid_offset(int model, int grid_id, int *offset, int size)
    int bmi_get_var_type(int model, char *var_name, int n, char *type, int m)
    int bmi_get_var_units(int model, char *var_name, int n, char *units, int m)
    int bmi_get_var_itemsize(int model, char *var_name, int n, int *itemsize)
    int bmi_get_var_nbytes(int model, char *var_name, int n, int *nbytes)
    int bmi_get_value_int(int model, char *var_name, int n, void *buffer, int size)
    int bmi_get_value_float(int model, char *var_name, int n, void *buffer, int size)
    int bmi_get_value_double(int model, char *var_name, int n, void *buffer, int size)


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
        name = ' '*BMI_MAX_COMPONENT_NAME
        bname = bytes(name.encode('utf-8'))
        ok_or_raise(bmi_get_component_name(self._bmi, bname,
                                           BMI_MAX_COMPONENT_NAME))
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
            names[0] = <char*>malloc(count * BMI_MAX_VAR_NAME * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + BMI_MAX_VAR_NAME

            ok_or_raise(<int>bmi_get_input_var_names(self._bmi, names, count))

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
            names[0] = <char*>malloc(count * BMI_MAX_VAR_NAME * sizeof(char))
            for i in range(1, count):
                names[i] = names[i - 1] + BMI_MAX_VAR_NAME

            ok_or_raise(<int>bmi_get_output_var_names(self._bmi, names, count))

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
        units = ' '*BMI_MAX_UNITS_NAME
        bunits = bytes(units.encode('utf-8'))
        ok_or_raise(bmi_get_time_units(self._bmi, bunits,
                                       BMI_MAX_UNITS_NAME))
        return bunits.decode('utf-8').rstrip()

    def update(self):
        status = bmi_update(self._bmi)
        ok_or_raise(status)

    def update_frac(self, time_frac):
        status = bmi_update_frac(self._bmi, time_frac)
        ok_or_raise(status)

    def update_until(self, time_later):
        status = bmi_update_until(self._bmi, time_later)
        ok_or_raise(status)

    def get_var_grid(self, var_name):
        cdef int grid_id
        n = len(var_name)
        _var_name = bytes(var_name.encode('utf-8'))
        ok_or_raise(<int>bmi_get_var_grid(self._bmi, _var_name, n,
                                          &grid_id))
        return grid_id

    def get_grid_type(self, grid_id):
        grid_type = ' '*BMI_MAX_TYPE_NAME
        bgrid_type = bytes(grid_type.encode('utf-8'))
        ok_or_raise(bmi_get_grid_type(self._bmi, grid_id, bgrid_type,
                                       BMI_MAX_TYPE_NAME))
        return bgrid_type.decode('utf-8').rstrip()

    def get_grid_rank(self, grid_id):
        cdef int rank
        ok_or_raise(<int>bmi_get_grid_rank(self._bmi, grid_id, &rank))
        return rank

    def get_grid_size(self, grid_id):
        cdef int size
        ok_or_raise(<int>bmi_get_grid_size(self._bmi, grid_id, &size))
        return size

    def get_grid_shape(self, grid_id):
        cdef int rank = self.get_grid_rank(grid_id)
        cdef np.ndarray[int, ndim=1, mode="c"] \
            shape = np.empty(rank, dtype=np.intc)
        ok_or_raise(<int>bmi_get_grid_shape(self._bmi, grid_id,
                                            &shape[0], rank))
        return shape

    def get_grid_spacing(self, grid_id):
        cdef int rank = self.get_grid_rank(grid_id)
        cdef np.ndarray[float, ndim=1, mode="c"] \
            spacing = np.empty(rank, dtype=np.float32)
        ok_or_raise(<int>bmi_get_grid_spacing(self._bmi, grid_id,
                                              &spacing[0], rank))
        return spacing

    def get_grid_origin(self, grid_id):
        cdef int rank = self.get_grid_rank(grid_id)
        cdef np.ndarray[float, ndim=1, mode="c"] \
            origin = np.empty(rank, dtype=np.float32)
        ok_or_raise(<int>bmi_get_grid_origin(self._bmi, grid_id,
                                             &origin[0], rank))
        return origin

    def get_grid_x(self, grid_id):
        cdef int size = self.get_grid_size(grid_id)
        cdef np.ndarray[float, ndim=1, mode="c"] \
            grid_x = np.empty(size, dtype=np.float32)
        ok_or_raise(<int>bmi_get_grid_x(self._bmi, grid_id,
                                        &grid_x[0], size))
        return grid_x

    def get_grid_y(self, grid_id):
        cdef int size = self.get_grid_size(grid_id)
        cdef np.ndarray[float, ndim=1, mode="c"] \
            grid_y = np.empty(size, dtype=np.float32)
        ok_or_raise(<int>bmi_get_grid_y(self._bmi, grid_id,
                                        &grid_y[0], size))
        return grid_y

    def get_grid_z(self, grid_id):
        cdef int size = self.get_grid_size(grid_id)
        cdef np.ndarray[float, ndim=1, mode="c"] \
            grid_z = np.empty(size, dtype=np.float32)
        ok_or_raise(<int>bmi_get_grid_z(self._bmi, grid_id,
                                        &grid_z[0], size))
        return grid_z

    def get_grid_connectivity(self, grid_id):
        cdef int size = self.get_grid_size(grid_id)
        cdef np.ndarray[int, ndim=1, mode="c"] \
            conn = np.empty(size, dtype=np.intc)
        ok_or_raise(<int>bmi_get_grid_connectivity(self._bmi, grid_id,
                                                   &conn[0], size))
        return conn

    def get_grid_offset(self, grid_id):
        cdef int size = self.get_grid_size(grid_id)
        cdef np.ndarray[int, ndim=1, mode="c"] \
            offset = np.empty(size, dtype=np.intc)
        ok_or_raise(<int>bmi_get_grid_offset(self._bmi, grid_id,
                                             &offset[0], size))
        return offset

    def get_var_type(self, var_name):
        n = len(var_name)
        _var_name = bytes(var_name.encode('utf-8'))
        var_type = ' '*BMI_MAX_TYPE_NAME
        _var_type = bytes(var_type.encode('utf-8'))
        ok_or_raise(<int>bmi_get_var_type(self._bmi, _var_name, n,
                                          _var_type, BMI_MAX_TYPE_NAME))
        return _var_type.decode('utf-8').rstrip()

    def get_var_units(self, var_name):
        n = len(var_name)
        _var_name = bytes(var_name.encode('utf-8'))
        var_units = ' '*BMI_MAX_UNITS_NAME
        _var_units = bytes(var_units.encode('utf-8'))
        ok_or_raise(<int>bmi_get_var_units(self._bmi, _var_name, n,
                                           _var_units, BMI_MAX_UNITS_NAME))
        return _var_units.decode('utf-8').rstrip()

    def get_var_itemsize(self, var_name):
        cdef int itemsize
        n = len(var_name)
        _var_name = bytes(var_name.encode('utf-8'))
        ok_or_raise(<int>bmi_get_var_itemsize(self._bmi, _var_name, n,
                                              &itemsize))
        return itemsize

    def get_var_nbytes(self, var_name):
        cdef int nbytes
        n = len(var_name)
        _var_name = bytes(var_name.encode('utf-8'))
        ok_or_raise(<int>bmi_get_var_nbytes(self._bmi, _var_name, n,
                                              &nbytes))
        return nbytes

    def get_value_int(self, var_name, grid_size):
        cdef np.ndarray[int, ndim=1, mode="c"] \
            buffer = np.empty(grid_size, dtype=np.intc)
        ok_or_raise(<int>bmi_get_value_float(self._bmi, var_name,
                                             len(var_name),
                                             buffer.data, grid_size))

    def get_value_float(self, var_name, grid_size):
        cdef np.ndarray[float, ndim=1, mode="c"] \
            buffer = np.empty(grid_size, dtype=np.float32)
        ok_or_raise(<int>bmi_get_value_float(self._bmi, var_name,
                                             len(var_name),
                                             buffer.data, grid_size))
        return buffer

    def get_value_double(self, var_name, grid_size):
        cdef np.ndarray[double, ndim=1, mode="c"] \
            buffer = np.empty(grid_size, dtype=np.float64)
        ok_or_raise(<int>bmi_get_value_float(self._bmi, var_name,
                                             len(var_name),
                                             buffer.data, grid_size))
        return buffer

    def get_value(self, var_name):
        cdef int grid_id = self.get_var_grid(var_name)
        cdef int grid_size = self.get_grid_size(grid_id)
        type = self.get_var_type(var_name)

        _var_name = bytes(var_name.encode('utf-8'))

        if type.startswith('double'):
            buffer = self.get_value_double(_var_name, grid_size)
        elif type.startswith('int'):
            buffer = self.get_value_int(_var_name, grid_size)
        else:
            buffer = self.get_value_float(_var_name, grid_size)

        return buffer

