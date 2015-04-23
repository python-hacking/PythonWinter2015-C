from posix.types cimport *

cdef extern from "time.h":
    cdef struct timespec:
        time_t tv_sec             # Seconds.
        long int tv_nsec # Nanoseconds.
cdef extern from "bits/stat.h":
    cdef struct stat:
        dev_t st_dev        # Device.
        ino_t st_ino        # File serial number.
        nlink_t st_nlink        # Link count.
        mode_t st_mode        # File mode.
        uid_t st_uid        # User ID of the file's owner.
        gid_t st_gid        # Group ID of the file's group.
        int __pad0
        dev_t st_rdev        # Device number, if device.
        off_t st_size            # Size of file, in bytes.
        blksize_t st_blksize    # Optimal block size for I/O.
        blkcnt_t st_blocks        # Number 512-byte blocks allocated.
        timespec st_atim        # Time of last access.
        timespec st_mtim        # Time of last modification.
        timespec st_ctim        # Time of last status change.
        long int __unused[3]

cdef extern from "ftw.h":
    ctypedef int (*ftw_func_t) (const char *filename,
                                const stat *status,
                                int flag)

    int ftw (const char *dr, ftw_func_t func, int descriptors)
