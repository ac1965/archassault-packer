#!/bin/bash

export TMPDIR=/var/tmp

echo [+] Install Generic
pacman -S --noconfirm --needed postgresql
pacman -S --noconfirm --needed aircrack-ng
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
pacman -S --noconfirm --needed ettercap
pacman -S --noconfirm --needed exiv2
pacman -S --noconfirm --needed extundelete
pacman -S --noconfirm --needed fping
pacman -S --noconfirm --needed gdb
pacman -S --noconfirm --needed gnu-netcat
pacman -S --noconfirm --needed hping
pacman -S --noconfirm --needed iodine
pacman -S --noconfirm --needed iputils
pacman -S --noconfirm --needed jad
pacman -S --noconfirm --needed john
pacman -S --noconfirm --needed kismet
pacman -S --noconfirm --needed macchanger
pacman -S --noconfirm --needed mtr
pacman -S --noconfirm --needed nbtscan
pacman -S --noconfirm --needed ngrep
pacman -S --noconfirm --needed nmap
pacman -S --noconfirm --needed ophcrack
pacman -S --noconfirm --needed p0f
pacman -S --noconfirm --needed proxychains
pacman -S --noconfirm --needed proxytunnel
pacman -S --noconfirm --needed python2-crypto
pacman -S --noconfirm --needed rkhunter
pacman -S --noconfirm --needed siege
pacman -S --noconfirm --needed sleuthkit
pacman -S --noconfirm --needed socat
pacman -S --noconfirm --needed stunnel
pacman -S --noconfirm --needed tcpreplay
pacman -S --noconfirm --needed wireshark-cli
pacman -S --noconfirm --needed zaproxy
pacman -S --noconfirm --needed \
       python2-psycopg2 python2-argparse python2-flask python2-progressbar \
       python2-sqlalchemy python2-dpkt python2-jinja \
       python2-magic python2-pydeep \
       python2-lxml python2-bottle python2-pefile python2-chardet \
       python2-django python2-pymongo 

echo [+] Install ArchAssault Group Tools
pacman -S --noconfirm --needed \
       archassault-scannner
pacman -S --noconfirm --needed \
       thezoo-git \
       mitmf-git \
       viper-git \
       python2-yara \
       yara \
       malheur \
       js-beautify \
       ollydbg \
       vmcloak

echo [+] Install Metasploit and configuration Postgres
pacman -S --noconfirm --needed metasploit

echo 'export MSF_DATABASE_CONFIG=/usr/share/metasploit/database.yml' > /etc/profile.d/msf.sh
chmod +x /etc/profile.d/msf.sh

pacman -Sc --noconfirm

cd - > /dev/null
