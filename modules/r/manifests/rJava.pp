
class r::rJava {
  
  $app = "rJava"
  $version = "0.9-6"
  $url = "http://cran.r-project.org/src/contrib/${app}_${version}.tar.gz"
  $download_destination = "/tmp/${app}_${version}.tar.gz"
  
  file { "r-java-conf":
    path    => '/etc/ld.so.conf.d/r-java.conf',
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source  => 'puppet:///modules/r/r-java.conf',
  }

  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec['r-reconfjava'],
    require     => Class['Cdh4pseudo::Java']
  }

  exec {'r-reconfjava':
    command     => 'sudo R CMD javareconf',
    require     => File['r-java-conf'],
    notify      => Exec["install-${app}"],
    refreshonly => true,
  }
  
  exec {"install-${app}" :
    cwd         => "/tmp",
    command     => "sudo R CMD INSTALL ${app}_${version}.tar.gz",
    refreshonly => true,
  }
  
}

