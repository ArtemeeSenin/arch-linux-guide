efivar -l
wifi-menu
ping -c 4 archlinux.org
timedatectl set-ntp true
lsblk
sgdisk -Z /dev/nvme0n1
cfdisk /dev/nvme0n1
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 -L Root /dev/nvme0n1p2
mkfs.ext4 -L Home /dev/nvme0n1p3
lsblk --fs
mount /dev/nvme0n1p3 /mnt
mkdir /mnt/{boot,home}
mount /dev/nvme0n1p1 /mnt/boot
mount /dev/nvme0n1p3 /mnt/home/
mkdir /mnt/mnt/Storage
mount /dev/sda1 /mnt/mnt/Storage
lsblk -o name,mountpoint,label,size,uuid
