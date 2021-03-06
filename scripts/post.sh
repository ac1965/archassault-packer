#!/bin/bash

dst=${HOME}/tmp
cd /tmp

echo [+] Post-Setup
sleep 2

test -d $dst || install -d $dst
pacman -Qq | grep -Fv -f <(pacman -Qqm) > ${dst}/packages
pacman -Qqm > ${dst}/packages_man

test -d /etc/modules-load.d || install -d /etc/modules-load.d
cat - >> /etc/modules-load.d/virtualbox.conf <<'EOF'
vboxdrv
vboxnetadp
vboxnetflt
vboxpci
EOF

test -d /etc/ld.so.conf.d || install -d /etc/ld.so.conf.d
echo '/usr/local/lib' > /etc/ld.so.conf.d/locallib.conf

usermod -aG "adbusers,audio,tor,postgres,mysql" vagrant
usermod -s /bin/zsh vagrant

systemctl enable slim.service

systemd-tmpfiles --create postgresql.conf
su - postgres -c "\
initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'
"
systemctl start postgresql
systemctl enable postgresql
sleep 2
su - postgres -c "\
cat <<'EOF' | createuser msfgit -P -S -R -D
msf
msf
EOF
"
su - postgres -c "\
createdb -O msfgit msfgit
"
cat - > /usr/share/metasploit/database.yml <<'EOF'
production:
  adapter: "postgresql"
  database: "msfgit"
  username: "msfgit"
  password: "msf"
  port: 5432
  host: "localhost"
  pool: 256
  timeout: 5
EOF

echo 'export MSF_DATABASE_CONFIG=/usr/share/metasploit/database.yml' > /etc/profile.d/msf.sh
chmod +x /etc/profile.d/msf.sh

echo [+] User Environment Setup
sleep 2

su - vagrant -c "\
git clone git://github.com/ac1965/vagrant-dotfiles.git --recursive && \
cd vagrant-dotfiles && ./setup.sh
"
su - vagrant -c "test -d ~/github || install -d ~/github"
for repos in \
    MalwareLu/malwasm ytisf/theZoo \
    offensive-security/exploit-database offensive-security/exploit-bin-sploits \
    kbandla/APTnotes
do
    su - vagrant -c "cd github; git clone git://github.com/${repos}.git"
done

cd - >/dev/null
