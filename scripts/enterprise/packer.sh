# Quick and dirty
yum install -y unzip curl
# Update the URL
curl -L -o /tmp/packer.zip https://dl.bintray.com/mitchellh/packer/packer_0.8.1_linux_amd64.zip
unzip -d /usr/local/bin /tmp/packer.zip
