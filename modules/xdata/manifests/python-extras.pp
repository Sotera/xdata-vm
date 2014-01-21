#
# additional python libraries
#
class xdata::python-extras {

  package { "python-numpy" :
    ensure => "installed"
  }

  package { "python-scipy" :
    ensure => "installed"
  }

  package { "python-matplotlib" :
    ensure => "installed"
  }

  package { "ipython" :
    ensure => "installed"
  }

  package { "ipython-notebook" :
    ensure => "installed"
  }

  package { "python-pandas" :
    ensure => "installed"
  }

  package { "python-sympy" :
    ensure => "installed"
  }

  package { "python-nose" :
    ensure => "installed"
  }

  package { "python-gmpy" :
    ensure => "installed"
  }

}