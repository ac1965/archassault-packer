#!/bin/sh

set -e

http_root="$1"
vm="$2"
arch="$3"

echo [+] ArchLinux Build
sgdisk --new 1::+1m --typecode 1:ef02 --new 2::+100m --new 3 /dev/sda

mkfs.ext4 /dev/sda2
mkfs.ext4 /dev/sda3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot

echo [+] Chroot Setup
#echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
url="https://www.archlinux.org/mirrorlist/?country=JP&protocol=http&ip_version=4&use_mirror_status=on"
curl $url -s -o - | sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist
pacstrap /mnt base grub sudo openssh haveged
genfstab -U -p /mnt >> /mnt/etc/fstab

cp /root/poweroff.timer /mnt/root/poweroff.timer

setup_chroot=/root/setup-chroot.sh
curl -o /mnt/$setup_chroot "$http_root/setup-chroot.sh"
chmod +x /mnt/$setup_chroot

vmsetup=/root/vmsetup.sh
case "$vm" in
    virtualbox)
        curl -o /mnt/$vmsetup "$http_root/setup-virtualbox.sh"
        chmod +x /mnt/$vmsetup
        ;;
    vmware)
        curl -o /mnt/$vmsetup "$http_root/setup-virtualbox.sh"
        chmod +x /mnt/$vmsetup
        ;;
esac

arch-chroot /mnt $setup_chroot $arch

umount /mnt/{boot,}
systemctl reboot
