# Class: cmantix/cdh4pseudo::pseudo
#
# Install Apache Hadoop in pseudo distributed mode according to cloudera's instructions.
#
# Parameters:
#   
# Actions:
#     Completely install hadoop in pseudo ditributed mode. 
# Requires:
#     cdh4pseudo::java
# Sample Usage:
#     include cdh4pseudo::pseudo
#
class cdh4pseudo::pseudo {
  require cdh4pseudo::java

  package { 'hadoop-0.20-conf-pseudo':
    ensure  => present
  }
  
  file { "hadoop-conf":
    path    => "/etc/hadoop/xdata-conf/",
    owner   => 'root',
    group   => 'root',
    mode    => 1777,
    source => "puppet:///modules/cdh4pseudo/hadoop-conf/",
    recurse => true,
    replace => true,
    ignore => '.DS_Store',    
    ensure => directory,
    require => Package['hadoop-0.20-conf-pseudo']
  }
  
  ##  add the new config settings as possible hadoop-conf and hive-conf
  
  exec {'add-alternative-hadoop-local':
    command => 'update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/xdata-conf/local 40 && touch /root/configured-hadoop-local',
    require => File['hadoop-conf'],
    creates => "/root/configured-hadoop-local"
  }
 

    
  exec { 'format-hdfs-partition':
    unless => 'ls /root/configuredhdfs.lock',
    command => 'sudo -u hdfs hdfs namenode -format',
    require => Exec['add-alternative-hadoop-local']
  }
  
  service {'hadoop-hdfs-datanode': ensure => running, require => Exec['format-hdfs-partition']}
  service {'hadoop-hdfs-namenode': ensure => running, require => Exec['format-hdfs-partition']}
  service {'hadoop-hdfs-secondarynamenode': ensure => running, require => Exec['format-hdfs-partition']}
  
  exec { 'chmod-hdfs-root':
    unless => 'ls /root/configuredhdfs.lock',
    command => 'sudo -u hdfs hadoop fs -chmod 777 /',
    require => [Service['hadoop-hdfs-datanode'],Service['hadoop-hdfs-namenode'],Service['hadoop-hdfs-secondarynamenode']]
  }
  
  exec { 'mkdir-hdfs-tmp':
    unless => 'sudo -u hdfs hadoop fs -ls /tmp',
    command => 'sudo -u hdfs hadoop fs -mkdir /tmp',
    require => Exec['chmod-hdfs-root']
  }
  
  exec { 'chmod-hdfs-tmp':
    unless => 'ls /root/configuredhdfs.lock',
    command => 'sudo -u hdfs hadoop fs -chmod -R 1777 /tmp',
    require => Exec['mkdir-hdfs-tmp']
  }

  exec { 'mkdir-hadoop-mapred-staging':
    unless => 'sudo -u hdfs hadoop fs -ls /var/lib/hadoop-hdfs',
    command => 'sudo -u hdfs hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging',
    require => Exec['chmod-hdfs-root']
  
  }
  
  exec { 'chmod-hadoop-mapred-staging':
    unless => 'ls /root/configuredhdfs.lock',
    command => 'sudo -u hdfs hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging',
  	require => Exec['mkdir-hadoop-mapred-staging']
  }
  
  exec { 'chown-hadoop-mapred-staging':
    unless => 'ls /root/configuredhdfs.lock',
    command => 'sudo -u hdfs hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred',
  	require => Exec['chmod-hadoop-mapred-staging']
  }
  
  service {'hadoop-0.20-mapreduce-jobtracker': ensure => running, require => Exec['chown-hadoop-mapred-staging'] }  
  service {'hadoop-0.20-mapreduce-tasktracker': ensure => running, require => Service['hadoop-0.20-mapreduce-jobtracker'] }
  
  
  
  
  ##################################
  #
  # Create required User Directories
  #
  ##################################
  
  # create bigdata user directories
  exec { 'bigdata-hdfs-dir':
    unless  => 'sudo -u hdfs hadoop fs -ls /user/bigdata',
    command => 'sudo -u hdfs hadoop fs -mkdir /user/bigdata',
    require => Service['hadoop-0.20-mapreduce-tasktracker']
  }
  
  exec { 'chown-bigdata-hdfs':
    command => 'sudo -u hdfs hadoop fs -chown bigdata /user/bigdata',
    require => Exec['bigdata-hdfs-dir']
  } 
  

  
  
}