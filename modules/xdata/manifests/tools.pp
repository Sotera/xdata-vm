#
#  standard tools
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

  package { "unzip" :
    ensure => "installed"
  }

}