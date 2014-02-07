# Class: cmantix/cdh4pseudo::source
#
# Cloudera debian repo and Java7 PPA
#
# Parameters:
#   
# Actions:
#     /etc/apt/sources.list.d/cdh4.list with cloudera key and Java7 Key
# Requires:
#     cdh4pseudo::curl
# Sample Usage:
#     include cdh4pseudo::source
#
class cdh4pseudo::source {

  class{ 'cdh4pseudo::curl': stage => setup }

  file { "java-sourcelist":
    path    => "/etc/apt/sources.list.d/java.list",
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/cdh4pseudo/java.list"
  }
  
  file { "cdh4-sourcelist":
    path    => "/etc/apt/sources.list.d/cloudera.list",
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/cdh4pseudo/cloudera.list"
  }

  file { "hadoop-env":
    path    => "/etc/profile.d/hadoop_env.sh",
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/cdh4pseudo/hadoop_env.sh"
  }
  
  exec {'apt-get-update1':
    command => "sudo apt-get update --fix-missing"
  }

  package { 'python-software-properties':
    ensure => installed,
    require => [File['cdh4-sourcelist'], Exec['apt-get-update1']]
  }
  
  exec {'add-java-key':
    unless => 'sudo apt-key list | tr "\\n" "," | grep EEA14886',
    command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886",
    require => [File['java-sourcelist'], File['cdh4-sourcelist']]
  }

  exec {'add-cdh4-key':
    command => "sudo curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add -",
    require => [File['cdh4-sourcelist'], Package['curl'], Exec['add-java-key']]
  } 
 
  exec {'update-repos-after-keys':
    command => '/usr/bin/apt-get update',
    require => Exec['add-cdh4-key']
  } 

}