class xdata::sbt {

  require xdata::scala  

  $app = "sbt"
  $version = "0.13.0"
  $url = "http://repo.scala-sbt.org/scalasbt/sbt-native-packages/org/scala-sbt/sbt/${version}/${app}.deb"
  $download_destination = "/tmp/${app}-${version}.deb"
    
  ##
  # Directions taken from
  # http://kb.solarvps.com/ubuntu/how-to-install-scala-2-9-3-on-ubuntu-12-04-lts/
  ##
  wget::fetch { "sbt-app-download":
    source      => $url,
    destination => $download_destination,
    verbose     => false,
    notify      => Exec['install-sbt'],
  }
  
  # #unzips the file previously downloaded to the /opt directory
  exec { 'install-sbt':
    command     => "dpkg -i ${download_destination}",
    refreshonly => true,
  }

}