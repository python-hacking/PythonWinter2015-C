cimport filetree_walk

__doc__ = 'Primitive ftw.h wrapper'

cpdef enum:
  FTW_F    # Regular file
  FTW_D    # Directory
  FTW_DNR  # Unreadable directory
  FTW_NS   # Unstatable file

cdef class Stat:
    cdef st_dev, st_ino, st_nlink, st_mode, st_uid, st_gid, st_rdev, st_size, st_blksize, st_blocks, st_atim, st_mtim, st_ctim
    def __init__(self):
        pass
    cdef set(self, const stat *s):
        self.st_dev = s.st_dev
        self.st_ino = s.st_ino
        self.st_nlink = s.st_nlink
        self.st_mode = s.st_mode
        self.st_uid = s.st_uid
        self.st_gid = s.st_gid
        self.st_rdev = s.st_rdev
        self.st_size = s.st_size
        self.st_blksize = s.st_blksize
        self.st_blocks = s.st_blocks
        self.st_atim = s.st_atim
        self.st_mtim = s.st_mtim
        self.st_ctim = s.st_ctim

cdef int c_callback(const char *filename, const stat *status, int flag):
    global global_callback
    print filename
    return global_callback(filename, Stat().set(status), flag)

cpdef pyftw(dirpath, callback, max_desc):
    global global_callback
    global_callback = callback
    ftw(dirpath, &c_callback, max_desc)
