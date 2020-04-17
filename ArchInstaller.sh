#This script is for 3 partitions (EFI/EXT4/SWAP). 
#Change the partion names below()
#USERNAME is your username write in lowcase letters
EFIPARTITION="/dev/sda1"
SWAPPARTITION="/dev/sda2"
EXT4PARTITIO="/dev/sda3"
USERNAME="marian05"
WINDOWSEFIPARTITION=""
#PARTITIONS FORMAT(THIS WILL ERASE ALL YOUR DATE FROM THESE 3 PARTITIONS)

mkfs.ext4 $EXT4PARTITION
mkfs.fat -F32 $EFIPARTITION
mkswap $SWAPPARTITION

#SET SWAP ON

swapon $PARTITION

#MOUNTING PARTITIONS

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot/

#INSTALL THE ESSENTIAL PACKAGES

pacstrap /mnt base linux linux-firmware

#CONFIGURE THE SYSTEM

genfstab -U /mnt >> /mnt/etc/fstab

#CHANGE ROOT INTO THE NEW SYSTEM

arch-chroot /mnt
pacman -S nano

#TIMEZONE

ln -sf /usr/share/zoneinfo/Europe/Buchares /etc/localtime

#RUN HWCLOCK TO GENERATE /etc/adjtime

hwclock --systohc

#UNCOMENT THE LOCALE 

sudo nano /etc/locale.gen

#GENERATE LOCALES

locale-gen

#CREATE LOCALE.CONF
touch /etc/locale.conf
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

#NETWORK CONFIGURATIONS

touch /etc/hostname
touch /etc/hosts
echo "$USERNAME" >> /etc/hostname
echo "127.0.0.1		localhost" >> /etc/hosts
echo "::1		localhost" >> /etc/hosts
echo "127.0.1.1		$USERNAME.localdomain	$USERNAME"

#PASWORD OF ROOT

passwd

#BOOTLOADER INSTALLATION

pacman -S grub efibootmgr mtools dialog networkmanager network-manager-applet wireless_tools os-prober dosfstools git
grub-install --target=x86_64-efi --efi-directory=boot --bootloader-id=ARCHLINUX

echo "Do you have a windows on your PC?(Select by number [1/2])"

select yn in "Yes" "No"; do

    case $yn in

        Yes )	mkdir /boot/windows10;
		mount $WINDOWSEFIPARTITION /boot/windows10/;
		grub-mkconfig -o /boot/grub/grub.cfg;
		#END INSTALLATION 
                systemctl enable NetworkManager;			
		 break;;

        No ) 
		grub-mkconfig -o /boot/grub/grub.cfg;
		#END OF INSTALLATION
		systemctl enable NetworkManager;
		break;

    esac

done

#EXIT AND REBOOT
exit;
umount -a;

echo "Do you want to reboot?(Select by number no by word!)"

select yn in "Yes" "No"; do

    case $yn in

        Yes ) echo "Good Luck!";
		reboot; break;;

        No )  echo "Ok! My work it's done here. Good Luck and you can anytime reboot by 'reboot' command";    
		 break;

    esac

done
     


