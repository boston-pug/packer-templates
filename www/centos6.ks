text

url --url=http://mirror.rit.edu/centos/6.5/os/x86_64/

timezone --utc America/New_York
lang en_US.UTF-8
keyboard us

network --bootproto=dhcp --onboot=yes --hostname=el6-minimal

authconfig --enableshadow --passalgo=sha512
rootpw --plaintext vagrant
user --name=vagrant --plaintext --password=vagrant

firewall --disabled
selinux --permissive

zerombr
clearpart --all --initlabel --drives=sda
bootloader --location=mbr --driveorder=sda --append="crashkernel=auto rhgb quiet"
autopart

repo --name="updates" --baseurl="http://mirror.rit.edu/centos/6.5/updates/x86_64/"
repo --name="puppet-deps" --baseurl="http://yum.puppetlabs.com/el/6/dependencies/x86_64/"
repo --name="puppet" --baseurl="http://yum.puppetlabs.com/el/6/products/x86_64/"

reboot

%packages
@base
@core
puppet

%post
echo "Removing firmware packages"
yum remove -y *firmware

echo "Clearing motd"
rm -f /etc/motd && touch /etc/motd

echo "Setting up SSH for vagrant"
echo "UseDNS no" >> /etc/ssh/sshd_config

echo "Setting up sudoers"
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/^Defaults\ requiretty/\#Defaults\ requiretty/g /etc/sudoers'

# Nopasswd for sudo
sed -i -e 's/%sudo  ALL=(ALL:ALL) ALL/%sudo  ALL=NOPASSWD:ALL/g' /etc/sudoers

echo "Adding vagrant to sudoers"
echo "vagrant  ALL=NOPASSWD:ALL" >> /etc/sudoers