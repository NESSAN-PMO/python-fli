#!/usr/bin/env python3

# import FLIPro.pyflipro as lib

# print(bytes(lib.GetAPIVersion()))
# cf = lib.GetCameraList()[0][0]
# cam = lib.CameraOpen(cf)
# print(cam)
# print(lib.GetDeviceVersion(cam))
# #lib.SetTemperatureSetPoint(cam, 25)
# #lib.SetFanEnable(cam, True)
# lib.CameraClose(cam)


import numpy as np
from astropy.io import fits
import time

d = np.zeros((14192, 10640), dtype=np.uint16)
t0 = time.time()
fits.PrimaryHDU(data=d).writeto("c:\\temp\\test.fits", overwrite=True)
print(time.time() - t0)
