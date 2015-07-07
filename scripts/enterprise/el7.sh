# Update everything, just in case
yum update -y
yum clean all

# Override udev net-rules
mkdir -p /etc/udev/rules.d/60-net.rules

rm -f /etc/sysconfig/network-scripts/ifcfg-e*
