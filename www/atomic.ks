# OSTree setup
eula --agreed
ostreesetup --osname="centos-atomic-host" --remote="centos-atomic-host" --url="file:///install/ostree" --ref="centos-atomic-host/7/x86_64/standard" --nogpg
# Root password
rootpw --iscrypted $6$wYsgxOWKg9j24ZvB$U8bDrfTFxBooGiXr3QNivMWeSylu3ODKi8zvpBip1UxlgwWGBrZBpvpwQa3slfM2iKDQ2smwiJlxHbF1pMzvj1
# System services
services --disabled="cloud-init,cloud-config,cloud-final,cloud-init-local"
# System timezone
timezone America/New_York --isUtc
user --groups=wheel --name=vagrant --password=$6$IJyUUWig26OfFTz8$bQWejOUpOJsGx2fSX9UJwkD4Liqsknk7DEQj4g23/wlVWLDmhVeIcfdRcz7fk1fXMZAEgGgyGkHGOXXL1FwlV1 --iscrypted --gecos="vagrant"
# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
autopart --type=lvm
# Partition clearing information
clearpart --none --initlabel
# Reboot automatically
reboot

%post --erroronfail
echo "vagrant  ALL=(ALL)   NOPASSWD:ALL" >> /etc/sudoers.d/vagrant
fn=/etc/ostree/remotes.d/centos-atomic-host.conf; if test -f ${fn} && grep -q -e '^url=file:///install/ostree' ${fn}$; then rm ${fn}; fi
# Override udev net-rules
mkdir -p /etc/udev/rules.d/60-net.rules

# Add ^?"net.ifnames=0" and "biosdevname=0"
sed -i -e 's/quiet/net.ifnames=0 biosdevname=0 quiet/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

# Clear out bad ifcfg scripts
rm -f /etc/sysconfig/network-scripts/ifcfg-e*

# Turn off requiretty for sudo
sed -i -e 's/requiretty/!requiretty/' /etc/sudoers
%end
