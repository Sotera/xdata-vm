# XData VM

Vagrant-Ubuntu VM Serving as the baseline for performer software integration

See [wiki](https://github.com/Sotera/xdata-vm/wiki) for more information

### Quick Start
  Install Vagrant: [http://www.vagrantup.com](http://www.vagrantup.com)<br/>
  Install Virtual Box: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)<br/>
  Download latest [Release](https://github.com/Sotera/xdata-vm/releases) <br/>

  ```bash
  $ vagrant box add xdata-vm-[version] xdata-vm-[version].box 
  $ mkdir -p ~/vm/xdata-vm/version/
  $ cd ~/vm/xdata-vm/version/
  $ vagrant init xdata-vm-[version]
  $ vagrant up
  ```

