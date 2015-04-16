skipx
text
install
eula --agreed

url --url=http://mirror.seas.harvard.edu/fedora/linux/releases/21/Server/x86_64/os

timezone America/New_York --isUtc
lang en_US.UTF-8
keyboard --vckeymap=us --xlayouts='us'

network --bootproto=dhcp --onboot=yes --hostname='fedora21.example.com'

authconfig --enableshadow --passalgo=sha512
rootpw --plaintext vagrant
user --name=vagrant --plaintext --password=vagrant

firewall --disabled
selinux --permissive

zerombr
clearpart --all --initlabel --drives=sda
bootloader --location=mbr --boot-drive=sda
autopart --type=lvm

repo --name="everything" --baseurl="http://mirror.seas.harvard.edu/fedora/linux/releases/21/Everything/x86_64/os/"
repo --name="updates" --baseurl="http://mirror.seas.harvard.edu/fedora/linux/updates/21/x86_64/"
repo --name="puppet-deps" --baseurl="http://yum.puppetlabs.com/fedora/f21/dependencies/x86_64/"
repo --name="puppet" --baseurl="http://yum.puppetlabs.com/fedora/f21/products/x86_64/"

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
reboot
%end
