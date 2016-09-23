class nginx {

  file { "/opt/geoip":
    ensure => directory
  }

  exec { "wget_geoip":
    command => "/usr/bin/wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz -O /opt/geoip/GeoIP.dat.gz"
  }

  exec { "gunzip": 
    command => "/bin/gunzip -f /opt/geoip/GeoIP.dat.gz",
    require => Exec["wget_geoip"]
  }

  file { "/opt/debs":
    ensure => directory
  }

  package { [ "libc6", "libgd3", "libgeoip1", "libpcre3", "libssl1.0.0", "libxml2", "libxslt1.1", "zlib1g" ]:
    ensure => "installed",
    before => Package["nginx-common", "nginx-core"]
  }

  file { "/opt/debs/nginx-common.deb":
    owner   => root,
    group   => root,
    mode    => 644,
    ensure  => present,
    source  => "puppet:///modules/nginx/nginx-common_1.8.1-3fs_all.deb"
  }

  file { "/opt/debs/nginx-core.deb":
    owner   => root,
    group   => root,
    mode    => 644,
    ensure  => present,
    source  => "puppet:///modules/nginx/nginx-core_1.8.1-3fs_amd64.deb"
  }

  package { "nginx-common":
    provider => dpkg,
    ensure => installed,
    source => "/opt/debs/nginx-common.deb"
  }

  package { "nginx-core":
    provider => dpkg,
    ensure => installed,
    source => "/opt/debs/nginx-core.deb"
  }

  file { "/etc/nginx/geo":
    ensure  => "present",
    content => "
    geoip_country /opt/geoip/GeoIP.dat;
    map \$geoip_country_code \$allowed_country {
        default yes;
        SI no;
    }",
    mode    => "0644",
  }

  exec { "setup-geolock1":
    command => "/bin/sed -i '/http {/a\\\tinclude /etc/nginx/geo;' /etc/nginx/nginx.conf",
    unless => "/bin/grep -q '/etc/nginx/geo' /etc/nginx/nginx.conf ; /usr/bin/test $? -eq 0"
  }

  exec { "setup-geolock2":
    command => "/bin/sed -i '/^server {/a\\\tif (\$allowed_country = no) { return 403; }' /etc/nginx/sites-available/default",
    unless => "/bin/grep -q 'allowed_country' /etc/nginx/sites-available/default ; /usr/bin/test $? -eq 0"
  }

}
