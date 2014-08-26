skipx
text
eula --agreed

url --url=http://mirrors.cat.pdx.edu/centos/7.0.1406/os/x86_64/

timezone America/New_York --isUtc
lang en_US.UTF-8
keyboard --vckeymap=us --xlayouts='us'

network --bootproto=dhcp --onboot=yes --hostname='centos-7.0.example.com'

authconfig --enableshadow --passalgo=sha512
rootpw --plaintext vagrant
user --name=vagrant --plaintext --password=vagrant

firewall --disabled
selinux --permissive

zerombr
clearpart --all --initlabel --drives=sda
bootloader --location=mbr --boot-drive=sda
autopart --type=lvm

repo --name="updates" --baseurl="http://mirrors.cat.pdx.edu/centos/7.0.1406/updates/x86_64/"
repo --name="puppet-deps" --baseurl="http://yum.puppetlabs.com/el/7/dependencies/x86_64/"
repo --name="puppet" --baseurl="http://yum.puppetlabs.com/el/7/products/x86_64/"

reboot

%packages
@base
@core
puppet
puppetlabs-release
%end

%post
# Clear firmware
yum remove -y *firmware

# Add vagrant user to sudoers
echo "vagrant  ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers.d/vagrant
%end
