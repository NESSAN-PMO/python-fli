'''
@Description:
@Author: F.O.X
@Date: 2020-03-08 00:01:00
@LastEditor: F.O.X
LastEditTime: 2022-09-10 02:44:40
'''

from .pyfli import *


class Camera():
    def __init__(self, name):
        self.interface, num = name.split('.')
        self.camname = FLIList(self.interface, 'camera')[int(num)][0]
        self.cooler = False
        self.exptime = 0
        self.setemp = 20

    def __del__(self):
        if self.Connected is True:
            FLIClose(self.cam)

    @property
    def Connected(self):
        try:
            getDeviceStatus(self.cam)
            return True
        except:
            return False

    @Connected.setter
    def Connected(self, value):
        if value is True and self.Connected is False:
            self.cam = FLIOpen(self.camname, self.interface, 'camera')

            ul_x, ul_y, lr_x, lr_y = getVisibleArea(
                self.cam)
            self.sizex = lr_x - ul_x
            self.sizey = lr_y - ul_y
            self.offsetx = ul_x
            self.offsety = ul_y
            aul_x, aul_y, alr_x, alr_y = getArrayArea(
                self.cam)
            self.sizeax = alr_x - aul_x
            self.sizeay = alr_y - aul_y

            self.startx = 0
            self.starty = 0
            self.numx = self.sizex
            self.numy = self.sizey
            self.binx = 1
            self.biny = 1
            self.SetImageArea()

            self.psx, self.psy = getPixelSize(self.cam)
            n = 0
            modes = []
            while 1:
                try:
                    modes.append(getCameraModeString(self.cam, n))
                    n += 1
                except:
                    break
            self.modes = tuple(modes)
            self.model = getModel(self.cam)
            self.sn = getSerialString(self.cam)
            self.lib = getLibVersion()
            self.fw = getFWRevision(self.cam)
            self.hw = getHWRevision(self.cam)

        elif value is False and self.Connected is True:
            FLIClose(self.cam)
        else:
            pass

    def SetImageArea(self):
        if (self.numx + self.startx) * self.binx >= self.sizex:
            self.numx = int(self.sizex / self.binx - self.startx)
        if (self.numy + self.starty) * self.biny >= self.sizey:
            self.numy = int(self.sizey / self.biny - self.starty)
        setImageArea(self.cam, self.startx + self.offsetx / self.binx,
                     self.starty + self.offsety / self.biny,
                     self.startx + self.numx + self.offsetx / self.binx,
                     self.starty + self.numy + self.offsety / self.biny)

    @property
    def BinX(self):
        return getReadoutDimensions(self.cam)[2]

    @BinX.setter
    def BinX(self, value):
        if value <= 16 and value >= 1:
            setHBin(self.cam, value)
            self.binx = int(value)
            self.SetImageArea()

    @property
    def BinY(self):
        return getReadoutDimensions(self.cam)[5]

    @BinX.setter
    def BinY(self, value):
        if value <= 16 and value >= 1:
            setVBin(self.cam, value)
            self.biny = int(value)
            self.SetImageArea()

    @property
    def NumX(self):
        return getReadoutDimensions(self.cam)[0]

    @NumX.setter
    def NumX(self, value):
        if value > 0:
            self.numx = int(value)
            self.SetImageArea()
        else:
            raise ValueError("Invalid value")

    @property
    def NumY(self):
        return getReadoutDimensions(self.cam)[3]

    @NumY.setter
    def NumY(self, value):
        if value > 0:
            self.numy = int(value)
            self.SetImageArea()
        else:
            raise ValueError("Invalid value")

    @property
    def StartX(self):
        return getReadoutDimensions(self.cam)[1] - self.offsetx

    @StartX.setter
    def StartX(self, value):
        if value >= 0 and value < self.sizex:
            self.startx = int(value)
            self.SetImageArea()

    @property
    def StartY(self):
        return getReadoutDimensions(self.cam)[4] - self.offsety

    @StartY.setter
    def StartY(self, value):
        if value >= 0 and value < self.sizey:
            self.starty = int(value)
            self.SetImageArea()

    def StartExposure(self, exp, light):
        setExposureTime(self.cam, exp * 1000)
        self.exptime = exp * 1000
        setCameraMode(self.cam, 0)
        if light:
            setFrameType(self.cam, 'normal')
        else:
            setFrameType(self.cam, 'dark')
        exposeFrame(self.cam)

    @property
    def CameraState(self):
        s = getDeviceStatus(self.cam)
        if s == CAMERA_STATUS_UNKNOWN:
            return 5
        elif s & 0x03 == 0x00:
            return 0
        elif s & 0x03 == 0x01:
            return 1
        elif s & 0x03 == 0x02:
            return 2
        elif s & 0x03 == 0x03:
            return 3

    @property
    def CameraXSize(self):
        return self.sizex

    @property
    def CameraYSize(self):
        return self.sizey

    @property
    def CanAbortExposure(self):
        return True

    @property
    def CanAsymmetricBin(self):
        return True

    @property
    def CanFastReadout(self):
        return False

    @property
    def CanGetCoolerPower(self):
        return True

    @property
    def CanPulseGuide(self):
        return False

    @property
    def CanSetCCDTemperature(self):
        return True

    @property
    def CanStopExposure(self):
        return False

    @property
    def CCDTemperature(self):
        return getTemperature(self.cam)

    @property
    def CoolerOn(self):
        return self.cooler

    @CoolerOn.setter
    def CoolerOn(self, value):
        if value:
            self.cooler = True
            setTemperature(self.cam, self.setemp)
        else:
            self.cooler = False
            setTemperature(self.cam, 25)

    @property
    def CoolerPower(self):
        return getCoolerPower(self.cam)

    @property
    def HeatSinkTemperature(self):
        # return readTemperature(self.cam, TEMPERATURE_BASE)
        return getTemperature(self.cam)

    @property
    def ImageReady(self):
        s = getDeviceStatus(self.cam)
        if s & 0x80000000 != 0:
            return True
        else:
            return False

    @property
    def ImageArray(self):
        return grabFrame(self.cam).transpose()

    @property
    def ImageArrayVariant(self):
        return grabFrame(self.cam).transpose()

    @property
    def LastExposureDuration(self):
        return 0

    @property
    def LastExposureStartTime(self):
        return 0

    @property
    def MaxBinX(self):
        return 16

    @property
    def MaxBinY(self):
        return 16

    @property
    def MaxADU(self):
        return 65535

    @property
    def PercentCompleted(self):
        return 0 if self.exptime == 0 else int((self.exptime - getExposureStatus(self.cam)) / self.exptime * 100)

    @property
    def PixelSizeX(self):
        return self.psx

    @property
    def PixelSizeY(self):
        return self.psy

    @property
    def ReadoutMode(self):
        return

    @property
    def ReadoutModes(self):
        return self.modes

    @property
    def ReadoutMode(self):
        return getCameraMode(self.cam)

    @ReadoutMode.setter
    def ReadoutMode(self, value):
        v = int(value)
        if v >= 0 and v < len(self.modes):
            setCameraMode(self.cam, v)

    @property
    def SensorType(self):
        return 0

    @property
    def SetCCDTemperature(self):
        return self.setemp

    @SetCCDTemperature.setter
    def SetCCDTemperature(self, value):
        if value < 45 and value > -55:
            self.setemp = value
            setTemperature(self.cam, self.setemp)
        else:
            raise ValueError("Invalid value")

    def AbortExposure(self):
        cancelExposure(self.cam)

    def StopExposure(self):
        endExposure(self.cam)

    @property
    def SensorName(self):
        return self.model + ':' + self.sn

    @property
    def Name(self):
        return self.model

    @property
    def Description(self):
        return f"{self.model}: HWVer {self.hw} FWVer {self.fw}"

    @property
    def DriverVersion(self):
        return self.lib.split()[-1]

    @property
    def InterfaceVersion(self):
        return "1"

    @property
    def DriverInfo(self):
        return self.lib
