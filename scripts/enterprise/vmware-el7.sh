# Install prereqs
yum install -y kernel-headers gcc fuse make kernel-devel

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

echo "Installing vmware tools"
/tmp/vmware-tools/vmware-tools-distrib/vmware-install.pl --default
echo "answer AUTO_KMODS_ENABLED yes" | sudo tee -a /etc/vmware-tools/locations
echo "Done"
