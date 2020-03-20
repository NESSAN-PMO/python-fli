import os
import sys
import warnings
# import numpy as np

cimport cython
cimport libflipro as fli
# cimport numpy as np
from libc.stdint cimport uint32_t, int32_t
from libc.stddef cimport wchar_t

# np.import_array()

__all__ = []

def GetCameraList():
    cdef fli.FPRODEVICEINFO DeviceInfo
    cdef uint32_t NumDevices
    print("hello")
    cdef int32_t status
    status = fli.FPROCam_GetCameraList(&DeviceInfo, &NumDevices)
    print(status)
    return (DeviceInfo, NumDevices)

def GetAPIVersion():
    cdef wchar_t Version
    cdef uint32_t Length = 30
    cdef int32_t status
    status = fli.FPROCam_GetAPIVersion(&Version, Length)
    print(status)
    return (Version)