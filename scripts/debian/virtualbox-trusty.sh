apt-get install -y binutils cpp cpp-4.8 fakeroot gcc gcc-4.8 libasan0 libatomic1 libc-dev-bin libc6-dev libcloog-isl4 libfakeroot libgcc-4.8-dev libgmp10 libgomp1 libisl10 libitm1 libmpc3 libmpfr4 libquadmath0 libtsan0 linux-libc-dev make manpages-dev patch

mount -o loop VBoxGuestAdditions.iso /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f VBoxLinuxAdditions.iso

apt-get remove -y binutils cpp cpp-4.8 fakeroot gcc gcc-4.8 libasan0 libatomic1 libc-dev-bin libc6-dev libcloog-isl4 libfakeroot libgcc-4.8-dev libgmp10 libgomp1 libisl10 libitm1 libmpc3 libmpfr4 libquadmath0 libtsan0 linux-libc-dev make manpages-dev patch
