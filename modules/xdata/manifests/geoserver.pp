class xdata::geoserver {
    
    $app="geoserver"
    $version="2.3.5"
    $url = "http://iweb.dl.sourceforge.net/project/geoserver/GeoServer/2.3.5/${app}-${version}-bin.zip"
    $destination_name = "/tmp/${app}.zip"
    
    wget::fetch { "app-download":
	  source      => $url,
	  destination => $destination_name,
	  verbose     => false,
	  notify      => Exec["unzip-${app}"],
	}

    ##unzips the file previously downloaded to the /opt directory
    exec {"unzip-${app}": 
        cwd => '/srv/software/',
        user        => 'bigdata',
        command     => "unzip ${destination_name}",
        refreshonly => true,
        creates     => '/srv/software/${app}-${version}/',
        
    }
    
}