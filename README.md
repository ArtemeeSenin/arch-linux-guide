# ArchLinux installation guide

## Verify boot mode

`ls /sys/firmware/efi/efivars` or `efivar -l`

## Network

`menu-wifi` opens network list

`ping -c 3 archlinux.org` test connection

## Update system clock

`timedatectl set-ntp true`

## Partition the disks

Get disks list `lsblk`.

Prepare disks `sgdisk -Z /dev/nvme0n1`

### Partition disks with cfdisk utility

`cfdisk /dev/nvme0n1`
