#!/bin/bash

cd /tmp

echo [+] Install ArchAssault tools Apps
pacman -S --noconfirm --needed p0f
pacman -S --noconfirm --needed zaproxy
pacman -S --noconfirm --needed proxychains
pacman -S --noconfirm --needed dradis

echo [+] Install Forensic Tools
pacman -S --noconfirm --needed python2-crypto
pacman -S --noconfirm --needed dcfldd
pacman -S --noconfirm --needed sleuthkit
pacman -S --noconfirm --needed rkhunter

echo [+] Install ArchAssault Group Tools
pacman -S --noconfirm --needed archassault-analysis \
       archassault-forensic archasssault-malware \
       archassault-windows archassault-reversing

echo [+] Install Metasploit and configuration Postgres
pacman -S --noconfirm --needed postgresql
pacman -S --noconfirm --needed metasploit

systemd-tmpfiles --create postgresql.conf
su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"

systemctl start postgresql
systemctl enable postgresql

su - postgres -c "createuser msfdbuser -S -R -D -w"
su - postgres -c "createdb -O msfdbuser msfdb"

cat <<'EOF' > /usr/share/metasploit/database.yml
production:
  adapter: "postgresql"
  database: "msfdb"
  username: "msfdbuser"
  password: ""
  port: 5432 
  host: "localhost"
  pool: 256
  timeout: 5
EOF

echo 'export MSF_DATABASE_CONFIG=/usr/share/metasploit/database.yml' > /etc/profile.d/msf.sh
chmod +x /etc/profile.d/msf.sh

pacman -Sc --noconfirm

cd - > /dev/null
