# Class: cmantix/cdh4pseudo::java
#
# Install Java 7 from PPA
#
# Parameters:
#   
# Actions:
#     Install oracle Java7 set it as default and modifies /etc/sudoers in order to keep $JAVA_HOME constant through sudo.
# Requires:
#     cdh4pseudo::source
# Sample Usage:
#     include cdh4pseudo::java
#
class cdh4pseudo::java {
  # seeding taken from https://github.com/abhishektiwari/java7/blob/master/manifests/init.pp
  file { "/tmp/java.accept":
    ensure => present,
    source => 'puppet:///modules/cdh4pseudo/java.accept',
    mode   => '0600',
  }
  
  	
  
  package { "oracle-java7-installer":
    ensure       => installed,
    responsefile => '/tmp/java.accept',
    require      => File['/tmp/java.accept'],
  }
  
  package { "oracle-java6-installer":
    ensure       => installed,
    responsefile => '/tmp/java.accept',
    require      => File['/tmp/java.accept'],
  }
  
  
  package { 'oracle-java7-set-default':
    ensure => latest,
    require => Package['oracle-java7-installer']
  }
  
  file { 'sudoers-javahome':
    path    => '/etc/sudoers',
    source  => "puppet:///modules/cdh4pseudo/sudoers",
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0440',
    replace => true,
    require => Package['oracle-java7-installer']
  }

}