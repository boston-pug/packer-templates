skipx
text
eula --agreed

url --url=http://mirror.umd.edu/centos/7/os/x86_64/

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
bootloader --location=mbr --boot-drive=sda --append="biosdevname=0"
autopart --type=lvm

repo --name="updates" --baseurl="http://mirror.umd.edu/centos/7/updates/x86_64/"

reboot

%post 
# Basic vagrant settings
sed -i -e 's/requiretty/!requiretty/' /etc/sudoers && echo "vagrant  ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant 

# ifcfg-ethX for life!
sed -i -e 's/quiet/net.ifnames=0 biosdevname=0 quiet/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# No network manager
systemctl disable NetworkManager
systemctl enable network
%end

%packages —-nobase
bash-completion
-*firmware
%end
