#!/bin/bash

export TMPDIR=/var/tmp
cd /tmp

echo [+] Install Apps
sleep 2
pacman -S --noconfirm --needed \
       automake automake1.11 autoconf bison flex gdb zsh
pacman -S --noconfirm --needed bzr mercurial subversion
pacman -S --noconfirm --needed alsa-utils
pacman -S --noconfirm --needed wpa_actiond wpa_supplicant crda
pacman -S --noconfirm --needed android-tools android-udev
pacman -S --noconfirm --needed dosfstools encfs ntfs-3g
pacman -S --noconfirm --needed jre7-openjdk jdk7-openjdk
pacman -S --noconfirm --needed \
	ltrace strace tcpdump whois dnsutils tor networkmanager openntpd
pacman -S --noconfirm --needed nginx php php-fpm
pacman -S --noconfirm --needed python python-pip puppet
pacman -S --noconfirm --needed tigervnc rdesktop
pacman -S --noconfirm --needed virtualbox virtualbox-host-modules
pacman -S --noconfirm --needed libvirt

pacman -S --noconfirm --needed xorg
pacman -S --noconfirm --needed slim slim-themes
pacman -S --noconfirm --needed gnome-keyring

pacman -S --noconfirm --needed \
	adobe-source-code-pro-fonts adobe-source-sans-pro-fonts \
	ttf-inconsolata

pacman -S --noconfirm --needed pygtk
pacman -S --noconfirm --needed wireshark-qt
pacman -S --noconfirm --needed emacs
pacman -S --noconfirm --needed weechat

pacman -S --noconfirm --needed postgresql mysql

pacman -S --noconfirm --needed anthy uim
pacman -S --noconfirm --needed autocutsel xterm
# pacman -S --noconfirm --needed feh scrot
# pacman -S --noconfirm --needed conky
# pacman -S --noconfirm --needed mousepad xclip xpad
pacman -S --noconfirm --needed xmind
pacman -S --noconfirm --needed nautilus
pacman -S --noconfirm --needed go googlecl
pacman -S --noconfirm --needed lxterminal
pacman -S --noconfirm --needed network-manager-applet
pacman -S --noconfirm --needed chromium firefox

pacman -S --noconfirm --needed \
       mate

su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed asciinema"
su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed nkf"
su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed \
	libnatspec p7zip-natspec zip-natspec unzip-natspec \
  rar
"
su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed \
  chromium-pepper-flash
"
su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed \
  otf-takao ttf-ms-fonts ttf-ricty
"
su - vagrant -c "env TMPDIR=/var/tmp yaourt -S --noconfirm --needed \
  acroread9-fonts
"

pacman -R --noconfirm libsodium libspiro libunicodenames libxkbui zeromq fontforge
pacman -Sc --noconfirm
rm -fr /var/tmp/*

cd - > /dev/null
