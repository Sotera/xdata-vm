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


Validation
=========

### hadoop
```
$ hadoop fs -ls /
```

### maven
```
$ maven --version
```

### R 
```
$ R --version 
```

### Rhipe 
```
$ R
> library(Rhipe)
------------------------------------------------
| Please call rhinit() else RHIPE will not run |
------------------------------------------------
> rhinit()
Rhipe: Using RhipeCDH4.jar
Initializing Rhipe v0.73
SLF4J: Class path contains multiple SLF4J bindings.
....
> x <- list( list("a", 1), list("b", 2))
> rhwrite(x,"/tmp/x")
Wrote 0.48 KB,2 chunks, and 2 elements (100% complete)
> rhread("/tmp/x")
Read 2 objects(0.07 KB) in 0.06 seconds
...
```


Components
----------
- gradle
- maven

- cdh4 
  - curl
  - hbase
  - hive
  - impala
  - java
  - zookeeper

- xdata
  - scala
  - sbt
  - spark
  - shark
  - tools
    - git
    - lynx
    - netcat
    - unzip
