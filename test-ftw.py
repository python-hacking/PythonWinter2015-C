#!/usr/bin/python

from filetree_walk import *

#ftw_func_t
def callback(name, s, f):
    print name
    return 0

pyftw("./", callback, 1)
