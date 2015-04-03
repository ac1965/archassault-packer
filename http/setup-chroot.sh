#!/bin/sh

set -e

arch="$1"

PASSWORD=$(openssl passwd -crypt 'vagrant')

echo [+] ArchLinux Setup
echo archassault.local > /etc/hostname

ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
sed -i 's/#\(ja_JP\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

# Update Latest ArchLinux
url="https://www.archlinux.org/mirrorlist/?country=JP&protocol=http&ip_version=4&use_mirror_status=on"
curl $url -s -o - | sed 's/^#Server/Server/' > /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm --needed
pacman-db-upgrade

# For ssh
# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
ln -sf /dev/null /etc/udev/rules.d/80-net-setup-link.rules
ln -sf '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'
sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
systemctl enable sshd.service
systemctl enable dhcpcd@eth0.service

pacman -Scc --noconfirm

echo [+] VM Setup
# For VM
/root/vmsetup.sh $arch

mkinitcpio -p linux

# root
usermod --password ${PASSWORD} root

echo [+] Vagrant Setup
# For vagrant
groupadd vagrant
useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --gid users --groups vagrant,vboxsf vagrant
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
chmod 0440 /etc/sudoers.d/10_vagrant
install --directory --owner=vagrant --group=users --mode=0700 /home/vagrant/.ssh
curl -s -o /home/vagrant/.ssh/authorized_keys -L https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown vagrant:users /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

# http://comments.gmane.org/gmane.linux.arch.general/48739
install --mode=0644 /root/poweroff.timer /etc/systemd/system/poweroff.timer

pacman -Sc --noconfirm

rm -f /root/poweroff.timer
rm -f /root/*.sh

grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
