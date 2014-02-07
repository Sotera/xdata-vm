class sotera::louvain {

  $app = "distributed-louvain-modularity"
  $version = "1.0.0"
  $download_destination = "/tmp/${app}.tar.gz"
  $install_dir = "/srv/software"
  $url = "https://github.com/Sotera/distributed-louvain-modularity/releases/download/v1.0_chd4.5.0_giraph1.0.0/distributed-louvain-modularity-cdh4.5.0-giraph1.0.0-bin.tar.gz"

  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec["deflate-${app}"],
    require     => Class['cdh4pseudo::hive'],
    execuser    => bigdata
  }

  exec { "deflate-${app}":
    cwd         => "/tmp",
    command     => "tar zxf ${download_destination}",
    refreshonly => true,
    user        => 'bigdata',
    notify      => Exec["mv-${app}-folder"],
  }

  exec { "mv-${app}-folder":
    creates     => "${install_dir}/distributed-louvain-modularity",
    cwd         => "/tmp",
    command	=> "mv distributed-louvain-modularity ${install_dir}/",
    require     => Exec["deflate-${app}"],
    refreshonly => true,
  } 

}