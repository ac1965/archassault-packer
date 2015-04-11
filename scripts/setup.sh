#!/bin/bash 

set -e

arch=$(uname -m)

cd /root

echo [+] Remove /etc/pacman.d/gnupg
systemctl start haveged
systemctl enable haveged
rm -fr /etc/pacman.d/gnupg
sleep 5
echo [+] Adding ArchAssault repos and keys
sudo -i dirmngr < /dev/null
pacman-key --init
pacman-key --populate archlinux
pacman-key -r CC1D2606 && pacman-key --lsign CC1D2606

#Adding in our pacman.conf
if [[ ${arch} == i686 ]]; then
    cat - > /etc/pacman.conf <<'EOF'
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/

#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -C - -f %u > %o
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
#UseDelta    = 0.7
Architecture = auto

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
#Color
#TotalDownload
# We cannot check disk space from within a chroot environment
#CheckSpace
#VerbosePkgLists

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with `pacman-key --populate archlinux`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch

[archassault]
SigLevel = Required DatabaseOptional TrustedOnly
Server = http://repo.archassault.org/archassault/$repo/os/$arch
#@ Include = /etc/pacman.d/archassault-mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs

EOF
else
    cat - > /etc/pacman.conf <<'EOF'
#
# /etc/pacman.conf
#
# See the pacman.conf(5) manpage for option and repository directives

#
# GENERAL OPTIONS
#
[options]
# The following paths are commented out with their default values listed.
# If you wish to use different paths, uncomment and update the paths.
#RootDir     = /
#DBPath      = /var/lib/pacman/
#CacheDir    = /var/cache/pacman/pkg/
#LogFile     = /var/log/pacman.log
#GPGDir      = /etc/pacman.d/gnupg/
HoldPkg     = pacman glibc
#XferCommand = /usr/bin/curl -C - -f %u > %o
#XferCommand = /usr/bin/wget --passive-ftp -c -O %o %u
#CleanMethod = KeepInstalled
#UseDelta    = 0.7
Architecture = auto

# Pacman won't upgrade packages listed in IgnorePkg and members of IgnoreGroup
#IgnorePkg   =
#IgnoreGroup =

#NoUpgrade   =
#NoExtract   =

# Misc options
#UseSyslog
#Color
#TotalDownload
# We cannot check disk space from within a chroot environment
#CheckSpace
#VerbosePkgLists

# By default, pacman accepts packages signed by keys that its local keyring
# trusts (see pacman-key and its man page), as well as unsigned packages.
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional
#RemoteFileSigLevel = Required

# NOTE: You must run `pacman-key --init` before first using pacman; the local
# keyring can then be populated with the keys of all official Arch Linux
# packagers with `pacman-key --populate archlinux`.

#
# REPOSITORIES
#   - can be defined here or included from another file
#   - pacman will search repositories in the order defined here
#   - local/custom mirrors can be added here or in separate files
#   - repositories listed first will take precedence when packages
#     have identical names, regardless of version number
#   - URLs will have $repo replaced by the name of the current repo
#   - URLs will have $arch replaced by the name of the architecture
#
# Repository entries are of the format:
#       [repo-name]
#       Server = ServerName
#       Include = IncludePath
#
# The header [repo-name] is crucial - it must be present and
# uncommented to enable the repo.
#

# The testing repositories are disabled by default. To enable, uncomment the
# repo name header and Include lines. You can add preferred servers immediately
# after the header, and they will be used before the default mirrors.

#[testing]
#Include = /etc/pacman.d/mirrorlist

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

#[community-testing]
#Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist

[multilib]
Include = /etc/pacman.d/mirrorlist

[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/$arch

[archassault]
SigLevel = Required DatabaseOptional TrustedOnly
Server = http://repo.archassault.org/archassault/$repo/os/$arch
#@ Include = /etc/pacman.d/archassault-mirrorlist

# An example of a custom package repository.  See the pacman manpage for
# tips on creating your own repositories.
#[custom]
#SigLevel = Optional TrustAll
#Server = file:///home/custompkgs

EOF
fi

echo [+] archassault-keyring archassault-mirrorlist install
pacman -Syyu --noconfir archassault-keyring archassault-mirrorlist
sed -i 's/^#@ \(Include\)/\1/' /etc/pacman.d/archassault-mirrorlist

pacman -Syy

if [[ ${arch} == i686 ]]; then
    echo [+] Remove cryptsetup, gcc, gc-libs
    pacman -Rddd --noconfirm cryptsetup
    echo [+] Add mirrors, cryptsetup-nuke-keys
    pacman -S --noconfirm --needed \
           cryptsetup-nuke-keys
else 
    echo [+] Remove cryptsetup, gcc, gc-libs
    pacman -Rddd --noconfirm cryptsetup gcc gcc-libs
    echo [+] Add mirrors, cryptsetup-nuke-keys and gcc-multilib
    pacman -S --noconfirm --needed \
           cryptsetup-nuke-keys \
           gcc-libs-multilib multilib-devel
fi

echo [+] yaourt install
#su - vagrant -c "curl -O -s -L http://aur.archlinux.org//packages/ya/yajl1/yajl1.tar.gz; tar xfz yajl1.tar.gz; cd yajl1; makepkg -i"
#su - vagrant -c "curl -O -s -L http://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz; tar xfz package-query.tar.gz; cd package-query; makepkg -i"
#su - vagrant -c "curl -O -s -L http://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz; tar xfz yaourt.tar.gz; cd yaourt; makepkg -i"
#su - vagrant -c "test -d package-query && rm -fr package-query; test -d yaourt && rm -fr yaourt"
pacman -S --noconfirm --needed yaourt

pacman -Sc --noconfirm

cd - > /dev/null
