# ArchLinux installation guide

Installation process:

1. Pre-installation
   * Verify boot mode
   * Connect to the internet
   * Update system clock
   * Partition disks
   * Format partitions
   * Mount the file systems
2. Installation
   * Select mirrors
   * Install the base packages
3. Configure system
   * Fstab
   * Chroot
   * Time zone
   * Localization
   * Network config
   * Initramfs
   * Root password
   * Boot loader
   * Reboot 
4. Post-installation
   * Install XOrg
   * Install KDE and kde-applications
   * Install Sddm

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
* 16.4G Linux swap (for hibernation storage) - Optional
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

Install necessary `pacstrap /mnt base base-devel linux linux-headers intel-ucode`

Generate fstab `genfstab -U -p /mnt >> /mnt/etc/fstab` and inspect fstab `cat /mnt/etc/fstab`

## Configure the system

`arch-chroot /mnt`

`echo "archbox" > /etc/hostname`

### Set the time zone

`ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime /etc/localtime`

`hwclock --systohc --utc`

### Locale

`echo -e 'en_US.UTF-8 UTF-8\nru_RU.UTF-8 UTF-8' > /etc/locale.gen`

`locale-gen`

`echo 'LANG=en_US.UTF-8' > /etc/locale.conf`

`export LANG=en_US.UTF-8`

`passwd`

Hosts `sudo nano /etc/hosts`

```
127.0.0.1 localhost
::1 localhost
127.0.0.1 archlinux.localdomain archlinux
```

Update database mirrors and packages `pacman -Syu` 

## Set up  desktop environment

Install graphic drivers `sudo pacman -S xf86-video-intel`

Install XOrg `sudo pacman -S xorg-server xorg-utils xorg-apps`

Reboot and configure XOrg `Xorg :0 -configure`
Then comment all Nvidia entries

```
nano xorg.conf.new 
sudo cp /home/artemee/xorg.conf.new /etc/X11/xorg.conf
```


Install KDE Plasma

```
sudo pacman -S plasma
sudo pacman -S kde-applications
sudo pacman -S sddm

sudo systemctl status sddm
sudo systemctl enable sddm
```

## Postinstall

### Nvm

Install [nvm](https://github.com/creationix/nvm) `curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash`
Create .nvmrc file `echo "node" > .nvmrc # to default to the latest version`
