# /bin/sh

arch="$1"

# VirtualBox Guest AdditionsZ
pacman -S --noconfirm --needed linux-headers virtualbox-guest-utils virtualbox-guest-dkms nfs-utils
echo -e 'vboxguest\nvboxsf\nvboxvideo' > /etc/modules-load.d/virtualbox.conf
guest_version=$(pacman -Q virtualbox-guest-dkms | awk '{ print $2 }' | cut -d'-' -f1)
kernel_version="$(pacman -Q linux | awk '{ print $2 }')-ARCH"
dkms install "vboxguest/${guest_version}" -k "${kernel_version}/${arch}"
systemctl enable dkms.service
#systemctl enable vboxservice.service
#systemctl enable rcpbind.service

