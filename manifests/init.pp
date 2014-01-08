
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


# Installs cdh4 mrv1, hive (which install yarn/mrv2, mysql), impala
# java 6 and 7 (from sun)
include cdh4pseudo

# Installs R, Rhipe well as other packages R packages
#include rhipe  
 
# Installs basic packages and bashrc files 
#class {'xdata': }

# install scala, spark and shark.
#class {'xdata::scala': before => [Class['Xdata::Sbt'], Class['Xdata::spark'], Class['Xdata::shark']] } 
#class {'xdata::sbt': }
#class {'xdata::spark': before =>  Class['Xdata::Shark'] }
#class {'xdata::shark': }


# Downloads geoserver and unzips to /opt directory.
#class {'xdata::geoserver': require => Class['xdata']}

  