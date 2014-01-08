class cdh4pseudo::hive {

  class { 'mysql::server': config_hash => { 'root_password' => 'root' }}
  class { 'mysql::java': require => Package['hive']}

  
  # we ony want to install workbench if gnome is installed however
  # the package type doesn't have an onlyif.  so using a hacky
  # exec command and for some reason the "creates" requires doubles quotes
  # instead of single quotes.
  
  exec { 'install-mysql-workbench':
  	onlyif => 'ls /usr/lib/gnome-desktop3',
  	command => 'apt-get install -y mysql-workbench',
  	creates => "/usr/bin/mysql-workbench"
  }	

  package { 'hive':
    ensure  => present,
    require => Package['hadoop-0.20-conf-pseudo'],
    before => Class['mysql::java']
  }
  
  package { 'hive-server':
    ensure  => installed,
    require => Package['hive']
  }
  
  package { 'hive-metastore':
    ensure  => installed,
    require => [Package['hive-server'],Exec['add-alternative-hive-local']]
  }
  
  # create hive user directories
  exec { 'hive-hdfs-dir':
    unless  => 'sudo -u hdfs hadoop fs -ls /user/hive/warehouse',
    command => 'sudo -u hdfs hadoop fs -mkdir -p /user/hive/warehouse',
    require => Service['hadoop-0.20-mapreduce-tasktracker']
  }
  
  exec { 'chmod-hive-hdfs':
    onlyif  => 'sudo -u hdfs hadoop fs -ls /user/hive/warehouse',
    command => 'sudo -u hdfs hadoop fs -chmod 777 /user/hive/warehouse',
    require => Exec['hive-hdfs-dir']
  }
  
  exec { 'chown-hive-hdfs':
    onlyif  => 'sudo -u hdfs hadoop fs -ls /user/hive/',
    command => 'sudo -u hdfs hadoop fs -chown hive /user/hive',
    require => Exec['hive-hdfs-dir']
  } 
  
  mysql::db { 'metastore':
    user     => 'root',
    password => 'root',
    host     => 'localhost',
    grant    => ['all'],
    before => Exec['create-hive-schema']
  }
  
  exec {'create-hive-schema':
  	command => 'mysql -u root -proot -D metastore -e "SOURCE /usr/lib/hive/scripts/metastore/upgrade/mysql/hive-schema-0.10.0.mysql.sql"',
  	creates => "/var/lib/mysql/metastore/TBLS.frm",
  	require => Mysql::Db['metastore']
  	
  }
  
  exec {'link-mysql-jdbc-jar':
  	command => 'ln -s /usr/share/java/mysql-connector-java.jar /usr/lib/hive/lib/mysql-connector-java.jar',
  	require => Class['mysql::java'],
  	creates => '/usr/lib/hive/lib/mysql-connector-java.jar'
  }
  
  ##copy over the different config settings for hadoop and hive
  
  file { "hive-conf":
    path    => "/etc/hive/xdata-conf/",
    owner   => 'root',
    group   => 'root',
    mode    => 1777,
    source => "puppet:///modules/cdh4pseudo/hive-conf/",
    recurse => true,
    replace => true,
    ignore => '.DS_Store',
    ensure => directory,
    require => Package['hive-server']
  }
  
  exec {'add-alternative-hive-local':
    command => 'update-alternatives --install /etc/hive/conf hive-conf /etc/hive/xdata-conf/local 40 && touch /root/configured-hive-local',
    require => File['hive-conf'],
    creates => "/root/configured-hive-local"
  }
  
  exec {'add-alternative-hive-compute':
    command => 'update-alternatives --install /etc/hive/conf hive-conf /etc/hive/xdata-conf/compute 39 && touch /root/configured-hive-compute',
    require => File['hive-conf'],
    creates => "/root/configured-hive-compute"
  }
  
  exec {'add-alternative-hive-highmem':
    command => 'update-alternatives --install /etc/hive/conf hive-conf /etc/hive/xdata-conf/highmem 38 && touch /root/configured-hive-highmem',
    require => File['hive-conf'],
    creates => "/root/configured-hive-highmem"
  }
  
  exec {'add-alternative-hive-gpu':
    command => 'update-alternatives --install /etc/hive/conf hive-conf /etc/hive/xdata-conf/gpu 37 && touch /root/configured-hive-gpu',
    require => File['hive-conf'],
    creates => "/root/configured-hive-gpu"
  }

  
  service {'hive-metastore': ensure => running, require => [
  	Exec['add-alternative-hive-gpu'],
  	Exec['add-alternative-hive-highmem'],
  	Exec['add-alternative-hive-compute'],
  	Exec['add-alternative-hive-local']
  	]
  }
  
  service {'hive-server': ensure => running, require => [
  	Exec['add-alternative-hive-gpu'],
  	Exec['add-alternative-hive-highmem'],
  	Exec['add-alternative-hive-compute'],
  	Exec['add-alternative-hive-local']
  	]
  }
  
  
  
  

}