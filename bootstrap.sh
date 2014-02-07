#!/usr/bin/env bash


#https://github.com/mitchellh/vagrant/issues/289
#sudo apt-get -y remove grub-pc
#sudo apt-get -y install grub-pc
#sudo grub-install /dev/sda # precaution
#sudo update-grub 

#sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade


# now start bootstrapping and upgrading your system packages
sudo apt-get -y upgrade
sudo apt-get -y update
#sudo useradd -m -s /bin/bash bigdata
#printf '%s\n%s\n' 'bigdata' 'bigdata' | sudo passwd bigdata
#sudo usermod -aG sudo bigdata

#sudo git clone git://github.com/Kitware/tangelo.git
#sudo mkdir tangelo-build
#cd tangelo-build
#sudo cmake ../tangelo
#sudo make
#cd ../tangelo/Tangelo
#sudo python setup.py install
#cd ../../
#mkdir .config
#mkdir .config/tangelo
