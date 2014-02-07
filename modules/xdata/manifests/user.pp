class xdata::user () {

    user { 'bigdata' :
      ensure => 'present',
      comment => 'bigdata account',
      home => '/home/bigdata',
      shell => '/bin/bash',
      password => '$6$dLZdo8FF$uPcBvcLTgD63sHXKYdPQRLKyn.gX9kgpEsez3MjD/pE0qWU4UaG.j2jxobZ2lVcfT7z6J/VQIwKvNiMgiiniH1',
      password_max_age => '99999',
      password_min_age => '0',
    }

    exec { "$name homedir":
         command => "/bin/cp -R /etc/skel /home/bigdata; /bin/chown -R bigdata:bigdata /home/bigdata",
         creates => "/home/bigdata",
         require => User['bigdata'],
    }

    file { 'bigdata-sudoers':
         path    => '/etc/sudoers.d/bigdata',
         source  => "puppet:///modules/xdata/sudoer-bigdata",
         ensure  => file,
         owner   => 'root',
         group   => 'root',
         mode    => '0440',
         replace => true,
         require => User['bigdata'],
     }
  
}
