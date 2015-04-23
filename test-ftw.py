#!/usr/bin/python

from filetree_walk import *

#ftw_func_t
def callback(name, s, f):
    print ("DIR " if f in [FTW_D, FTW_DNR] else "") + name
    return 0

pyftw("./", callback, 16)
