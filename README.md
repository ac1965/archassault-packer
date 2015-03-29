# Packer template for ArchAssault Vagrant box

- http://www.packer.io/
- http://www.vagrantup.com/
- https://archassault.org/

example: virtualbox

```sh
git clone https://github.com/ac1965/archassault-packer.git
cd archassault-packer/
packer build -only=virtualbox-iso template.json
vagrant box add archassault packer_archassult_virualbox.box
vagrant up
```
