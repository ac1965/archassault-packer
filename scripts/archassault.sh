#!/bin/bash

export TMPDIR=/var/tmp
cd /tmp

echo [+] Install Generic
pacman -S --noconfirm --needed arp-scan
pacman -S --noconfirm --needed bsdiff
pacman -S --noconfirm --needed cadaver
pacman -S --noconfirm --needed darkstat
pacman -S --noconfirm --needed dcfldd
pacman -S --noconfirm --needed ddrescue
pacman -S --noconfirm --needed dnstracer
pacman -S --noconfirm --needed dradis
pacman -S --noconfirm --needed dsniff
pacman -S --noconfirm --needed etherape
pacman -S --noconfirm --needed exiv2
pacman -S --noconfirm --needed extundelete
pacman -S --noconfirm --needed fping
pacman -S --noconfirm --needed gnu-netcat
pacman -S --noconfirm --needed hping
pacman -S --noconfirm --needed iodine
pacman -S --noconfirm --needed iputils
pacman -S --noconfirm --needed jad
pacman -S --noconfirm --needed john
pacman -S --noconfirm --needed macchanger
pacman -S --noconfirm --needed mtr
pacman -S --noconfirm --needed nbtscan
pacman -S --noconfirm --needed ngrep
pacman -S --noconfirm --needed nmap
pacman -S --noconfirm --needed ophcrack
pacman -S --noconfirm --needed proxychains
pacman -S --noconfirm --needed proxytunnel
pacman -S --noconfirm --needed python2-crypto
pacman -S --noconfirm --needed rkhunter
pacman -S --noconfirm --needed siege
pacman -S --noconfirm --needed socat
pacman -S --noconfirm --needed stunnel
pacman -S --noconfirm --needed tcpreplay
pacman -S --noconfirm --needed wireshark-cli
pacman -S --noconfirm --needed ollydbg
pacman -S --noconfirm --needed js-beautify
pacman -S --noconfirm --needed clamav
pacman -S --noconfirm --needed \
       mitmf-git \
       viper-git \
       malheur
pacman -Sc --noconfirm


echo [+] Install Metasploit
pacman -S --noconfirm --needed metasploit
pacman -Sc --noconfirm


# echo [+] Install ArchAssault Group Tools
# pacman -S --noconfirm --needed \
#        archassault
# pacman -Sc --noconfirm

cd - > /dev/null
