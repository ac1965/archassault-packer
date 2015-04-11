#!/bin/bash

cd /tmp

echo [+] Install Apps
sleep 2
pacman -S --noconfirm --needed bzr mercurial subversion
pacman -S --noconfirm --needed alsa-utils
pacman -S --noconfirm --needed wpa_actiond wpa_supplicant crda
pacman -S --noconfirm --needed android-tools android-udev
pacman -S --noconfirm --needed dosfstools encfs ntfs-3g
pacman -S --noconfirm --needed jre7-openjdk jdk7-openjdk
pacman -S --noconfirm --needed \
	ltrace strace tcpdump whois dnsutils tor networkmanager openntpd
pacman -S --noconfirm --needed nginx php php-fpm
pacman -S --noconfirm --needed puppet
pacman -S --noconfirm --needed tigervnc

pacman -S --noconfirm --needed xorg
pacman -S --noconfirm --needed slim slim-themes

pacman -S --noconfirm --needed \
	adobe-source-code-pro-fonts adobe-source-sans-pro-fonts
pacman -S --noconfirm --needed ttf-inconsolata ttf-sazanami

pacman -S --noconfirm --needed anthy uim
pacman -S --noconfirm --needed autocutsel xterm
pacman -S --noconfirm --needed conky dmenu feh scrot
pacman -S --noconfirm --needed gnome-keyring
pacman -S --noconfirm --needed go googlecl
pacman -S --noconfirm --needed lxterminal
pacman -S --noconfirm --needed mousepad xclip xpad xmind
pacman -S --noconfirm --needed nautilus
pacman -S --noconfirm --needed network-manager-applet
pacman -S --noconfirm --needed openbox obconf tint2
pacman -S --noconfirm --needed emacs

pacman -S --noconfirm --needed postgresql
pacman -S --noconfirm --needed \
       python2 python2-pip \
       python2-psycopg2 python2-argparse python2-flask python2-progressbar \
       python2-sqlalchemy python2-dpkt python2-jinja \
       python2-magic python2-pydeep \
       python2-lxml python2-bottle python2-pefile python2-chardet \
       python2-django python2-pymongo 
pacman -S --noconfirm --needed libvirt yara

su - vagrant -c "yaourt -S --noconfirm --needed asciinema"
su - vagrant -c "yaourt -S --noconfirm --needed nkf"
su - vagrant -c "yaourt -S --noconfirm --needed \
	libnatspec p7zip-natspec zip-natspec unzip-natspec \
"
su - vagrant -c "yaourt -S --noconfirm --needed rar"

pacman -Sc --noconfirm

cd - > /dev/null
