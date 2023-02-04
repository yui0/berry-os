%define DISTDIR	/opt

Summary: berry-os
Name: berry-os
Version: 9
Release: b1
License: GPL2
Group: Applications/System
Source: %{name}-%{version}.tar.bz2
URL: https://berry-japan.com/
BuildRoot: %{_tmppath}/%{name}-%{version}-root
Requires: qemu-ui-gtk
Requires: qemu-system-x86-core
Requires: qemu-device-display-virtio-vga-gl
Requires: qemu-device-display-virtio-vga
Requires: qemu-device-display-virtio-gpu-pci-gl
Requires: qemu-device-display-virtio-gpu-pci
Requires: qemu-device-display-virtio-gpu
Requires: qemu-device-display-virtio-gpu-gl
Requires: qemu-device-display-virtio-gpu-ccw
Requires: virglrenderer
NoSource: 0

%description
Android Applications on Real Linux.


%prep
rm -rf $RPM_BUILD_ROOT
%setup -c -q

%install
rm -rf $RPM_BUILD_ROOT

mkdir -p $RPM_BUILD_ROOT{%{DISTDIR}/berry-os,%{_bindir}}
cp -a opt/berry-os/* $RPM_BUILD_ROOT%{DISTDIR}/berry-os
ln -s /opt/berry-os/berry-os.sh $RPM_BUILD_ROOT/usr/bin/berry-os
rm $RPM_BUILD_ROOT%{DISTDIR}/berry-os/*.spec

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-, root, root, 0755)
/opt/berry-os/
#/usr/share/applications/
/usr/bin/berry-os


%changelog
* Wed Feb 1 2023 Yuichiro Nakada <berry@berry-lab.net>
- Create for Berry Linux
