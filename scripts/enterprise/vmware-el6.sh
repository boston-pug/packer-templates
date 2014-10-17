rpm –import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-DSA-KEY.pub
rpm –import http://packages.vmware.com/tools/keys/VMWARE-PACKAGING-GPG-RSA-KEY.pub

cat <<EOT >/etc/yum.repos.d/vmware-tools.repo
[vmware-tools]
name=VMware Tools
baseurl=http://packages.vmware.com/tools/esx/latest/rhel6/\$basearch
enabled=1
gpgcheck=0
EOT

yum -y install vmware-tools-hgfs vmware-tools-esx-nox
echo "modprobe vmhgfs" > /etc/sysconfig/modules/vmhgfs.modules 
chmod +x /etc/sysconfig/modules/vmhgfs.modules
