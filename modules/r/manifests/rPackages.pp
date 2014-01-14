
class r::rPackages {
  
  file {'/tmp/rPackages.R':
    source  => 'puppet:///modules/r/rPackages.R'
  }

  #this takes forever may need to increase timeout
  exec { 'install-other-r-packages':
    cwd     => '/tmp',
    command => 'sudo Rscript rPackages.R',
    timeout => 600,
    require => File['/tmp/rPackages.R'],
  }
}

