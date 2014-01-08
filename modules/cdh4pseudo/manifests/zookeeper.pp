# Class: cmantix/cdh4pseudo::zookeeper
#
# Install Apache Zookeeper
#
# Parameters:
#   
# Actions:
#     Install oracle Java7 set it as default and modifies /etc/sudoers in order to keep $JAVA_HOME constant through sudo.
# Requires:
#     cdh4pseudo::java
# Sample Usage:
#     include cdh4pseudo::zookeeper
#
class cdh4pseudo::zookeeper {
  package { 'zookeeper-server':
    ensure => latest
  }
  
  exec { 'zookeeper-init':
    unless  => 'ls /root/zookeeper.init.lock',
    command => 'sudo service zookeeper-server init --myid=1 && touch /root/zookeeper.init.lock',
    require => Package['zookeeper-server']
  }
  
  service { "zookeeper-server":
    ensure     => running,
    require    => Exec["zookeeper-init"],
    hasrestart => true,
    hasstatus  => true,
  }
}