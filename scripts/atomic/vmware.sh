docker pull rhel7/rhel-tools
atomic install rhel7/rhel-tools
cat <<EOS >/tmp/script.sh
#!/bin/bash
#  Remove the el repo
rm -f /etc/yum.repos.d/redhat.repo

# Install the CentOS repo
cat <<EOT >/etc/yum.repos.d/centos.repo
[base]
name=CentOS-7 - Base
baseurl=http://mirror.centos.org/centos/7/os/x86_64/
gpgcheck=0

#released updates
[updates]
name=CentOS-7 - Updates
baseurl=http://mirror.centos.org/centos/7/updates/x86_64/
gpgcheck=0

#additional packages that may be useful
[extras]
name=CentOS-7 - Extras
baseurl=http://mirror.centos.org/centos/7/extras/x86_64/
gpgcheck=0
EOT

# Install prereqs
yum install -y kernel-headers gcc fuse make kernel-devel perl

# Extract Tarball from iso
mount /tmp/linux.iso /media
mkdir /tmp/vmware-tools
cp /media/* /tmp/vmware-tools/.
umount /media
rm -f /tmp/linux.iso

tar -xzf /tmp/vmware-tools/*.tar.gz -C /tmp/vmware-tools

# Need to patch hgfs
# Redhat Backported some stuff from > 3.11 kernel including dcount
# behavior, which gets borken in EL7
tar -xf /tmp/vmware-tools/vmware-tools-distrib/lib/modules/source/vmhgfs.tar -C /tmp/vmware-tools/vmware-tools-distrib/lib/modules/source/
sed -i -e 's/3,\ 11/3,\ 10/' /tmp/vmware-tools/vmware-tools-distrib/lib/modules/source/vmhgfs-only/shared/compat_dcache.h
tar -C /tmp/vmware-tools/vmware-tools-distrib/lib/modules/source/ -cvf /tmp/vmware-tools/vmware-tools-distrib/lib/modules/source/vmhgfs.tar vmhgfs-only

/tmp/vmware-tools/vmware-tools-distrib/vmware-install.pl --default

exit
EOS
chmod 755 /tmp/script.sh
/usr/bin/docker run -d -it --name rhel-tools --privileged --ipc=host --net=host --pid=host -e HOST=/host -e NAME=rhel-tools -e IMAGE=rhel7/rhel-tools -v /run:/run -v /var/log:/var/log -v /etc/localtime:/etc/localtime -v /:/host rhel7/rhel-tools
/bin/atomic run rhel7/rhel-tools /host/tmp/script.sh
