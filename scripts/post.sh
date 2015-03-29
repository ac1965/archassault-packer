#!/bin/bash

cd /tmp

echo [+] Post-Setup
sleep 2

usermod -aG "adbusers,audio,tor,postgres" vagrant
systemctl start slim.service
systemctl enable slim.service

cd - >/dev/null
