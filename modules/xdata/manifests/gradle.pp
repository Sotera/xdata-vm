class xdata::gradle {
  
  $app = "gradle"
  $version = "1.10"
  $url = "http://services.gradle.org/distributions/${app}-${version}-bin.zip"
  $download_destination = "/tmp/${app}-${version}.zip"
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
    command     => "unzip ${download_destination}",
    refreshonly => true,
    notify      => Exec["mv-${app}-folder"],
  }

  exec { "mv-${app}-folder":
    creates     => "${install_dir}",
    cwd         => "/tmp",
    command	=> "mv ${app}-${version} ${install_dir}",
    require     => Exec["deflate-${app}"],
    refreshonly => true,
  }

  file {"/usr/bin/${app}":
    ensure => link,
    target  => "${install_dir}/bin/${app}",
    require => Exec["mv-${app}-folder"],
  }
}