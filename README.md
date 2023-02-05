# Berry OS

[![GPL2 License](https://img.shields.io/badge/license-GPL2-blue.svg?style=flat)](LICENSE)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/yui0/berry-os)
![Lines of code](https://img.shields.io/tokei/lines/github/yui0/berry-os)
![GitHub Repo stars](https://img.shields.io/github/stars/yui0/berry-os?style=social)
![GitHub release (latest by date)](https://img.shields.io/github/v/release/yui0/berry-os)

The android emulator based on android-x86 environment via QEMU and VirGL with libhoudini support.

## Features

* Android 9 Pie
* x86-based
* Based on Android-x86 and Bliss OS
* libhoudini support (arm64, arm)
* Read + Write system
* [MicroG](https://microg.org/download.html)

## Download

* RPM [https://github.com/yui0/berry-os/releases](https://github.com/yui0/berry-os/releases)

## How to install QEMU-VirGL on Fedora 37

```
dnf install \
qemu-ui-gtk \
qemu-system-x86-core \
qemu-device-display-virtio-vga-gl \
qemu-device-display-virtio-vga \
qemu-device-display-virtio-gpu-pci-gl \
qemu-device-display-virtio-gpu-pci \
qemu-device-display-virtio-gpu \
qemu-device-display-virtio-gpu-gl \
qemu-device-display-virtio-gpu-ccw \
virglrenderer

dnf install android-tools
```

## How to use

```
$ berry-os
```

* Connect Wi-Fi to VirtWifi
* If use MicroG, check Google device registration, Cloud Messaging, Google SafetyNet
* If needed, enable native bridge

## List of compatible applications

* Genshin Impact
* alice gear aegis
* Evertale

## Tips

```default.prop
ro.adb.secure=1
ro.secure=1
ro.debuggable=0
persist.sys.usb.config=mtp
```

```build.prop
ro.build.type=user
```

## ref.

* Android-x86
  * https://sourceforge.net/projects/blissos-dev/files/Android-Generic/PC/
  * https://www.android-x86.org/download
* houdini
  * https://github.com/tony-cloud/houdini9
  * https://threedots.ovh/blog/2020/12/houdini-run-arm-32-bit-and-64-bit-applications-on-an-x86_64-system/
* QEMU
  * https://github.com/Gamesmes90/qemu-android-x86/blob/master/qemu-android
* Open GApps
  * https://github.com/geeks-r-us/anbox-playstore-installer
* Bootanimations
  * https://forum.xda-developers.com/t/bootanimations-100-custom-flashable-bootanimations-for-all-resolutions.3059659/
* Other
  * https://github.com/TrinityEmulator/TrinityEmulator
  * https://github.com/openthos/openthos