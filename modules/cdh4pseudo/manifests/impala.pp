class cdh4pseudo::impala {

  require cdh4pseudo::source
  require cdh4pseudo::hive

  #add the impala repo to the system and add the key
  file { "impala-sourcelist":
    path    => "/etc/apt/sources.list.d/cloudera-impala.list",
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/cdh4pseudo/cloudera-impala.list"
  }
  
  exec {'add-impala-key':
    command => "/usr/bin/curl -s http://archive.cloudera.com/impala/ubuntu/precise/amd64/impala/archive.key | sudo apt-key add -",
    require => [File['impala-sourcelist'], Package['curl']]
  }
  
  exec { 'apt-get-update':
      command => 'apt-get update',
      require => Exec['add-impala-key'],
      before => Package['impala-state-store']
  }

  package {'impala-state-store': 
       ensure => installed, 
       require => [Exec['add-impala-key'], Exec['apt-get-update']]
  }

  package {'impala-catalog' : 
       ensure => installed, 
       require => [Exec['add-impala-key'], Exec['apt-get-update']]
  }

  package {'impala-server' : 
       ensure => installed, 
       require => [Exec['add-impala-key'], Exec['apt-get-update']]
  }

  package {'impala-shell' : ensure => installed, require => Package['impala-server']}
  
  file { "impala-conf":
    path    => "/etc/impala/conf.dist",
    owner   => 'root',
    group   => 'root',
    mode    => 1777,
    source => "puppet:///modules/cdh4pseudo/impala-conf/",
    recurse => true,
    replace => false,
    ensure => directory,
    require => [Package['impala-state-store'],Package['impala-server'],Package['impala-catalog'],Package['impala-shell']]
  }

  service { 'impala-state-store':
    ensure => running,
    subscribe => File["impala-conf"]
  }

  service { 'impala-catalog':
    ensure => running,
    subscribe => File["impala-conf"]
  }

  service { 'impala-server':
    ensure => running,
    require => [Service["impala-state-store"],Service["impala-catalog"]]
  }
  
}