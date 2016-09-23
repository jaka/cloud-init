class php5 {

  file { "/opt/debs":
    ensure => directory
  }

  file { "/opt/debs/php5.deb":
    owner   => root,
    group   => root,
    mode    => 644,
    ensure  => present,
    source  => "puppet:///modules/php5/php5_5.6.25-3fs_amd64.deb"
  }

  package { "php5":
    provider => dpkg,
    ensure => installed,
    source => "/opt/debs/php5.deb"
  }

  package { "spawn-fcgi":
    ensure  => "installed" 
  }

  file { "/etc/default/spawn-fcgi":
    source => 'puppet:///modules/php5/spawn-fcgi',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  
  file { "/etc/init/php5-cgi.conf":
    source => 'puppet:///modules/php5/php5-cgi.conf',
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  service { "php5-cgi":
    ensure => "running",
    provider => "upstart",
    require => File[ "/etc/init/php5-cgi.conf" ]
  }

}
