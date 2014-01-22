class xdata::scala {

  require cdh4pseudo::java

  $app = "scala"
  $version = "2.9.3"
  $url = "http://www.scala-lang.org/files/archive/${app}-${version}.tgz"
  $download_destination = "/tmp/${app}-${version}.tgz"
  $install_dir = "/usr/share/scala"
  
  ##
  # Directions taken from
  # http://kb.solarvps.com/ubuntu/how-to-install-scala-2-9-3-on-ubuntu-12-04-lts/
  ##
  wget::fetch { "scala-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec['deflate-scala'],
  }
  
  # #unzips the file previously downloaded to the /opt directory
  exec { 'deflate-scala':
    creates     => "${install_dir}",
    cwd         => "/tmp",
    command     => "tar zxf ${download_destination}",
    refreshonly => true,
    user        => 'bigdata',
    notify      => Exec['mv-scala-folder'],
  }

  exec { 'mv-scala-folder':
    creates     => "${install_dir}",
    cwd         => "/tmp",
    command	=> "mv ${app}-${version} ${install_dir}",
    refreshonly => true,
  }

  file {'/usr/bin/scala':
    ensure  => link,
    target  => "${install_dir}/bin/scala",
    require => Exec['mv-scala-folder'],
  }
  
  file {'/usr/bin/scalac':
    ensure  => link,
    target  => "${install_dir}/bin/scalac",
    require => Exec['mv-scala-folder'],
  }
  
  file {'/usr/bin/scalap':
    ensure  => link,
    target  => "${install_dir}/bin/scalap",
    require => Exec['mv-scala-folder'],
  }
  
  file {'/usr/bin/scaladoc':
    ensure  => link,
    target  => "${install_dir}/bin/scaladoc",
    require => Exec['mv-scala-folder'],
  }
  
  file {'/usr/bin/fsc':
    ensure  => link,
    target  => "${install_dir}/bin/fsc",
    require => Exec['mv-scala-folder'],
  }

/*  
 * these don't seem to be incldued in the download.
  file {'/usr/bin/sbaz':
    target  => '/usr/share/scala/bin/sbaz',
    require => Exec['mv-scala-folder'],
  }
  
  file {'/usr/bin/sbaz-setup':
    target  => '/usr/share/scala/bin/sbaz-setup',
    require => Exec['mv-scala-folder'],
  }  
 */

}