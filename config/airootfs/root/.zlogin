# fix for screen readers
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

~/.automated_script.sh

loadkeys fr

# Install Arch
archinstall --config /root/arch_config.json --creds /root/arch_creds.json --skip-version-check
[ $? -ne 0 ] && exit 1

# Install Omarchy in chroot env
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /dev /mnt/dev
arch-chroot /mnt /root/install_omarchy.sh
[ $? -ne 0 ] && exit 1

# Clean & Halt
umount -R /mnt
rm /root/install_omarchy.sh
shutdown -h 0

exit 0