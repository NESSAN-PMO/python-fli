#!/usr/bin/env python3

import time
from astropy.io import fits
from FLIPro import Camera

c = Camera('usb.0')



# from FLI import Camera

# c = Camera("usb.0")
# c.Connected = True
# c.StartExposure(0, 0)
# time.sleep(1)
# data = c.ImageArray
# fits.PrimaryHDU(data=data).writeto("test.fits")
