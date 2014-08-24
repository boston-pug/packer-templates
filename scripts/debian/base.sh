# Clear motd
rm -f /etc/motd && touch /etc/motd

# more RHEL, but does no harm
echo "UseDNS no" >> /etc/ssh/sshd_config

# Override some defaults
sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=sudo' /etc/sudoers
sed -i -e 's/^Defaults\ requiretty/\#Defaults\ requiretty/g /etc/sudoers'

# Nopasswd for sudo
sed -i -e 's/%sudo  ALL=(ALL:ALL) ALL/%sudo  ALL=NOPASSWD:ALL/g' /etc/sudoers

# And make sure vagrant is allowed
echo "vagrant  ALL=NOPASSWD:ALL" >> /etc/sudoers