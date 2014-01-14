class rhipe {
  require r
  
  package {'libprotobuf-dev':
    ensure  => installed,
    require => Class['R::Source'],
  }

  $app = "Rhipe"
  $version = "0.73.1"
  $url = "http://ml.stat.purdue.edu/rhipebin/${app}_${version}.tar.gz"
  $download_destination = "/tmp/${app}_${version}.tar.gz"
  
  ##
  # Directions taken from
  # http://kb.solarvps.com/ubuntu/how-to-install-scala-2-9-3-on-ubuntu-12-04-lts/
  ##
  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    require     => Package['libprotobuf-dev'],
  }

  package {'r-cran-rjava': 
    ensure  => installed,
    require => Package['libprotobuf-dev'],
    notify  => Exec["reconf-rjava"],
  }
  
  exec {'reconf-rjava':
    command     => 'R CMD javareconf',
    notify      => Exec['install-rhipe'],
    refreshonly => true,
    require     => Package['r-cran-rjava'],
  }
  
  exec {"install-rhipe" :
    cwd         => "/tmp",
    command     => "sudo R CMD INSTALL ${app}_${version}.tar.gz",
    require     => Exec['reconf-rjava'],
    refreshonly => true,
  }
  
}
