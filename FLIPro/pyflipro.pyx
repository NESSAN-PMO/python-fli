import os
import sys
import warnings
import numpy as np

cimport cython
cimport libflipro as fli
cimport numpy as np
from libc.stdlib cimport malloc, free

np.import_array()

__all__ = []

def GetCameraList(DeviceInfo, NumDevices):
    return FPROCam_GetCameraList(DeviceInfo, NumDevices)