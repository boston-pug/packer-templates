class puppetmaster::packages {
  package { 'httpd': ensure => present }
  package { 'mod_ssl': ensure => present }
  package { 'mod_passenger': ensure => present }
  package { 'puppet-server': ensure => present }
}

class puppetmaster::services {
  service { 'puppetmaster': 
    ensure => stopped, 
    enable => false, 
    require => Package['puppet-server'],
  }
}

class puppetmaster {
  require puppetmaster::packages
  include puppetmaster::services

  # Fix up the reports directory
  file { '/var/lib/puppet/reports/':
    ensure => directory,
    owner => 'puppet',
  }

  # Set up rack directories and puppetmaster in passenger
  file { '/usr/share/puppet/rack': 
    ensure => directory, 
    owner => "puppet", 
  } ->
  file { '/usr/share/puppet/rack/puppetmaster': 
    ensure => directory, 
    owner => "puppet", 
  } ->
  file { '/usr/share/puppet/rack/puppetmaster/public': 
    ensure => directory, 
    owner => "puppet", 
    group => "puppet", 
  } ->
  file { '/usr/share/puppet/rack/puppetmaster/config.ru': 
    source => 'puppet:///modules/puppetmaster/config.ru', 
    owner => "puppet", 
    require => File['/usr/share/puppet/rack/puppetmaster'], 
  }

  # Apache config
  file { '/etc/httpd/conf.d/puppetmaster.conf':
    source => 'puppet:///modules/puppetmaster/puppetmaster.conf',
  }
}
