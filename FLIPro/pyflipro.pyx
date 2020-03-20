import os
import sys
import warnings
# import numpy as np

cimport cython
cimport libflipro as fli
# cimport numpy as np
from libc.stdint cimport uint32_t

# np.import_array()

__all__ = []

def GetCameraList():
    cdef fli.FPRODEVICEINFO DeviceInfo
    cdef uint32_t NumDevices
    fli.FPROCam_GetCameraList(&DeviceInfo, &NumDevices)
    return (DeviceInfo, NumDevices)