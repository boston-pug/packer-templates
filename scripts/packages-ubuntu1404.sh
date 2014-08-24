# Ruby libraries (so they don't get purged by puppet purge)
# apt-get install libshadow-ruby1.8 libaugeas-ruby1.8 ruby-rgen libjson-ruby -y

# Install puppetlabs upstream repo
curl -o /tmp/puppetlabs-release-trusty.deb https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
apt-get update -y

# Install puppet
apt-get install puppet -y