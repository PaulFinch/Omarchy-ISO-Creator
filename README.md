# Omarchy_ISO_Creator

This is an ISO creator for [Omarchy](https://github.com/basecamp/omarchy).

## Caveats
For the moment, the ISO uses a forked version of Omarchy in order to make it work.
Here are the differences from the Original Repo:
- Removed the `--now` option from `systemctl enable --now` in install scripts (systemd is not running in chroot env)
- Add OMARCHY_NOREBOOT variable to remove the reboot at the end (not working in chroot env)

The git origin is replaced by the original repo (basecamp/omarchy) at the end.

Omarchy will be installed in `Bare mode`

## How to create the ISO
- `sudo pacman -S archiso`
- `git clone https://github.com/PaulFinch/Omarchy-ISO-Creator.git`
- `cd Omarchy-ISO-Creator`

- Configure the System in ./config/airootfs/root/
  - .zlogin: set your custom keyboard layout (ex: loadkeys fr)
  - arch_config.json: add/change the system settings
  - arch_creds.json: add/change the credentials (Encode passwords with this command: `openssl passwd -6`)

- Configure the target Wifi in ./config/airootfs/root/var/lib/iwd/
  - Change the filename with the Wifi SSID (ex: MyWifiNetwork.psk)
  - Change the Wifi passphrase within the file

- `sudo ./build_this.sh`
- The created ISO is in `./output/`

## How to test the ISO
- `sudo pacman -S qemu-desktop`
- `./test_this.sh`

## How to use the ISO
- Install the system using the ISO.
- The archinstall will launch automatically
  - Configure the remaining settings, such as disk configuration
  - Launch Install
  - Select, `Exit archinstall` when finished
- Omarchy Setup will launch automatically and reboot if successful
