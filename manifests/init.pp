#sets global path so don't have to specify it every single time.
Exec {
	path => [
		'/usr/local/bin',
		'/opt/local/bin',
		'/usr/bin', 
		'/usr/sbin', 
		'/bin',
		'/sbin'],
}

#stages
stage { 'init': before => Stage['setup'] }
stage { 'setup':  before => Stage['main'] }

class init-boot () {

	exec { 'init-apt-update':
		command => 'sudo apt-get update'
	}
	
	exec { 'init-apt-upgrade': 
		command => "sudo apt-get -y upgrade",
		require => Exec['init-apt-update']
	}

    file { "srv-dir":
      path => "/srv/software",
      mode => "0755",
      ensure => directory
    }
}

# assign stages 
class { init-boot: stage => init }
class { xdata::user: stage => setup }
class { xdata::tools: stage => setup}

include xdata::tools
include xdata::maven
include xdata::gradle 
include xdata::python-extras
include xdata::docker

# Installs cdh4 mrv1, hive (which install yarn/mrv2, mysql), impala java 6 and 7 (from sun)

include cdh4pseudo

# Installs R, Rhipe well as other packages R packages

include r
include rhipe  
 
# install scala, sbt, spark and shark.

include xdata::scala
include xdata::sbt
include xdata::spark

#shark is not compatible and needs to be updated to reflect download name changes
#include xdata::shark

# install sotera components

include sotera::louvain
include sotera::amp
include sotera::corr-approx

# Downloads geoserver and unzips to /opt directory.
#class {'xdata::geoserver': require => Class['xdata']}

  
