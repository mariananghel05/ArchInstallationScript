echo "This part is for installing the base package for my personal pc" ;
echo "these packages may not be compatible with other PCs and can make some conflicts" ; 
echo "if you install" ;
echo "Make sure You have multilib uncommented and sudo installed and added for Your user. If all are done run this script." ;

echo "Do you want to run this script?" 



select yn in "Yes" "No"; do



    case $yn in



        Yes )  echo "Oke. Your will, My hands!" ;
		sudo pacman --noconfirm -S xorg ;
		sudo pacman --noconfirm -S alsa alsa-tools pavucontrol pulseaudio vim ; 
		git clone "https://aur.archlinux.org/optimus-manager.git" ;
		cd optimus-manager/ ;
		makepkg --noconfirm -si ;
		cd ;
		sudo rm -r optimus-manager ;
		git clone "https://aur.archlinux.org/optimus-manager-qt.git" ;
  		cd optimus-manager-qt ;
		makepkg --noconfirm -si ;
		cd ;
		sudo rm -r optimus-manager-qt ;
		sudo pacman -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader ;
		echo "load-module module-echo-cancel source_name=logitechsource source_properties=device.description=LogitechHD" >> /etc/pulse/default.pa ;
		echo "set-default-source logitechsource" >> /etc/pulse/default.pa ;
		sudo pacman -S wine lutris steam ;
		echo "Oke. That it. Any way you have to check if E-sync is activated. I run the check command for you." ;
		echo "This should be 524288 or bigger if You have E-sync, if You have lower then You have to install it." ;
		echo "Google it!" ;
		echo "Oke I run the commnad for You check the output below!" ;
		ulimit -Hn ;
		echo "Your output for command is up ^. Don't forger the HdajackRetask!" ;
#End Of Script
		break;;

        No ) 

		echo "Oke. Have a nice day!" ;
		break;



    esac



done

