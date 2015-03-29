# /bin/sh

# VirtualBox Guest AdditionsZ
pacman -S --noconfirm linux-headers virtualbox-guest-utils virtualbox-guest-dkms
echo -e 'vboxguest\nvboxsf\nvboxvideo' > /etc/modules-load.d/virtualbox.conf
guest_version=$(/usr/bin/pacman -Q virtualbox-guest-dkms | awk '{ print $2 }' | cut -d'-' -f1)
kernel_version="$(/usr/bin/pacman -Q linux | awk '{ print $2 }')-ARCH"
dkms install "vboxguest/${guest_version}" -k "${kernel_version}/x86_64"
systemctl enable dkms.se
          rvice
systemctl enable vboxservice.service
