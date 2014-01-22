# xdata-vm

Vagrant-Ubuntu VM Serving as the baseline for performer software integration

See [wiki](https://github.com/Sotera/xdata-vm/wiki) for more information

## Quick Start
  Install Vagrant: [http://www.vagrantup.com](http://www.vagrantup.com)<br/>
  Install Virtual Box: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)<br/>
 
  ```bash
  $ vagrant box add xdata-vm \ 
  http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box
  $ git clone https://github.com/Sotera/xdata-vm.git xdata-vm
  $ cd xdata-vm/
  $ vagrant up
  ```

