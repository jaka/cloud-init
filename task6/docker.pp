exec { "apt-get update":
  command => "/usr/bin/apt-get update"
}

package { ["apt-transport-https", "ca-certificates"]:
  ensure  => "installed",
  require => Exec["apt-get update"],
}

exec { "apt-key":
  command => "/usr/bin/apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D"
}

file { "/etc/apt/sources.list.d/docker.list":
  ensure => "present",
  owner => "root",
  group => "root",
  mode => "644",
  content => "deb https://apt.dockerproject.org/repo ubuntu-trusty main",
  notify => Exec["apt-get update"],
  require => Exec["apt-key"]
}

package { ["linux-image-extra-virtual", "docker-engine"] :
  ensure  => "installed",
  require => File["/etc/apt/sources.list.d/docker.list"]
}
