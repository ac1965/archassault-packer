#!/bin/bash

dst=${HOME}/tmp
cd /tmp

echo [+] Post-Setup
sleep 2

usermod -aG "adbusers,audio,tor,postgres" vagrant
systemctl start slim.service
systemctl enable slim.service

test -d $dst || install -d $dst
pacman -Qq | grep -Fv -f <(pacman -Qqm) > ${dst}/packages
pacman -Qqm > ${dst}/packages_man

cd - >/dev/null
