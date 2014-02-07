class xdata::docker {
  class { 'xdata::docker-source': stage => setup }

  # instructions say we might need to install the image-extras but I am not sure
  # http://docs.docker.io/en/latest/installation/ubuntulinux
  #
  # sudo apt-get install linux-image-extra-`uname -r | awk -F '-generic' '{ print $1 }'`-virtual
  #

  package { "lxc-docker":
    ensure => installed,
  }

  exec { 'docker-ubuntu':
    unless => 'sudo docker images | tr "\\n" ", " | grep ubuntu',
    command => 'sudo docker pull -t latest ubuntu',
    require => Package['lxc-docker']
  }

}