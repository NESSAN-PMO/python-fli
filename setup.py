#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Setup script for pyfli.

"""
import numpy as np
import os
import platform
from setuptools import setup, Extension

system = platform.system()

flicom = "libfli-1.104"
fliwin = os.path.join(flicom, "windows")
fliunx = os.path.join(flicom, "unix")
flilin = os.path.join(fliunx, "linux")
flibsd = os.path.join(fliunx, "bsd")
fliosx = os.path.join(fliunx, "osx")

comsrc = [
    os.path.join(flicom, "libfli.c"),
    os.path.join(flicom, "libfli-camera.c"),
    os.path.join(flicom, "libfli-camera-parport.c"),
    os.path.join(flicom, "libfli-camera-usb.c"),
    os.path.join(flicom, "libfli-filter-focuser.c"),
    os.path.join(flicom, "libfli-mem.c")
]
unxsrc = [
    os.path.join(fliunx, "libfli-serial.c"),
    os.path.join(fliunx, "libfli-debug.c"),
    os.path.join(fliunx, "libfli-usb.c"),
    os.path.join(fliunx, "libfli-sys.c")
]
winsrc = [
    os.path.join(fliwin, "libfli-serial.c"),
    os.path.join(fliwin, "libfli-debug.c"),
    os.path.join(fliwin, "libfli-usb.c"),
    os.path.join(fliwin, "libfli-windows.c"),
    os.path.join(fliwin, "libfli-windows-parport.c"),
    os.path.join(flicom, "libfli-raw.c")
]
linsrc = [
    os.path.join(flilin, "libfli-usb-sys.c"),
    os.path.join(flilin, "libfli-parport.c")
]
bsdsrc = [
    os.path.join(flibsd, "libfli-usb-sys.c")
]
osxsrc = [
]

modpth = "FLI"
modsrc = [os.path.join(modpth, "pyfli.pyx")]
if system == "Linux":
    src = modsrc + comsrc + unxsrc + linsrc
    inc = [np.get_include(), modpth, flicom, fliunx, flilin]
    lib = []
    mac = []
elif system == "BSD":
    # not certain that BSD is the correct identifier
    src = modsrc + comsrc + unxsrc + bsdsrc
    inc = [np.get_include(), modpth, flicom, fliunx, flibsd]
    lib = []
    mac = []
elif system == "Darwin":
    src = modsrc + comsrc + unxsrc + osxsrc
    inc = [np.get_include(), modpth, flicom, fliunx, fliosx]
    lib = []
    mac = []
elif system == "Windows":
    src = modsrc + comsrc + winsrc
    inc = [np.get_include(), modpth, flicom, fliwin]
    lib = ["setupapi", "msvcrt", "ws2_32", "Advapi32"]
    mac = [("_LIB", None)]
else:
    raise RuntimeError("Unrecognized system")

compiler_settings = {
    'libraries': lib,
    'include_dirs': inc,
    'library_dirs': [],
    'define_macros': mac,
    'export_symbols': None
}
lib_pro = []
libdir_pro = []
mac_pro = []
inc_pro = ['FLIPro', np.get_include()]
data_pro = []
if platform.system() == "Windows":
    lib_pro += ["libflipro"]
    if platform.architecture()[0] == "64bit":
        inc_pro += [os.path.join("libflipro", "win64")]
        libdir_pro += [os.path.join("libflipro", "win64")]
        data_pro += [os.path.join("libflipro", "win64", "libflipro.dll")]
    elif platform.architecture()[0] == "32bit":
        inc_pro += [os.path.join("libflipro", "win32")]
        libdir_pro += [os.path.join("libflipro", "win32")]
        data_pro += [os.path.join("libflipro", "win32", "libflipro.dll")]
src_pro = [os.path.join("FLIPro", "pyflipro.pyx")]
compiler_pro = {
    'libraries': lib_pro,
    'include_dirs': inc_pro,
    'library_dirs': libdir_pro,
    'define_macros': mac_pro,
    'export_symbols': None
}


ext_modules = [Extension('FLI.pyfli', src, **compiler_settings),
               Extension('FLIPro.pyflipro', src_pro, **compiler_pro)]


setup(
    name="python-fli",
    version="1.2",
    author="Fockez Zhang",
    author_email="fockez@live.com",
    download_url=" ",
    keywords=["FLI", "fli"],
    description="Python Interface for Finger Lakes Instrumention with ASCOM compatible API",
    packages=['FLI', 'FLIPro'],
    package_dir={'FLI': 'FLI', 'FLIPro': 'FLIPro'},
    data_files=[(os.path.join('..', '..', 'FLIPro'), data_pro)],
    ext_modules=ext_modules,
    requires=['numpy (>=1.5)'],
    classifiers=[
        "Development Status :: 3 - Beta",
        "Intended Audience :: Developers",
        "Intended Audience :: Science/Research",
        "License :: OSI Approved :: BSD License",
        "Operating System :: POSIX :: Linux",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: Microsoft :: Windows :: Windows 10",
        "Programming Language :: Python :: 3",
        "Programming Language :: Cython",
        "Topic :: Scientific/Engineering",
        "Topic :: Scientific/Engineering :: Astronomy",
        "Topic :: Software Development :: Libraries :: Python Modules"
    ],
    long_description="""\
This package supplies ASCOM compatible API of Pyhton for the Finger Lakes
Instrumentation camera on Linux and Windows, to meet the performance for 
camera image aquisition in Python. The fli SDK module comes from 
Charles R. Harris' pyfli package https://github.com/charris/pyfli.

"""
)
