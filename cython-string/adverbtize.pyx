cimport cython


STR_BUFFER_SIZE = 2048

cdef extern:
    void c_adverbtize(char *x, int nx, char *r, int nr)


def adverbtize(str x not None):
    nx = len(x)
    cx = bytes(x.encode('utf-8'))

    nr = STR_BUFFER_SIZE
    r = ' '*nr
    cr = bytes(r.encode('utf-8'))
 
    c_adverbtize(cx, nx, cr, nr)

    return cr.decode('utf-8').rstrip()
