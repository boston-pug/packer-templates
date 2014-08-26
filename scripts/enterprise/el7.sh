# Override udev net-rules
mkdir -p /etc/udev/rules.d/60-net.rules

# Add "net.ifnames=0" and "biosdevname=0" 
sed -i -e 's/quiet/net.ifnames=0 biosdevname=0 quiet/' /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

rm -f /etc/sysconfig/network-scripts/ifcfg-e*
