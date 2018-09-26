sed -ni.bak '/Ru/{n;p;}' /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-headers intel-ucode
