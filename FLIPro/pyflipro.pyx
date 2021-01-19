import os
import sys
import warnings
# import numpy as np

cimport cython
cimport FLIPro.libflipro as fli
# cimport numpy as np
from libc.stdint cimport uint32_t, int32_t
from libc.stddef cimport wchar_t
from libcpp cimport bool

# np.import_array()

__all__ = []

def chkerr(err):
    if err < 0:
        raise OSError(-err, os.strerror(-err))
    elif err >= 0:
        pass
        #print(err)

def GetCameraList():
    cdef fli.FPRODEVICEINFO DeviceInfo[4]
    cdef uint32_t NumDevices = 4
    chkerr(fli.FPROCam_GetCameraList(DeviceInfo, &NumDevices))
    return (DeviceInfo, NumDevices)

def GetAPIVersion():
    cdef wchar_t Version[30]
    for i in range(30):
        Version[i] = 0
    cdef uint32_t Length = 30
    chkerr(fli.FPROCam_GetAPIVersion(Version, Length))
    return Version

def GetDeviceVersion(Handle):
    cdef fli.FPRODEVICEVERS Version
    chkerr(fli.FPROCam_GetDeviceVersion(Handle, &Version))
    return Version

def CameraOpen(Device):
    cdef int32_t Handle
    cdef fli.FPRODEVICEINFO dev = Device
    chkerr(fli.FPROCam_Open(&dev, &Handle))
    return Handle

def CameraClose(Handle):
    chkerr(fli.FPROCam_Close(Handle))

def SetTemperatureSetPoint(Handle, SetPoint):
    chkerr(fli.FPROCtrl_SetTemperatureSetPoint(Handle, SetPoint))

def SetFanEnable(Handle, On):
    #cdef bool 
    chkerr(fli.FPROCtrl_SetFanEnable(Handle, On))
