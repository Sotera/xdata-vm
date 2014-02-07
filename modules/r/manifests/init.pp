class r {
  
  class { 'r::source': stage => 'setup' }
  class { 'r::rJava': require => Class['R::Source']}
  #class { 'r::rPackages': require => Class['R::Source']}

}



