#!/bin/bash

echo "This script is for 3 partitions (EFI/EXT4/SWAP)." ; 
echo "Change the partion names below()" ;
echo "USERNAME is your username write in lowcase letters" ;
echo "If you want to install alongside windows write the boot efi partition of" ; 
echo "windows(usualy has like 100mb) to WINDOWSEFIPARTITION variable" ;
echo "below in variable section" ;

#VARIABLES
EFIPARTITION="/dev/sda1" ;
SWAPPARTITION="/dev/sda2" ; 
EXT4PARTITION="/dev/sda3" ;
USERNAME="marian05" ;
WINDOWSEFIPARTITION="" ;



#fill variable

read -p "Enter the efi partition: " EFIPARTITION ;
read -p "Enter the swap partition: "  SWAPPARTITION ;
read -p "Enter the ext4 partition: "  EXT4PARTITION ;
read -p "Enter Your username(lowercases): "  USERNAME ;
read -p "Enter Your windows efi partiton(if You have one): "  WINDOWSEFIPARTITION ;

#PARTITIONS FORMAT(THIS WILL ERASE ALL YOUR DATE FROM THESE 3 PARTITIONS)

mkfs.ext4 $EXT4PARTITION ;
mkfs.fat -F32 $EFIPARTITION ;
mkswap $SWAPPARTITION ;

#SET SWAP ON

swapon $PARTITION ;

#MOUNTING PARTITIONS

mount /dev/sda3 /mnt ;
mkdir /mnt/boot ;
mount /dev/sda1 /mnt/boot/ ;

#INSTALL THE ESSENTIAL PACKAGES

pacstrap /mnt base linux linux-firmware ;

#CONFIGURE THE SYSTEM

genfstab -U /mnt >> /mnt/etc/fstab ;

git clone https://github.com/mariananghel05/ArchInstallationScript ;

cp ArchInstallationScript/part2.sh /mnt/;
rm -r ArchInstallationScript;


#CHANGE ROOT INTO THE NEW SYSTEM

arch-chroot /mnt chmod +x part2.sh && ./part2.sh;


