mount -o loop VBoxGuestAdditions.iso /mnt
yes|sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f VBoxLinuxAdditions.iso
