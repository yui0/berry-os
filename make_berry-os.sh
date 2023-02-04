#!/bin/sh
# Berry OS: Make Berry
#	©2023 YUICHIRO NAKADA

: "defines" && {
  ver=9
  tdir=/tmp/berry-os
  cdir=`pwd`
  sys=/tmp/berry-os.img
  ram=/tmp/ramdisk.img
  initrd=/tmp/initrd.img
  kernel=/tmp/kernel
}

: "functions" && {
  # https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
  msg() {
      RED="\033[1;31m"
      GREEN="\033[0;32m"  # <-- [0 means not bold
      YELLOW="\033[1;33m" # <-- [1 means bold
      CYAN="\033[1;36m"
      INFO="\033[1;36m"

      NC="\033[0m" # No Color

      # printf "${(P)1}${2} ${NC}\n" # <-- zsh
      printf "${!1}${2} ${NC}\n" # <-- bash
  }
}

#[ ! -r ${sys} ] && wget
#unzip -x ${sys}

mkdir -p ${tdir}/opt/berry-os
cp -a ${sys} ${ram} ${initrd} ${kernel} ${tdir}/opt/berry-os/
cp -a berry-os.sh ${tdir}/opt/berry-os/
cp -a berry-os.spec ${tdir}/opt/berry-os/

pushd ${tdir}

tar cvJf berry-os-${ver}.tar.bz2 ./opt
rpmbuild -ta berry-os-${ver}.tar.bz2

popd
#rm -rf ${tdir}

