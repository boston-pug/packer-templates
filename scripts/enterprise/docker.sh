# Latest is always going to be here:
# https://docs.docker.com/installation/centos/
yum install -y https://get.docker.com/rpm/1.7.0/centos-7/RPMS/x86_64/docker-engine-1.7.0-1.el7.centos.x86_64.rpm

# Look ma, we're debian
systemctl enable docker

# Allow the vagrant user to docker
usermod -aG docker vagrant
