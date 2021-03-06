#!/bin/bash

export TMPDIR=/var/tmp
cd /tmp

echo [+] Install Generic
pacman -S --noconfirm --needed linux-archassault-headers
pacman -S --noconfirm --needed linux-archasasult
pacman -S --noconfirm --needed virtualbox-guest-modules-archassault
pacman -S --noconfirm --needed archassault-artwork

pacman -S --noconfirm --needed arachni
pacman -S --noconfirm --needed armitage
pacman -S --noconfirm --needed arp-scan
pacman -S --noconfirm --needed beef-git
pacman -S --noconfirm --needed bsdiff
pacman -S --noconfirm --needed burpsuite
pacman -S --noconfirm --needed cadaver
pacman -S --noconfirm --needed clamav yara mitmf-git viper-git malheur
pacman -S --noconfirm --needed cymothoa enyelkm hotpatch jynx2 rrs tsh webshells backdoor-factory-git
pacman -S --noconfirm --needed darkstat
pacman -S --noconfirm --needed dcfldd
pacman -S --noconfirm --needed ddrescue
pacman -S --noconfirm --needed dirb
pacman -S --noconfirm --needed dnstracer
pacman -S --noconfirm --needed dradis
pacman -S --noconfirm --needed dsniff
pacman -S --noconfirm --needed edb nasm
pacman -S --noconfirm --needed etherape
pacman -S --noconfirm --needed exiv2
pacman -S --noconfirm --needed extundelete
pacman -S --noconfirm --needed eyewitness-git
pacman -S --noconfirm --needed fping
pacman -S --noconfirm --needed gnu-netcat
pacman -S --noconfirm --needed hping
pacman -S --noconfirm --needed iodine
pacman -S --noconfirm --needed iputils
pacman -S --noconfirm --needed jad
pacman -S --noconfirm --needed john
pacman -S --noconfirm --needed js-beautify
pacman -S --noconfirm --needed macchanger
pacman -S --noconfirm --needed masscan
pacman -S --noconfirm --needed mtr
pacman -S --noconfirm --needed nbtscan
pacman -S --noconfirm --needed nessus
pacman -S --noconfirm --needed net-creds-git
pacman -S --noconfirm --needed netcat
pacman -S --noconfirm --needed ngrep
pacman -S --noconfirm --needed nikto
pacman -S --noconfirm --needed nishang
pacman -S --noconfirm --needed nmap
pacman -S --noconfirm --needed ollydbg
pacman -S --noconfirm --needed ophcrack
pacman -S --noconfirm --needed owasp-bywaf-git
pacman -S --noconfirm --needed powersploit-git
pacman -S --noconfirm --needed proxychains
pacman -S --noconfirm --needed proxytunnel
pacman -S --noconfirm --needed python2-crypto
pacman -S --noconfirm --needed python2-selenium
pacman -S --noconfirm --needed recon-ng
pacman -S --noconfirm --needed rkhunter
pacman -S --noconfirm --needed siege
pacman -S --noconfirm --needed skipfish
pacman -S --noconfirm --needed slowhttptest
pacman -S --noconfirm --needed socat
pacman -S --noconfirm --needed sparta-git
pacman -S --noconfirm --needed spiderfoot
pacman -S --noconfirm --needed sqlmap
pacman -S --noconfirm --needed sqlninja
pacman -S --noconfirm --needed sslscan
pacman -S --noconfirm --needed sslyze
pacman -S --noconfirm --needed stunnel
pacman -S --noconfirm --needed tcpreplay
pacman -S --noconfirm --needed tlssled
pacman -S --noconfirm --needed w3af
pacman -S --noconfirm --needed wpscan
pacman -S --noconfirm --needed zaproxy


pacman -Sc --noconfirm


echo [+] Install Metasploit
pacman -S --noconfirm --needed metasploit-git
pacman -Sc --noconfirm


# echo [+] Install ArchAssault Group Tools
# pacman -S --noconfirm --needed \
#        archassault
# pacman -Sc --noconfirm

cd - > /dev/null
