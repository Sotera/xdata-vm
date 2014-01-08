
class r::source {
  
  file { "r-sourcelist":
    path    => "/etc/apt/sources.list.d/r.list",
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/r/r.list"
  }
  
  exec {'add-r-key':
    command => "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9",
    require => File['r-sourcelist']
  }
  
  package {'r-base':
    ensure  => installed,
    require => Exec['add-r-key'],
  }
  package {'r-base-dev':
    ensure  => installed,
    require => Package['r-base'],
  }
  
  
  /* Other r Packages */
  package {'r-cran-lattice': 
    ensure  => installed,
    require => Package['r-base']
  }

  package {'r-cran-spatial': 
    ensure  => installed,
    require => Package['r-base']
  }
  
  package {'r-cran-matrix': 
    ensure  => installed,
    require => Package['r-base']
  }
  
  package {'r-cran-survival': 
    ensure  => installed,
    require => Package['r-base']
  }
  
  package {'r-cran-nlme': 
    ensure  => installed,
    require => Package['r-base']
  }
  
  package {'r-cran-codetools': 
    ensure  => installed,
    require => Package['r-base']
  }
}

