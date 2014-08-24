#!/bin/bash

# Clean the logs
find /var/log -type f -delete

# Temp directory
rm -f /tmp/*

# dhcp
rm /var/lib/dhcp/*

# And purge history
rm -f /home/vagrant/.bash_history
rm -f /root/.bash_history