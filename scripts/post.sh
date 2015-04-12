#!/bin/bash

dst=${HOME}/tmp
cd /tmp

echo [+] Post-Setup
sleep 2

usermod -aG "adbusers,audio,tor,postgres" vagrant
systemctl start slim.service
systemctl enable slim.service

systemd-tmpfiles --create postgresql.conf
su - postgres -c "initdb --locale en_US.UTF-8 -E UTF8 -D '/var/lib/postgres/data'"
systemctl start postgresql
systemctl enable postgresql
cat - <<'EOF' > /usr/share/metasploit/database.yml
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

test -d /etc/module-load.d || install -d /etc/module-load.d
cat - > /etc/module-load.d/virtualbox.conf <<'EOF'
vboxdrv
vboxnetadp
vboxnetflt
vboxpci
EOF

test -d $dst || install -d $dst
pacman -Qq | grep -Fv -f <(pacman -Qqm) > ${dst}/packages
pacman -Qqm > ${dst}/packages_man

su - vagrant -c "test -d github || mkdir github"
su - vagrant -c "cd github; git clone git://github.com/ytisf/theZoo.git; cd - > /dev/null"
su - vagrant -c "cd github; git clone git://github.com/MalwareLu/malwasm.git; cd - > /dev/null"
su - vagrant -c "cd github; git clone git://github.com/cuckoobox/cuckoo.git; cd - > /dev/null"
su - vagrant -c "git clone git://github.com/yyuu/pyenv.git ~/.pyenv && (cd ~/.pyenv/plugins; git clone git://github.com/yyuu/pyenv-virtualenv.git)"
su - vagrant -c "git clone git://github.com/ac1965/vagrant-dotfiles.git; cd vagrant-dotfiles; ./setup.sh"
su - vagrant -c "source ~/.bashrc && pyenv install 2.7.9 && pyenv virtualenv 2.7.9 sandbox279 && pyenv local sandbox279"

cd - >/dev/null
