skipx
text
install
eula --agreed
url --url=http://mirror.seas.harvard.edu/fedora/linux/releases/20/Everything/x86_64/os/
timezone America/New_York --isUtc
lang en_US.UTF-8
keyboard --vckeymap=us --xlayouts='us'

network --bootproto=dhcp --onboot=yes --hostname='fedora20.example.com'

authconfig --enableshadow --passalgo=sha512
rootpw --plaintext vagrant
user --name=vagrant --plaintext --password=vagrant

firewall --disabled
selinux --permissive

zerombr
clearpart --all --initlabel --drives=sda
bootloader --location=mbr --boot-drive=sda --append="norhgb biosdevname=0"
autopart --type=lvm

repo --name="updates" --baseurl="http://mirror.seas.harvard.edu/fedora/linux/updates/20/x86_64/"
repo --name="puppet-deps" --baseurl="http://yum.puppetlabs.com/fedora/f20/dependencies/x86_64/"
repo --name="puppet" --baseurl="http://yum.puppetlabs.com/fedora/f20/products/x86_64/"

reboot

%packages --nobase --ignoremissing --excludedocs
puppet
puppetlabs-release
-linux-firmware
-plymouth
-plymouth-core-libs
%end

%post
# Add vagrant user to sudoers
echo "vagrant  ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers.d/vagrant
%end
