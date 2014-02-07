class r::pkg {

  package {'r-base':
    ensure  => installed,
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