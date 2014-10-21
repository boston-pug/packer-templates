apt-get install -y linux-source build-essential
# Extract Tarball from iso 
mount /tmp/linux.iso /media
mkdir /tmp/vmware-tools
cp /media/* /tmp/vmware-tools/.
umount /media
rm -f /tmp/linux.iso

tar -xzf /tmp/vmware-tools/*.tar.gz -C /tmp/vmware-tools

echo "Installing vmware tools"
/tmp/vmware-tools/vmware-tools-distrib/vmware-install.pl --default
echo "Done"
