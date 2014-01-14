xdata-vm
========

Vagrant-Ubuntu VM Serving as the baseline for performer software integration

Install
-------
1. Install Vagrant: http://www.vagrantup.com/
2. Install Virtual Box: https://www.virtualbox.org/wiki/Downloads
3. Run this: `vagrant box add xdata-vm http://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box`
4. Run this: `vagrant up`

Re-Install
----------
1. Run: `vagrant destroy`
2. Run: `vagrant up`

Components
----------
- tools
  - git
  - lynx
  - netcat
  - unzip

- gradle
- maven

- cdh4 
  - curl
  - hbase
  - hive
  - impala
  - java
  - zookeeper

- scala
- sbt
- spark
- shark
