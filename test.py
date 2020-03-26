#!/usr/bin/env python3

import FLIPro.pyflipro as lib

print(bytes(lib.GetAPIVersion()))
cf = lib.GetCameraList()[0][0]
cam = lib.CameraOpen(cf)
print(cam)
print(lib.GetDeviceVersion(cam))
#lib.SetTemperatureSetPoint(cam, 25)
#lib.SetFanEnable(cam, True)
lib.CameraClose(cam)