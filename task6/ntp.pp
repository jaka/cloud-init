exec { "apt-get update":
  command => "/usr/bin/apt-get update"
}

package { "ntp":
  ensure  => "installed",
  require => Exec["apt-get update"]
}

service { "ntpd":
  name => "ntp",
  ensure => running,
  enable => true,
  require => Package["ntp"]
}
