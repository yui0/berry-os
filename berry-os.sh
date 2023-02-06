#!/bin/sh

sys=/opt/berry-os/berry-os.img
ram=/opt/berry-os/ramdisk.img
initrd=/opt/berry-os/initrd.img
kernel=/opt/berry-os/kernel

datasize=1000
data=~/.local/share/berry-os/data.img
if [ ! -r ${data} ]; then
   mkdir -p ~/.local/share/berry-os/
  dd if=/dev/zero of=${data} bs=1M count=${datasize}
  mkfs.ext4 -F -m1 ${data}
fi

qemu-system-x86_64 \
-enable-kvm \
-M q35 \
-m 8192 -smp 2 -cpu host \
-device AC97 \
-net nic,model=virtio-net-pci -net user,hostfwd=tcp::4444-:5555 \
-machine vmport=off \
-audiodev alsa,id=snd0,out.dev=hw:0.0 \
-usb \
-device usb-tablet \
-device usb-kbd \
-device virtio-vga-gl -display gtk,grab-on-hover=on,gl=on \
-drive index=0,if=virtio,id=system,file=${sys},format=raw \
-drive index=1,if=virtio,id=ramdisk,file=${ram},format=raw \
-drive index=2,if=virtio,id=data,file=${data},format=raw \
-initrd ${initrd} \
-kernel ${kernel} -append "root=/dev/ram0 RAMDISK=vdb DATA=vdc SRC=/berry SETUPWIZARD=0"
