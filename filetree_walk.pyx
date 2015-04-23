cimport filetree_walk

__doc__ = 'Primitive ftw.h wrapper'

cdef class Stat:
    def __init__(self):
        pass
    cdef set(self, const stat *s):
        pass

cdef int c_callback(const char *filename, const stat *status, int flag):
    global global_callback
    print filename
    return global_callback(filename, Stat().set(status), flag)

cpdef pyftw(dirpath, callback, max_desc):
    global global_callback
    global_callback = callback
    ftw(dirpath, &c_callback, max_desc)
