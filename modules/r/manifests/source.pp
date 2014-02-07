
class r::source {
  
  file { "r-sourcelist":
    path    => "/etc/apt/sources.list.d/r.list",
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/r/r.list"
  }
  
  exec {'add-r-key':
    unless  => 'sudo apt-key list | tr "\\n" "," | grep E084DAB9',
    command => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9",
    require => File['r-sourcelist'],
  }

}

