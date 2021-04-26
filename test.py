#!/usr/bin/env python3

import time
from astropy.io import fits
# import FLIPro.pyflipro as lib

# print(bytes(lib.GetAPIVersion()))
# cf = lib.GetCameraList()[0][0]
# cam = lib.CameraOpen(cf)
# print(cam)
# print(lib.GetDeviceVersion(cam))
# #lib.SetTemperatureSetPoint(cam, 25)
# #lib.SetFanEnable(cam, True)
# lib.CameraClose(cam)

from FLI import Camera

c = Camera("FLI.usb.0")
c.Connected = True
c.StartExposure(0, 0)
time.sleep(1)
data = c.ImageArray
fits.PrimaryHDU(data=data).writeto("test.fits")
