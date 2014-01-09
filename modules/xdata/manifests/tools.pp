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

}