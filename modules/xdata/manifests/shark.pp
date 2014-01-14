class xdata::shark {
  
  require xdata::scala
  require xdata::spark
  
  $app = "shark"
  $version = "0.7.0"
  $url = "http://spark-project.org/download/${app}-${version}-hadoop2-bin.tgz"
  $download_destination = "/tmp/${app}.tgz"
  $install_dir = "/srv/software"
   
  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec["deflate-${app}"],
    require     => Class['xdata::spark'],
    execuser    => bigdata
  }
  
  #unzips the file previously downloaded to the /tmp directory
  exec { "deflate-${app}":
    cwd         => "/tmp",
    command     => "tar zxf ${download_destination}",
    refreshonly => true,
    user        => 'bigdata',
    notify      => Exec["mv-${app}-folder"],
  }

  exec { "mv-${app}-folder":
    creates     => "${install_dir}/${app}-${version}",
    cwd         => "/tmp",
    command	=> "mv ${app}-${version} ${install_dir}/",
    require     => Exec["deflate-${app}"],
    refreshonly => true,
  }
   
  file {"${install_dir}/${app}":
    ensure => link,
    target  => "${install_dir}/${app}-${version}",
    require => Exec["mv-${app}-folder"]
  }
   
  file {"${install_dir}/${app}/conf/shark-env.sh":
    owner   => 'bigdata',
    group   => 'bigdata',
    require => File["${install_dir}/${app}"],
    mode    => '755',
    source  => "puppet:///modules/xdata/shark-env.sh"
  }

}