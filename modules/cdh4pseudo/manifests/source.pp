# Class: cmantix/cdh4pseudo::source
#
# Cloudera debian repo and Java7 PPA
#
# Parameters:
#   
# Actions:
#     /etc/apt/sources.list.d/cdh4.list with cloudera key and Java7 Key
# Requires:
#     cdh4pseudo::curl
# Sample Usage:
#     include cdh4pseudo::source
#
class cdh4pseudo::source{
  
  file { "cdh4-sourcelist":
    path    => "/etc/apt/sources.list.d/cloudera.list",
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    source => "puppet:///modules/cdh4pseudo/cloudera.list"
  }
  
  exec {'apt-get-update1':
    command => "sudo apt-get update --fix-missing"
  }
  
  exec {'add-python-software-properties':
    command => "sudo apt-get -y install python-software-properties",
	require => [File['cdh4-sourcelist'], Exec['apt-get-update1']]
  }
  
  exec {'add-cdh4-key':
    command => "sudo curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add -",
    require => [File['cdh4-sourcelist'], Package['curl']]
  }

  exec {'add-java-repo':
    command => "sudo /usr/bin/add-apt-repository ppa:webupd8team/java",
	require => Exec['add-python-software-properties']
  }
  
  exec {'add-java-key':
    command => "/usr/bin/apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886",
    require => File['cdh4-sourcelist']
  }
}