# Clear motd
rm -f /etc/motd && touch /etc/motd

# Fix sshd to not use dns
sed -i -e 's/^\#UseDNS[\ ]*yes/UseDNS no/g' /etc/ssh/sshd_config
