# xdata-vm

Vagrant-Ubuntu VM Serving as the baseline for performer software integration

## Install
  * Install Vagrant: [http://www.vagrantup.com](http://www.vagrantup.com)
  * Install Virtual Box: [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
  * Download the ubuntu vagrant box 

  ```bash
  $ vagrant box add xdata-vm \ 
  http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box
  $ git clone https://github.com/Sotera/xdata-vm.git xdata-vm
  $ cd xdata-vm/
  $ vagrant up
  ```

## Re-Install
**All changes and data will be lost**

```bash
$ vagrant destroy
$ vagrant up
```

## Vagrant Commands
After installing Vagrant, VirtualBox, and possibly editing your
Vagrantfile, you are ready to start the VM.  Below are the commands
you can type in the terminal while in the current directory.

  *  **vagrant up** -- starts vagrant, downloads the base box listed
       in the Vagrantfile and provisions the VM with the software you
       want installed.  **Be sure to read the Software section of this
       document on how to add/remove software.**
  *  **vagrant ssh** -- SSH into the VM - useful if you chose a .box
       without a desktop environment installed.
  *  **vagrant halt** -- stops the VM.
  *  **vagrant reload** -- restarts the VM, doing any provisioning
       needed.
  *  **vagrant provision** -- this is a useful command that tells
       vagrant to run the **manifests/init.pp** Puppet script(s).  If
       you've modified the scripts to add software and the VM is
       already running, you can run this command to isntall the software.
  *  **vagrant destroy** - shuts down the VM and deletes any resources
       created.  If for whatever reason you've messed up the VM, you
       can run this command, and then **vagrant up** to start over
       with a fresh VM.  **PLEASE BE ADVISED ANY DATA ON THE VM WILL ALSO BE DELETED
       (unless if it was in a shared directory).**
  *  **vagrant suspend** - pauses the VM.
  *  **vagrant resume** - resumes the VM from the paused state.

More information can be found by typing **vagrant -help** or viewing the documentation [online](http://docs.vagrantup.com/v2/cli/index.html)

## Components
- gradle
- maven
- curl
- hbase
- hive
- impala
- java
- zookeeper
- scala
- sbt
- spark
- -shark-
- git
- lynx
- netcat
- unzip
