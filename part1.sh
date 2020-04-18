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

git clone "https://github.com/mariananghel05/ArchInstallationScript" ;

cp ArchInstallationScript/part2.sh /mnt/ ;
cp ArchInstallationScript/part3.sh /mnt/home/ ;
rm -r ArchInstallationScript part1.sh;


#CHANGE ROOT INTO THE NEW SYSTEM
chmod +x /mnt/part2.sh ;
arch-chroot /mnt ./part2.sh;

echo "Do you want reboot?" 

select yn in "Yes" "No"; do

    case $yn in

        Yes )	umount -a ;	
        	    reboot ;
		          break ;;

        No ) 
		        echo "Ok. My job is done here. If you want to get back into sistem use arch-chroot. " ;
		        echo "Don't forget to use 'umount -a' and 'reboot' to reboot" ; 
		        break;

    esac

done


