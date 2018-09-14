# ArchLinux installation guide

## Verify boot mode

`ls /sys/firmware/efi/efivars` or `efivar -l`

## Network

`wifi-menu` opens network list

`ping -c 3 archlinux.org` test connection

## Update system clock

`timedatectl set-ntp true`

## Partition the disks

Get disks list `lsblk`.

Prepare disks `sgdisk -Z /dev/nvme0n1`. The key -z or --zap is used to zero out all GPT and MBR data structures. Use this option if you want to completely erase the GPT data structures so that the disk can be used as an MBR disk without concern that it might contain stray GPT data. 

### Partition disks with cfdisk utility

`cfdisk /dev/nvme0n1`

#### Make 4 partiotions 

* 300M EFI System
* 16.4G Linux swap (for hibernation storage)
* 24G Linux filesystem (Root)
* Rest of space Linux filesystem (Home)

`[ Write ]` then type `yes`. `[ Quit ]`.

#### Format partiotions

`mkfs.fat -F32 /dev/nvme0n1p1` - EFI

`mkfs.ext4 -L Root /dev/nvme0n1p3` - Root, same for Home

`mkswap /dev/nvme0n1p2` - Swap. `swapon /dev/nvme0n1p2`

#### Mount partiotions

`mount /dev/nvme0n1p3 /mnt` - Root

`mkdir /mnt/{boot,home}` - prepare folders

`mount /dev/nvme0n1p1 /mnt/boot` - EFI

`mount /dev/nvme0n1p4 /mnt/home/` - Home

Check all is ok `lsblk -o name,mountpoint,label,size,uuid`

## Install OS

Select narest mirror `nano /etc/pacman.d/mirrorlist`

Enable Arch multilib:

`nano /etc/pacman.conf` and uncomment

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

Install necessary `pacstrap /mnt base base-devel linux linux-headers intel-ucode`

Generate fstab `genfstab -U -p /mnt >> /mnt/etc/fstab` and inspect fstab `cat /mnt/etc/fstab`
