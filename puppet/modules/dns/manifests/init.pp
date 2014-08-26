class dns {
  package { 'bind': ensure => present } ->

  file { '/etc/named.conf':
    source => "puppet:///modules/dns/named.conf",
    mode => "0640",
    owner => "root",
    group => "named",
    notify => Service['named'],
  }
  file { '/etc/named/db.203.0.113':
    source => "puppet:///modules/dns/db.203.0.113",
    mode => "0640",
    owner => "root",
    group => "named",
    require => Package['bind'],
    notify => Service['named'],
  }
  file { '/etc/named/db.example':
    source => "puppet:///modules/dns/db.example",
    mode => "0640",
    owner => "root",
    group => "named",
    require => Package['bind'],
    notify => Service['named'],
  }

  service { 'named':
    ensure => running,
    enable => false,
  }
}
