#!/bin/sh

config=$HOME/.local/share/berry-os/config
GUI=1

nope() {
  if [ $GUI -eq 1 ]; then
    zenity --width=240 --error --text="$1" --title="Error"
  else
    echo "$1"
  fi
  exit 1
}

# Check for config file, source
if [ -e ${config} ]; then
  . ${config}
else
  #nope "Copy /opt/berry-os/config to ${config} and modify.  It explains things."
  cp /opt/berry-os/config ${config}
fi

# Set meaningful defaults
#IN_SUDO=0
IN_TERMINAL=0
RAM=${RAM:-8192}
CORES=${CORES:-2}
data=${DATA:-"${HOME}/.local/share/berry-os/data.vmdk"}
datasize=${DATASIZE:-2048}
CPU=${CPU:-"host"}
NETPORT=${NETPORT:-4444}
# TODO figure out why GTK doesn't work on all my machines.  Might obviate the need to URXVT for serial console
VGALINE=${VGALINE:-"-device virtio-vga-gl -display gtk,grab-on-hover=on,gl=on"}

# Test for system images:
# TODO add ability for r/w system image
sys=${SYSTEMIMG:-"/opt/berry-os/berry-os.img"}
initrd=${INITRD:-"/opt/berry-os/initrd.img"}
ram=${RAMDISK:-"/opt/berry-os/ramdisk.img"}
kernel=${KERNEL:-"/opt/berry-os/kernel"}

if [ ! -e $sys ] || [ ! -e $initrd ] || [ ! -e $ram ] || [ ! -e $kernel ]; then
  nope "System images aren't installed.  Check your berry-os package."
fi

QEMU="/usr/bin/qemu-system-x86_64"
if [ ! -x $QEMU ]; then
	nope "Please install the 'qemu' package to run."
fi

if [ ! -r ${data} ]; then
  mkdir -p ~/.local/share/berry-os/
  pushd ~/.local/share/berry-os/
  unzip -x /opt/berry-os/data.zip
  popd
  #dd if=/dev/zero of=${data} bs=1M count=${datasize}
  #mkfs.ext4 -F -m1 ${data}
  #qemu-img create -f vmdk ${data} 40G
fi

SERIAL_QEMULINE=""
if [ ! -z ${SERIAL:+x} ]; then
  SERIAL_QEMULINE="-serial $SERIAL"
  [ $SERIAL == "mon:stdio" ] && IN_TERMINAL=1
fi

#echo -e "CPU: $CPU\nRAM: $RAM\nCORES: $CORES\nDATA: $DATA\n"
#echo -e "DATASIZE: $DATASIZE\nSERIAL: $SERIAL\nVIDEO: $VIDEO\n"
#echo -e "VGALINE: $VGALINE\nBRIDGE: $BRIDGE"

if [ -z $BRIDGE ]; then
  NET_QEMULINE="-netdev user,id=anet0,hostfwd=tcp::$NETPORT-:5000 -device virtio-net-pci,netdev=anet0"
else
  NET_QEMULINE="-netdev bridge,br=$BRIDGE,id=anet0 -device virtio-net-pci,netdev=anet0"
fi
#-net nic,model=virtio-net-pci -net user,hostfwd=tcp::4444-:5555 \

#DO_CMD=""
#[ $IN_TERMINAL -eq 1 ] && [ $GUI -eq 1 ] && DO_CMD+="$URXVT -title Console -e "

# KMS
echo 1 > /sys/kernel/mm/ksm/run

#-device qemu-xhci,id=xhci0 -device usb-tablet,bus=xhci0.0 -device usb-kbd \
qemu-system-x86_64 \
-enable-kvm \
-M q35 \
-m $RAM -smp $CORES -cpu $CPU \
-machine vmport=off \
-audiodev alsa,id=snd0,out.dev=hw:0.0 \
-usb -device usb-tablet -device usb-kbd \
-device virtio-vga-gl -display gtk,grab-on-hover=on,gl=on \
-drive index=0,if=virtio,id=system,file=${sys},format=raw \
-drive index=1,if=virtio,id=ramdisk,file=${ram},format=raw \
-drive index=2,if=virtio,id=data,file=${data},format=vmdk \
-initrd ${initrd} \
-kernel ${kernel} -append "root=/dev/ram0 RAMDISK=vdb DATA=vdc SRC=/berry SETUPWIZARD=0" \
$NET_QEMULINE $SERIAL_QEMULINE
