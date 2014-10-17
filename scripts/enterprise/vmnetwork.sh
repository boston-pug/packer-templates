rm -f /etc/sysconfig/network-scripts/ifcfg-eth0

cat <<EOT >/etc/sysconfig/network-scripts/ifcfg-eth0
DEVICE="eth0"
BOOTPROTO="dhcp"
ONBOOT="yes"
TYPE="Ethernet"
NM_CONTROLLED="yes"
EOT
