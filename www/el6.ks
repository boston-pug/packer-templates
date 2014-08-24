install
url --url=http://mirror.rit.edu/centos/6.5/os/x86_64/
lang en_US.UTF-8
keyboard us
network --bootproto=dhcp
rootpw --iscrypted $1$damlkd,f$UC/u5pUts5QiU3ow.CSso/
firewall --enabled --service=ssh
authconfig --enableshadow --passalgo=sha512
selinux --disabled
timezone UTC
bootloader --location=mbr