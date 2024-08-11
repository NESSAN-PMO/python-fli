import os
import sys
import warnings
import numpy as np

cimport cython
cimport libflipro as fli
cimport numpy as np
from libc.stdint cimport uint32_t, int32_t
from libc.stddef cimport wchar_t
from libcpp cimport bool

np.import_array()

__all__ = ['GetCameraList', 'GetAPIVersion', 'GetDeviceVersion', 
'CameraOpen', 'CameraClose', 'SetTemperatureSetPoint',
'SetFanEnable']

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

def GetHostSerialNumbers(Handle):
    cdef wchar_t Fibre[32]
    cdef wchar_t Pcie[32]
    cdef uint32_t Length = 32
    chkerr(fli.FPROCam_GetHostSerialNumbers(Handle, &Fibre, &Pcie, Length))
    return (Fibre, Pcie)

def Open(Device):
    cdef int32_t Handle
    cdef fli.FPRODEVICEINFO dev = Device
    chkerr(fli.FPROCam_Open(&dev, &Handle))
    return Handle

def Close(Handle):
    chkerr(fli.FPROCam_Close(Handle))

def CaptureAbort(Handle):
    chkerr(fli.FPROFrame_CaptureAbort(Handle))

def CaptureStart(Handle, FrameCount):
    chkerr(fli.FPROFrame_CaptureStart(Handle, <uint32_t> FrameCount))

def CaptureStop(Handle):
    chkerr(fli.FPROFrame_CaptureStop(Handle))

def ComputeFrameSize(Handle):
    size = fli.FPROFrame_ComputeFrameSize(Handle)
    chkerr(size)
    return size

def ComputeFrameSizePixels(Handle):
    cdef uint32_t TotalWidth
    cdef uint32_t TotalHeight
    chkerr(fli.FPROFrame_ComputeFrameSizePixels(Handle, &TotalWidth, &TotalHeight))
    return (TotalWidth, TotalHeight)

def GetImageArea(Handle):
    cdef uint32_t ColOffset
    cdef uint32_t RowOffset
    cdef uint32_t Width
    cdef uint32_t Height
    chkerr(fli.FPROFrame_GetImageArea(Handle, &ColOffset, &RowOffset, &Width, &Height))
    return (ColOffset, RowOffset, Width, Height)

def 

def SetTemperatureSetPoint(Handle, SetPoint):
    chkerr(fli.FPROCtrl_SetTemperatureSetPoint(Handle, SetPoint))

def SetFanEnable(Handle, On):
    cdef bool On
    chkerr(fli.FPROCtrl_SetFanEnable(Handle, On))
