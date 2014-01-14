class xdata::maven {
  
  $app = "maven"
  $app_bin = "mvn"
  $version = "3.1.1"
  $url = "ftp://apache.cs.utah.edu/apache.org/maven/maven-3/${version}/binaries/apache-${app}-${version}-bin.tar.gz"
  $download_destination = "/tmp/${app}-${version}.tar.gz"
  $install_dir = "/usr/share/${app}"

  wget::fetch { "${app}-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec["deflate-${app}"],
  }
  
  # #unzips the file previously downloaded to the /opt directory
  exec { "deflate-${app}":
    creates     => "${install_dir}",
    cwd         => "/tmp",
    command     => "tar zxf ${download_destination}",
    refreshonly => true,
    notify      => Exec["mv-${app}-folder"],
  }

  exec { "mv-${app}-folder":
    creates     => "${install_dir}",
    cwd         => "/tmp",
    command	=> "mv apache-${app}-${version} ${install_dir}",
    require     => Exec["deflate-${app}"],
    refreshonly => true,
  }

  file {"/usr/bin/${app_bin}":
    ensure => link,
    target  => "${install_dir}/bin/${app_bin}",
    require => Exec["mv-${app}-folder"],
  }
  
  file {"/usr/bin/${app_bin}Debug":
    ensure => link,
    target  => "${install_dir}/bin/${app_bin}Debug",
    require => Exec["mv-${app}-folder"],
  }
}