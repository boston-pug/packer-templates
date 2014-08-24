# Install puppetlabs upstream repo
curl -o /tmp/puppetlabs-release-trusty.deb https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i /tmp/puppetlabs-release-trusty.deb
apt-get update -y

# Install puppet
apt-get install puppet -y