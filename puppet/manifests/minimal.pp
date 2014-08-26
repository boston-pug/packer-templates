#Basic Puppet Testing Kit
package { 'bundler':
  provider => 'gem',
  ensure => '1.3.5',
}
package { 'rake':
  provider => 'gem',
  ensure => '10.1.0',
}
package { 'rspec-puppet':
  provider => 'gem',
  ensure => '1.0.1',
} 
package { 'puppetlabs_spec_helper':
  provider => 'gem',
  ensure => '0.4.1',
}
package { 'puppet-lint':
  provider => 'gem',
  ensure => '0.3.2',
}

