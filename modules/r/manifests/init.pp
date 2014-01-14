class r {
  
  stage { 'r-setup': 
    before => Stage['main'],
  }
  
  class { 'r::source': stage => 'r-setup' }
  class { 'r::rJava': require => Class['R::Source']}
  #class { 'r::rPackages': require => Class['R::Source']}

}



