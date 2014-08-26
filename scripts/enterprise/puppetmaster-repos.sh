rpm --import http://passenger.stealthymonkeys.com/RPM-GPG-KEY-stealthymonkeys.asc
yum install -y http://passenger.stealthymonkeys.com/rhel/6/passenger-release.noarch.rpm 
yum install -y http://mirrors.kernel.org/fedora-epel/6/i386/epel-release-6-8.noarch.rpm
yum update -y
