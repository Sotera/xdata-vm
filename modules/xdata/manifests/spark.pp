class xdata::spark {

  require xdata::scala

  $app = "spark"
  $version = "0.7.3"
  $url = "http://spark-project.org/download/${app}-${version}-prebuilt-cdh4.tgz"
  $download_destination = "/tmp/${app}.tgz"
  $install_dir = "/srv/software"

  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec["deflate-${app}"],
    require     => Class['xdata::scala'],
    execuser    => "bigdata"
  }
  
  #unzips the file previously downloaded to the /opt directory
  exec { "deflate-${app}":
    cwd         => "/tmp",
    command     => "tar zxf ${download_destination}",
    refreshonly => true,
    user        => "bigdata",
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

}