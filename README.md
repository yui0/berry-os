# BerryOS

The android emulator based on android-x86 environment via QEMU and VirGL with libhoudini support.

## Features

* libhoudini support (arm64, arm)
* Read + Write system
* [MicroG](https://microg.org/download.html)

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
sys=system.img
ram=ramdisk.img
initrd=initrd.img
kernel=kernel

qemu-system-x86_64 \
-enable-kvm \
-M q35 \
-m 8192 -smp 2 -cpu host \
-device AC97 \
-net nic,model=virtio-net-pci -net user,hostfwd=tcp::4444-:5555 \
-machine vmport=off \
-usb \
-device usb-tablet \
-device usb-kbd \
-device virtio-vga-gl -display gtk,grab-on-hover=on,gl=on \
-drive index=0,if=virtio,id=system,file=${sys},format=raw \
-drive index=1,if=virtio,id=ramdisk,file=${ramdisk.img},format=raw \
-drive index=2,if=virtio,id=data,file=${data.img},format=raw \
-initrd ${initrd} \
-kernel ${kernel} -append "root=/dev/ram0 RAMDISK=vdb DATA=vdc SETUPWIZARD=0"

adb connect localhost:4444
```

* Connect Wi-Fi to VirtWifi
* Check Google device registration, Cloud Messaging, Google SafetyNet by MicroG

Enable native bridge

##

* Genshin Impact
* Sonic Forces
* Evertale
* TempleRun

##

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
