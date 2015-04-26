#!/bin/bash

dst=${HOME}/tmp
cd /tmp

echo [+] Post-Setup
sleep 2

usermod -aG "adbusers,audio,tor,postgres,mysql" vagrant
su - vagrant -c "git clone git://github.com/ac1965/vagrant-dotfiles.git && cd vagrant-dotfiles && ./setup.sh"
su - vagrant -c "cd tmp; for p in *.xz;do yaourt -U --noconfirm $p && rm -f $p; done"

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

#mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/myslq
#cat - <<"EOF" | mysql_secure_installation
#
#n
#EOF

#systemctl enable mysqld
#systemctl start mysqld

#cat - <<"EOF" | mysql
#CREATE DATABASE cuckoo;
#CREATE USER 'cuckoo'@'localhost' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON cuckoo.* TO 'cuckoo'@'localhost' WITH GRANT OPTION;
#CREATE USER 'cuckoo'@'%' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON cuckoo.* TO 'cuckoo'@'%' WITH GRANT OPTION;
#EOF

test -d /etc/modules-load.d || install -d /etc/modules-load.d
cat - >> /etc/modules-load.d/virtualbox.conf <<'EOF'
vboxdrv
vboxnetadp
vboxnetflt
vboxpci
EOF

test -d $dst || install -d $dst
pacman -Qq | grep -Fv -f <(pacman -Qqm) > ${dst}/packages
pacman -Qqm > ${dst}/packages_man

su - vagrant -c "test -d github || mkdir github"
for repos in MalwareLu/malwasm cuckoobox/cuckoo ytisf/theZoo
do
	su - vagrant -c "cd github; git clone git://github.com/${repos}.git"
done

su - vagrant -c "git clone git://github.com/yyuu/pyenv.git ~/.pyenv && (cd ~/.pyenv/plugins; git clone git://github.com/yyuu/pyenv-virtualenv.git)"
su - vagrant -c "source ~/.bashrc && pyenv install 2.7.9 && pyenv virtualenv 2.7.9 sandbox279 && pyenv global sandbox279"

su - vagrant -c "\
test -f ~/github/cuckoo/requirements.txt && \
pip install -r ~/github/cuckoo/requirements.txt && \
cd ~/github/cuckoo && \
./utils/community.py --signature --force
"

su - vagrant -c "\
cd /tmp; wget http://research.pandasecurity.com/blogs/images/userdb.txt && \
mv userdb.txt ~/github/cuckoo/data/peutils/UserDB.TXT && \
wget http://db.local.clamav.net/main.cvd && \
wget http://db.local.clamav.net/daily.cvd && \
sigtool -u main.cvd && sigtool -u daily.cvd &&
wget http://malwarecookbook.googlecode.com/svn-history/r5/trunk/3/3/clamav_to_yara.py && \
python clamav_to_yara.py -f main.ndb -o main.yar && \
python clamav_to_yara.py -f daily.ndb -o daily.yar && \ 
mkdir ~/github/cuckoo/data/yara/clamav &&
mv *.yar ~/github/cuckoo/data/yara/clamav && \
(
cd ~/github/cuckoo/data/yara/clamav
RM_EOL = $ (-N sed '/EOL_0_94_2/= {}' main.yar)
for n in {1..8}; do sed -i " ${} RM_EOL D" main.yar; done
) && \
git clone https://github.com/AlienVault-Labs/AlienVaultLabs.git && \
mv AlienVaultLabs/malware_analysis ~/github/cuckoo/data/yara && \
cat - <<"EOF" >> ~/github/cuckoo/data/yara/index_binary.yar
include "/home/vagrant/github/cuckoo/data/yara/clamav/main.yar" 
include "/home/vagrant/github/cuckoo/data/yara/clamav/daily.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/CommentCrew/apt1.yara" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/FPU/fpu.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/Georbot/GeorBotBinary.yara" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/Georbot/GeorBotMemory.yara" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/Hangover/hangover.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/KINS/kins.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/OSX_Leverage/leverage.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/TheMask_Careto/mask.yar" 
include "/home/vagrant/github/cuckoo/data/yara/malware_analysis/Urausy/urausy_skypedat.yar"
EOF
"

cd - >/dev/null
