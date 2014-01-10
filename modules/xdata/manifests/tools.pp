#
#  standard linux tools
#
class xdata::tools () {

  package { "netcat" :
    ensure => "installed"
  } 

  package { "lynx" :
    ensure => "installed"
  }

  package { "git" :
    ensure => "installed"
  }

  package { "maven" :
    ensure => "installed"
  }

}