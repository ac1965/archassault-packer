#!/bin/sh
set -ex

echo archassault64.local > /etc/hostname

ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(ja_JP\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Update Latest ArchLinux
url="https://www.archlinux.org/mirrorlist/?country=JP&protocol=http&ip_version=4&use_mirror_status=on"
curl $url -s -o - | sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm --needed
pacman-db-upgrade

# For vagrant
groupadd vagrant
useradd --password $(openssl passwd -crypt 'vagrant') --comment 'Vagrant User' --create-home --gid users vagrant
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
chmod 0440 /etc/sudoers.d/10_vagrant
install --directory --owner=vagrant --group=users --mode=0700 /home/vagrant/.ssh
curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown vagrant:users /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

# Disable PredictableNetworkInterfaceNames.
# See https://github.com/mitchellh/vagrant/blob/master/plugins/guests/arch/cap/configure_networks.rb
# and http://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/#idontlikethishowdoidisablethis
ln -sf /dev/null /etc/udev/rules.d/80-net-name-slot.rules # v197 <= systemd <= v208
ln -sf /dev/null /etc/udev/rules.d/80-net-setup-link.rules  # v209 <= systemd

# For ssh
systemctl enable sshd.service
systemctl enable dhcpcd@eth0.service

# For VM
/root/vmsetup.sh

mkinitcpio -p linux
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
