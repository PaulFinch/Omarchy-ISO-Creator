#!/bin/bash

if ! command -v qemu-system-x86_64 >/dev/null 2>&1; then
    echo "Error: qemu-system-x86_64 command not found. Install 'qemu-desktop' package first."
    exit 1
fi

[ ! -d "./VM" ] && mkdir "./VM"
[ -f "./VM/omarchy" ] && rm "./VM/omarchy"
qemu-img create -f qcow2 ./VM/omarchy 10G

[ -f "/usr/share/ovmf/OVMF.fd" ] && OVMF_BIN="/usr/share/ovmf/OVMF.fd"
[ -f "/usr/share/ovmf/x64/OVMF.fd" ] && OVMF_BIN="/usr/share/ovmf/x64/OVMF.fd"
[ -f "/usr/share/ovmf/x64/OVMF.4m.fd" ] && OVMF_BIN="/usr/share/ovmf/x64/OVMF.4m.fd"

if [ -n "${OVMF_BIN}" ] && [ -f "./output/Omarchy Linux-1.0-x86_64.iso" ]
then
  # INSTALL
  qemu-system-x86_64 -bios "${OVMF_BIN}" -smp 4 -hda ./VM/omarchy -cdrom "./output/Omarchy Linux-1.0-x86_64.iso" -m 2048 -boot d -nic user -enable-kvm

  # RUN
  qemu-system-x86_64 -bios "${OVMF_BIN}" -smp 4 -hda ./VM/omarchy -m 2048 -boot d -nic user -enable-kvm
fi

exit 0