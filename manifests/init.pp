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
stage { 'setup': 
   before => Stage['main'],
}

file {"srv-dir":
   path => "/srv/software",
   ensure => directory
}

# Install common linux tools
class {xdata::tools: stage => setup}
include xdata::tools
include xdata::maven
include xdata::gradle 

# Installs cdh4 mrv1, hive (which install yarn/mrv2, mysql), impala
# java 6 and 7 (from sun)
include cdh4pseudo

# Installs R, Rhipe well as other packages R packages
include rhipe  
 
# Installs basic packages and bashrc files 

# install scala, sbt, spark and shark.
include xdata::shark

# Downloads geoserver and unzips to /opt directory.
#class {'xdata::geoserver': require => Class['xdata']}

  