genfstab -U /mnt > /mnt/etc/fstab
cat /mnt/etc/fstab

arch-chroot /mnt

ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
hwclock --systohc --utc

echo -e 'en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8' > /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

echo -e '127.0.0.1 localhost\n::1 localhost\n127.0.0.1 archlinux.localdomain archlinux' > /etc/hosts
echo 'archlinux' > /etc/hostname
pacman -S networkmanager
systemctl enable NetworkManager
systemctl enable dhcpcd
systemctl enable dhcpcd@eno1.service
pacman -S dialog
wifi-menu
netctl enable $(ls /etc/netctl | grep wlo1)

passwd

mkinitcpio -p linux
bootctl install
echo -n 'default arch\neditor 0\ntimeout 0' > /boot/loader/loader.conf
echo -n'title   ArchLinux\nlinux   /vmlinuz-linux\ninitrd  /intel-ucode.img\ninitrd  /initramfs-linux.img\noptions root=PARTUUID='$(blkid -s PARTUUID -o value /dev/nvme0n1p2' rw spectre_v2=off pti=off modprobe.blacklist=nouveau modprobe.blacklist=nvidia' > /boot/loader/entries/arch.conf

useradd -m -G audio,lp,optical,power,storage,video,wheel -s /bin/bash artemee
passwd artemee
if ! grep '^%wheel' /etc/sudoers ; then echo '%wheel      ALL=(ALL) ALL' >> /etc/sudoers ; fi
