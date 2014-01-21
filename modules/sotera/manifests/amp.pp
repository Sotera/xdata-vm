class sotera::amp {

  $app = "aggregate-micro-paths"
  $download_destination = "/tmp/${app}.zip"
  $install_dir = "/srv/software"
  $url = "https://github.com/Sotera/aggregate-micro-paths.git"

  exec { "git-clone-${app}":
     cwd         => "/tmp",
     command     => "git clone ${url}",
     user        => 'bigdata',
     notify      => Exec["mv-${app}-folder"],
  }

  exec { "mv-${app}-folder":
    creates     => "${install_dir}/${app}",
    cwd         => "/tmp",
    command	=> "mv ${app} ${install_dir}/",
    require     => Exec["git-clone-${app}"],
    refreshonly => true,
  } 

}