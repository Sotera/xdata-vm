class sotera::corr-approx {

	$app = "correlation-approximation"
	$install_dir = "/srv/software"
	$url = "https://github.com/Sotera/correlation-approximation.git"
	
	exec { "git-clone-${app}":
		unless 	=> "sudo ls ${install_dir}/correlation-approximation",
		cwd		=> "/tmp",
		command	=> "git clone ${url}",
		user	=> 'bigdata',
		notify	=> Exec["mv-${app}-folder"]
	}
	
	exec { "mv-${app}-folder": 
		creates		=> "${install_dir}/${app}",
		cwd			=> "/tmp",
		command		=> "mv ${app} ${install_dir}/",
		require		=> Exec["git-clone-${app}"],
		refreshonly	=> true
	}
}