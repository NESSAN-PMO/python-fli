from libc.stdint cimport uint32_t, uint64_t, uint8_t, uint16_t, int32_t

cdef extern from "libflipro.h":

    ctypedef enum FPRODEVICETYPE:
        FPRO_CAM_DEVICE_TYPE_GSENSE400
        FPRO_CAM_DEVICE_TYPE_GSENSE2020
        FPRO_CAM_DEVICE_TYPE_GSENSE4040
        FPRO_CAM_DEVICE_TYPE_GSENSE6060
        FPRO_CAM_DEVICE_TYPE_KODAK47051
        FPRO_CAM_DEVICE_TYPE_KODAK29050
        FPRO_CAM_DEVICE_TYPE_DC230_42
        FPRO_CAM_DEVICE_TYPE_DC230_84
        FPRO_CAM_DEVICE_TYPE_DC4320

    ctypedef enum FPROCONNECTION:
        FPRO_CONNECTION_USB
        FPRO_CONNECTION_FIBRE

    ctypedef enum FPROUSBSPEED:
        FPRO_USB_FULLSPEED
        FPRO_USB_HIGHSPEED
        FPRO_USB_SUPERSPEED

    cdef struct device_info_t:
        wchar_t cFriendlyName[256]
        wchar_t cSerialNo[256]
        wchar_t cDevicePath[1024]
        FPROCONNECTION eConnType
        uint32_t uiVendorId
        uint32_t uiProdId
        FPROUSBSPEED eUSBSpeed

    ctypedef device_info_t FPRODEVICEINFO

    cdef struct device_version_info_t:
        wchar_t cFirmwareVersion[32]
        wchar_t cFPGAVersion[32]
        wchar_t cControllerVersion[32]
        wchar_t cHostHardwareVersion[32]

    ctypedef device_version_info_t FPRODEVICEVERS

    ctypedef enum FPROTESTIMAGETYPE:
        FLI_TESTIMAGE_TYPE_ROW
        FLI_TESTIMAGE_TYPE_COL

    ctypedef enum FPROEXTTRIGTYPE:
        FLI_EXT_TRIGGER_FALLING_EDGE
        FLI_EXT_TRIGGER_RISING_EDGE
        FLI_EXT_TRIGGER_EXPOSE_ACTIVE_LOW
        FLI_EXT_TRIGGER_EXPOSE_ACTIVE_HIGH

    ctypedef enum FPRODBGLEVEL:
        FPRO_DEBUG_NONE
        FPRO_DEBUG_ERROR
        FPRO_DEBUG_WARNING
        FPRO_DEBUG_INFO
        FPRO_DEBUG_DEBUG
        FPRO_DEBUG_TRACE

    ctypedef enum FPROGPSSTATE:
        FPRO_GPS_NOT_DETECTED
        FPRO_GPS_DETECTED_NO_SAT_LOCK
        FPRO_GPS_DETECTED_AND_SAT_LOCK

    ctypedef enum FPROSENSREADCFG:
        FPRO_SENSREAD_CB_BOTTOMLEFT
        FPRO_SENSREAD_CB_BOTTOMRIGHT
        FPRO_SENSREAD_CB_TOPLEFT
        FPRO_SENSREAD_CB_TOPRIGHT
        FPRO_SENSREAD_CB_ALL

    cdef struct sensor_mode_t:
        uint32_t uiModeIndex
        wchar_t wcModeName[32]

    ctypedef sensor_mode_t FPROSENSMODE

    ctypedef enum FPROGAINTABLE:
        FPRO_GAIN_TABLE_LOW_CHANNEL
        FPRO_GAIN_TABLE_HIGH_CHANNEL
        FPRO_GAIN_TABLE_CHANNEL_NUM

    cdef struct gain_value_t:
        uint32_t uiValue
        uint32_t uiDeviceIndex

    ctypedef gain_value_t FPROGAINVALUE

    ctypedef enum FPROBLACKADJUSTCHAN:
        FPRO_BLACK_ADJUST_CHAN_LDR
        FPRO_BLACK_ADJUST_CHAN_HDR

    cdef struct camera_capabilities_t:
        uint32_t uiSize
        uint32_t uiCapVersion
        uint32_t uiDeviceType
        uint32_t uiMaxPixelImageWidth
        uint32_t uiMaxPixelImageHeight
        uint32_t uiAvailablePixelDepths
        uint32_t uiBinningsTableSize
        uint32_t uiBlackLevelMax
        uint32_t uiBlackSunMax
        uint32_t uiLowGain
        uint32_t uiHighGain
        uint32_t uiReserved
        uint32_t uiRowScanTime
        uint32_t uiDummyPixelNum
        bool bHorizontalScanInvertable
        bool bVerticalScanInvertable
        uint32_t uiNVStorageAvailable
        uint32_t uiPreFrameReferenceRows
        uint32_t uiPostFrameReferenceRows
        uint32_t uiMetaDataSize

    ctypedef camera_capabilities_t FPROCAP

    ctypedef enum FPROAUXIO:
        FPRO_AUXIO_1
        FPRO_AUXIO_2
        FPRO_AUXIO_3
        FPRO_AUXIO_4

    ctypedef enum FPROAUXIO_DIR:
        FPRO_AUXIO_DIR_IN
        FPRO_AUXIO_DIR_OUT

    ctypedef enum FPROAUXIO_STATE:
        FPRO_AUXIO_STATE_LOW
        FPRO_AUXIO_STATE_HIGH

    ctypedef enum FPROAUXIO_EXPACTIVETYPE:
        FPRO_AUXIO_EXPTYPE_EXPOSURE_ACTIVE
        FPRO_AUXIO_EXPTYPE_GLOBAL_EXPOSURE_ACTIVE
        FPRO_AUXIO_EXPTYPE_FIRST_ROW_SYNC
        FPRO_AUXIO_EXPTYPE_RESERVED

    ctypedef enum FPROSTREAMERSTATUS:
        FPRO_STREAMER_STOPPED_ERROR
        FPRO_STREAMER_STOPPED
        FPRO_STREAMER_STREAMING

    cdef struct fpro_stream_stats_t:
        uint32_t uiNumFramesReceived
        uint64_t uiTotalBytesReceived
        uint64_t uiDiskFramesWritten
        double dblDiskAvgMBPerSec
        double dblDiskPeakMBPerSec
        FPROSTREAMERSTATUS iStatus
        uint32_t uiReserved

    ctypedef fpro_stream_stats_t FPROSTREAMSTATS

    ctypedef enum FPRO_FRAME_TYPE:
        FPRO_FRAMETYPE_NORMAL
        FPRO_FRAMETYPE_DARK
        FPRO_FRAMETYPE_BIAS
        FPRO_FRAMETYPE_LIGHTFLASH
        FPRO_FRAMETYPE_DARKFLASH

    ctypedef enum FPROCMS:
        FPROCMS_1
        FPROCMS_2
        FPROCMS_4

    cdef struct unpacked_images_t:
        uint8_t* pMetaData
        uint32_t uiMetaDataSize
        bool bMetaDataRequest
        uint16_t* pLowImage
        uint64_t uiLowImageSize
        bool bLowImageRequest
        uint16_t* pHighImage
        uint64_t uiHighImageSize
        bool bHighImageRequest
        uint16_t* pMergedImage
        uint64_t uiMergedImageSize
        bool bMergedImageRequest

    ctypedef unpacked_images_t FPROUNPACKEDIMAGES

    cdef struct int_point_t:
        int32_t X
        int32_t Y

    ctypedef int_point_t FPROPOINT

    cdef struct pixel_info_t:
        FPROPOINT ptPosition
        uint32_t uiValue

    ctypedef pixel_info_t FPROPIXELINFO

    cdef struct image_plane_stats_t:
        uint32_t uiLCutoff
        uint32_t uiUCutoff
        uint32_t uiHistogramSize
        double* pdblHistogram
        double dblMean
        double dblMedian
        double dblMode
        double dblStandardDeviation
        FPROPIXELINFO pixBrightest
        FPROPIXELINFO pixDimmest

    ctypedef image_plane_stats_t FPROPLANESTATS

    cdef struct unpacked_stats_t:
        FPROPLANESTATS statsLowImage
        bool bLowRequest
        FPROPLANESTATS statsHighImage
        bool bHighRequest
        FPROPLANESTATS statsMergedImage
        bool bMergedRequest

    ctypedef unpacked_stats_t FPROUNPACKEDSTATS

    int32_t FPROCam_GetCameraList(FPRODEVICEINFO* pDeviceInfo, uint32_t* pNumDevices)

    int32_t FPROCam_Open(FPRODEVICEINFO* pDevInfo, int32_t* pHandle)

    int32_t FPROCam_Close(int32_t iHandle)

    int32_t FPROCam_GetAPIVersion(wchar_t* pVersion, uint32_t uiLength)

    int32_t FPROCam_GetDeviceVersion(int32_t iHandle, FPRODEVICEVERS* pVersion)

    int32_t FPROFrame_CaptureAbort(int32_t iHandle)

    int32_t FPROFrame_CaptureEnd(int32_t iHandle)

    int32_t FPROFrame_CaptureStart(int32_t iHandle, uint32_t uiFrameCount)

    int32_t FPROFrame_CaptureStop(int32_t iHandle)

    int32_t FPROFrame_CaptureThumbnail(int32_t iHandle)

    int32_t FPROFrame_ComputeFrameSize(int32_t iHandle, uint32_t uiPixelWidth, uint32_t uiPixelHeight)

    void FPROFrame_FreeUnpackedBuffers(FPROUNPACKEDIMAGES* pUPBuffers)

    void FPROFrame_FreeUnpackedStatistics(FPROUNPACKEDSTATS* pStats)

    int32_t FPROFrame_GetDummyPixelEnable(int32_t iHandle, bool* pEnable)

    int32_t FPROFrame_GetFrameType(int32_t iHandle, FPRO_FRAME_TYPE* pType)

    int32_t FPROFrame_GetReferenceRowPostFrameCount(int32_t iHandle, uint32_t* pNumRows)

    int32_t FPROFrame_GetReferenceRowPreFrameCount(int32_t iHandle, uint32_t* pNumRows)

    int32_t FPROFrame_GetImageDataEnable(int32_t iHandle, bool* pEnable)

    int32_t FPROFrame_GetTestImageEnable(int32_t iHandle, bool* pEnable, FPROTESTIMAGETYPE* pFormat)

    int32_t FPROFrame_GetImageArea(int32_t iHandle, uint32_t* pColOffset, uint32_t* pRowOffset, uint32_t* pWidth, uint32_t* pHeight)

    int32_t FPROFrame_GetPixelConfig(int32_t iHandle, uint32_t* pPixelDepth, uint32_t* pPixelLSB)

    int32_t FPROFrame_GetThumbnailFrame(int32_t iHandle, uint8_t* pFrameData, uint32_t* pSize)

    int32_t FPROFrame_GetVideoFrame(int32_t iHandle, uint8_t* pFrameData, uint32_t* pSize, uint32_t uiTimeoutMS)

    int32_t FPROFrame_GetVideoFrameUnpacked(int32_t iHandle, uint8_t* pFrameData, uint32_t* pSize, uint32_t uiTimeoutMS, FPROUNPACKEDIMAGES* pUPBuffers, FPROUNPACKEDSTATS* pStats)

    int32_t FPROFrame_GetVideoFrameExt(int32_t iHandle, uint8_t* pFrameData, uint32_t* pSize)

    int32_t FPROFrame_IsAvailable(int32_t iHandle, bool* pAvailable)

    int32_t FPROFrame_SetDummyPixelEnable(int32_t iHandle, bool bEnable)

    int32_t FPROFrame_SetFrameType(int32_t iHandle, FPRO_FRAME_TYPE eType)

    int32_t FPROFrame_SetReferenceRowPostFrameCount(int32_t iHandle, uint32_t uiNumRows)

    int32_t FPROFrame_SetReferenceRowPreFrameCount(int32_t iHandle, uint32_t uiNumRows)

    int32_t FPROFrame_SetImageDataEnable(int32_t iHandle, bool bEnable)

    int32_t FPROFrame_SetTestImageEnable(int32_t iHandle, bool bEnable, FPROTESTIMAGETYPE eFormat)

    int32_t FPROFrame_SetTrackingArea(int32_t iHandle, uint32_t uiStartRow, uint32_t uiEndRow)

    int32_t FPROFrame_SetTrackingAreaEnable(int32_t iHandle, uint32_t uiNumTrackingFrames)

    int32_t FPROFrame_SetPixelConfig(int32_t iHandle, uint32_t uiPixelDepth, uint32_t uiPixelLSB)

    int32_t FPROFrame_SetImageArea(int32_t iHandle, uint32_t uiColOffset, uint32_t uiRowOffset, uint32_t uiWidth, uint32_t uiHeight)

    int32_t FPROCtrl_GetCoolerDutyCycle(int32_t iHandle, uint32_t* pDutyCycle)

    int32_t FPROCtrl_GetExposure(int32_t iHandle, uint64_t* pExposureTime, uint64_t* pFrameDelay, bool* pImmediate)

    int32_t FPROCtrl_GetExternalTriggerEnable(int32_t iHandle, bool* pEnable, FPROEXTTRIGTYPE* pTrigType)

    int32_t FPROCtrl_GetFanEnable(int32_t iHandle, bool* pOn)

    int32_t FPROCtrl_GetGPSState(int32_t iHandle, FPROGPSSTATE* pState)

    int32_t FPROCtrl_GetHeaterPower(int32_t iHandle, uint32_t* pPwrPercentage)

    int32_t FPROCtrl_GetIlluminationDelay(int32_t iHandle, uint32_t* pOnDelay, uint32_t* pOffDelay)

    int32_t FPROCtrl_GetIlluminationOn(int32_t iHandle, bool* pOn)

    int32_t FPROCtrl_GetLED(int32_t iHandle, bool* pOn)

    int32_t FPROCtrl_GetLEDDuration(int32_t iHandle, uint32_t* pDurationUsec)

    int32_t FPROCtrl_GetSensorTemperature(int32_t iHandle, int32_t* pTemp)

    int32_t FPROCtrl_GetSensorTemperatureReadEnable(int32_t iHandle, bool* pEnable)

    int32_t FPROCtrl_GetShutterOpen(int32_t iHandle, bool* pOpen)

    int32_t FPROCtrl_GetShutterOverride(int32_t iHandle, bool* pOverride)

    int32_t FPROCtrl_GetTemperatures(int32_t iHandle, double* pAmbientTemp, double* pBaseTemp, double* pCoolerTemp)

    int32_t FPROCtrl_GetTemperatureSetPoint(int32_t iHandle, double* pSetPoint)

    int32_t FPROCtrl_SetExposure(int32_t iHandle, uint64_t uiExposureTime, uint64_t uiFrameDelay, bool bImmediate)

    int32_t FPROCtrl_SetExposureEx(int32_t iHandle, uint64_t uiExposureTime, uint64_t uiFrameDelay, bool bImmediate, uint64_t* pActualExposureTime, uint64_t* pActualFrameDelay)

    int32_t FPROCtrl_SetExternalTriggerEnable(int32_t iHandle, bool bEnable, FPROEXTTRIGTYPE eTrigType)

    int32_t FPROCtrl_SetFanEnable(int32_t iHandle, bool bOn)

    int32_t FPROCtrl_SetHeaterPower(int32_t iHandle, uint32_t uiPwrPercentage)

    int32_t FPROCtrl_SetIlluminationDelay(int32_t iHandle, uint16_t uiOnDelay, uint16_t uiOffDelay)

    int32_t FPROCtrl_SetIlluminationOn(int32_t iHandle, bool bOn)

    int32_t FPROCtrl_SetLED(int32_t iHandle, bool bOn)

    int32_t FPROCtrl_SetLEDDuration(int32_t iHandle, uint32_t uiDurationUSec)

    int32_t FPROCtrl_SetSensorTemperatureReadEnable(int32_t iHandle, bool bEnable)

    int32_t FPROCtrl_SetShutterOpen(int32_t iHandle, bool bOpen)

    int32_t FPROCtrl_SetShutterOverride(int32_t iHandle, bool bOverride)

    int32_t FPROCtrl_SetTemperatureSetPoint(int32_t iHandle, double dblSetPoint)

    int32_t FPROSensor_GetBinning(int32_t iHandle, uint32_t* pXBin, uint32_t* pYBin)

    int32_t FPROSensor_GetBinningTable(int32_t iHandle, uint32_t* pBinTable, uint32_t* pTableSizeBytes)

    int32_t FPROSensor_GetBlackLevelAdjust(int32_t iHandle, uint32_t* pAdjustValue)

    int32_t FPROSensor_GetBlackLevelAdjustEx(int32_t iHandle, FPROBLACKADJUSTCHAN eChan, uint32_t* pAdjustValue)

    int32_t FPROSensor_GetBlackSunAdjust(int32_t iHandle, uint32_t* pAdjustValue)

    int32_t FPROSensor_GetBlackSunAdjustEx(int32_t iHandle, FPROBLACKADJUSTCHAN eChan, uint32_t* pAdjustValue)

    int32_t FPROSensor_GetCapabilities(int32_t iHandle, FPROCAP* pCap, uint32_t* pCapLength)

    int32_t FPROSensor_GetGainIndex(int32_t iHandle, FPROGAINTABLE eTable, uint32_t* pGainIndex)

    int32_t FPROSensor_GetGainTable(int32_t iHandle, FPROGAINTABLE eTable, FPROGAINVALUE* pGainValues, uint32_t* pNumEntries)

    int32_t FPROSensor_GetHDREnable(int32_t iHandle, bool* pEnable)

    int32_t FPROSensor_GetMode(int32_t iHandle, uint32_t uiModeIndex, FPROSENSMODE* pMode)

    int32_t FPROSensor_GetModeCount(int32_t iHandle, uint32_t* pCount, uint32_t* pCurrentMode)

    int32_t FPROSensor_GetReadoutConfiguration(int32_t iHandle, FPROSENSREADCFG* pReadCfg)

    int32_t FPROSensor_GetSamplesPerPixel(int32_t iHandle, FPROCMS* pSamplesPerPixel)

    int32_t FPROSensor_GetScanDirection(int32_t iHandle, bool* pHInverted, bool* pVInverted)

    int32_t FPROSensor_GetTrainingEnable(int32_t iHandle, bool* pEnable)

    int32_t FPROSensor_SetBinning(int32_t iHandle, uint32_t uiXBin, uint32_t uiYBin)

    int32_t FPROSensor_SetBlackLevelAdjust(int32_t iHandle, uint32_t uiAdjustValue)

    int32_t FPROSensor_SetBlackLevelAdjustEx(int32_t iHandle, FPROBLACKADJUSTCHAN eChan, uint32_t uiAdjustValue)

    int32_t FPROSensor_SetBlackSunAdjust(int32_t iHandle, uint32_t uiAdjustValue)

    int32_t FPROSensor_SetBlackSunAdjustEx(int32_t iHandle, FPROBLACKADJUSTCHAN eChan, uint32_t uiAdjustValue)

    int32_t FPROSensor_SetGainIndex(int32_t iHandle, FPROGAINTABLE eTable, uint32_t uiGainIndex)

    int32_t FPROSensor_SetMode(int32_t iHandle, uint32_t uiModeIndex)

    int32_t FPROSensor_SetReadoutConfiguration(int32_t iHandle, FPROSENSREADCFG eReadCfg)

    int32_t FPROSensor_SetSamplesPerPixel(int32_t iHandle, FPROCMS eSamplesPerPixel)

    int32_t FPROSensor_SetScanDirection(int32_t iHandle, bool bHInverted, bool bVInverted)

    int32_t FPROSensor_SetTrainingEnable(int32_t iHandle, bool bEnable)

    int32_t FPROAuxIO_GetPin(int32_t iHandle, FPROAUXIO eAuxIO, FPROAUXIO_DIR* pDirection, FPROAUXIO_STATE* pState)

    int32_t FPROAuxIO_GetExposureActiveType(int32_t iHandle, FPROAUXIO_EXPACTIVETYPE* pType)

    int32_t FPROAuxIO_SetPin(int32_t iHandle, FPROAUXIO eAuxIO, FPROAUXIO_DIR eDirection, FPROAUXIO_STATE eState)

    int32_t FPROAuxIO_SetExposureActiveType(int32_t iHandle, FPROAUXIO_EXPACTIVETYPE eType)

    int32_t FPROFAck_GetEnable(int32_t iHandle, bool* pEnable)

    int32_t FPROFAck_SetEnable(int32_t iHandle, bool bEnable)

    int32_t FPROFAck_FrameAcknowledge(int32_t iHandle)

    int32_t FPROFAck_FrameResend(int32_t iHandle)

    int32_t FPROFAck_FlushImageQueue(int32_t iHandle)

    int32_t FPRONV_WriteNVStorage(int32_t iHandle, uint32_t uiOffset, uint8_t* pData, uint32_t uiLength)

    int32_t FPRONV_ReadNVStorage(int32_t iHandle, uint32_t uiOffset, uint8_t* pData, uint32_t uiLength)

    int32_t FPROCmd_SendRaw(int32_t iHandle, uint8_t* pData, uint32_t uiLength)

    int32_t FPROCmd_SendRecvRaw(int32_t iHandle, uint8_t* pTxData, uint32_t uiTxLength, uint8_t* pRxData, uint32_t* pRxLength)

    int32_t FPROCmd_ReadReg(int32_t iHandle, uint32_t uiReg, uint32_t* pValue)

    int32_t FPROCmd_WriteReg(int32_t iHandle, uint32_t uiReg, uint32_t uiValue, uint32_t uiMask)

    int32_t FPRODebug_EnableLevel(bool bEnable, FPRODBGLEVEL eLevel)

    int32_t FPRODebug_SetLogPath(wchar_t* pPath)

    void FPRODebug_Write(FPRODBGLEVEL eLevel, wchar_t* format)
