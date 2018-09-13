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

Prepare disks `sgdisk -Z /dev/nvme0n1`. The key -z or --zap is used to zero out all GPT and MBR data structures. Use this option if you want to completely erase the GPT data structures so that the disk can be used as an MBR disk without concern that it might contain stray GPT data. 

### Partition disks with cfdisk utility

`cfdisk /dev/nvme0n1`
