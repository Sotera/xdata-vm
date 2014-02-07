class xdata::docker-source {

  file { "docker-sourcelist":
    path    => "/etc/apt/sources.list.d/docker.list",
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/xdata/docker.list"
  }

  exec {'add-docker-key':
    command => "sudo /usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9",
    require => File['docker-sourcelist'],
  } 
  
  exec {'docker-apt-get-update':
    command => "sudo apt-get update",
    require => [File['docker-sourcelist'], Exec['add-docker-key']],
  }

}