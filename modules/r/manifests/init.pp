class r {
  
  class { 'r::source': stage => 'setup' }
  class { 'r::pkg': require => Class['R::Source']}
  class { 'r::rJava': require => Class['R::Pkg']}
  #class { 'r::rPackages': require => Class['R::Pkg']}

}



