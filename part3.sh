echo "This part is for installing the base package for my personal pc" ;
echo "these packages may not be compatible with other PCs and can make some conflicts" ; 
echo "if you install" ;
echo "Make sure You have multilib uncommented and sudo installed and added for Your user. If all are done run this script." ;

echo "Do you want to run this script?" 



select yn in "Yes" "No"; do



    case $yn in



        Yes )  echo "Oke. Your will, My hands!" ;
                cd /home/$USER ;
                sudo pacman --noconfirm -S xorg ;
		sudo pacman --noconfirm -S alsa alsa-tools pavucontrol pulseaudio vim ; 
		git clone "https://aur.archlinux.org/optimus-manager.git" ;
		cd optimus-manager/ ;
		makepkg --noconfirm -si ;
		cd ;
		sudo rm -r optimus-manager ;
		git clone "https://aur.archlinux.org/optimus-manager-qt.git" ;
  		cd optimus-manager-qt/ ;
		makepkg --noconfirm -si ;
		cd ;
		sudo rm -r optimus-manager-qt ;
		sudo pacman --noconfirm -S nvidia nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader ;
		sudo echo "load-module module-echo-cancel source_name=logitechsource source_properties=device.description=LogitechHD" >> /etc/pulse/default.pa ;
		sudo echo "set-default-source logitechsource" >> /etc/pulse/default.pa ;
		sudo pacman --noconfirm -S wine lutris steam lxterminal firefox ;
		git clone "https://aur.archlinux.org/skypeforlinux-stable-bin.git " ;
  		cd skypeforlinux-stable-bin/ ;
		makepkg --noconfirm -si ;
		cd ;
		sudo rm -r skypeforlinux-stable-bin ;
		echo "Oke. That it. Any way you have to check if E-sync is activated. I run the check command for you." ;
		echo "This should be 524288 or bigger if You have E-sync, if You have lower then You have to install it." ;
		echo "Google it!" ;
		echo "Oke I run the commnad for You check the output below!" ;
		ulimit -Hn ;
		echo "Your output for command is up ^. Don't forger the HdajackRetask!" ;
		
		
		echo "You can choose one of the Desktop enviroments or i3 window manager below or you can install on manualy."

		select yn in "Xfce4" "KDE" "Gnome" "LXDE" "i3" "Deepin" "instantWM" "Nothing"; do

    		case $yn in

       		 Xfce4 )  sudo pacman --noconfirm -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter ;
		 	  sudo systemctl enable lightdm ;
		 	  echo "Oke your Xfce4 Desktop will run next time!" ;
		 		break;;

        	KDE )    sudo pacman --noconfirm -S plasma kde-applications sddm sddm-kcm ;
			 sudo systemctl enable sddm ;
			 echo "Oke Your Kde Destop is done and next time will run" ;
			 echo "Don't forgget he can be buggie with some nvidia cards and/or drivers!" ;
				break;;

       		 Gnome ) sudo pacman --noconfirm -S gnome gdm ;
		 	 sudo systemctl enable gdm;
			 echo "Oke. Your Gnome is Ready to go, but You have to reboot before." ;
		 		break;;

        	LXDE ) sudo pacman --noconfirm -S lxde-common lxsession lightdm lightdm-gkt-greeter ;
		       sudo systemctl enable lightdm ;
		       echo "Your LXDE Desktop is muy byene. Reboot to try it!" ;
				break;;

        	i3 ) sudo pacman --noconfirm -S i3 dmenu lightdm lightdm-gtk-greeter ;
		     sudo systemctl enable lightdm ;
		     echo "Your i3 Window Manager Is Reade reboot to use it!" ;
			break;;

                 Deepin ) sudo pacman --noconfirm -S deepin lightdm lightdm-gtk-greeter ;
                          sudo systemctl enable lightdm ;
                          echo "Your Deepin Desktop is ready to roll so rock it a reboot" ;
                          break;; 
		instantWM )
			   cd ;
			   git clone --depth=1 https://github.com/instantOS/instantWM.git ;
  			   cd instantWM ;
		    	   ./build.sh ;
			   cd ;
			   sudo rm -r instantWM ;
			   sudo pacman --noconfirm -S lightdm lightdm-gkt-greeter ;
		           sudo systemctl enable lightdm ;
			   echo "Done" ;

       		 Nothing ) echo "Don't install one"; break;


    esac

done

		
	echo "You are close to end all things do you want to set your nvidia car to run? If You don't next reboot Your Intel Graphics car will run!" 

select yn in "Yes" "No"; do

    case $yn in

        Yes )	sudo systemctl enable optimus-manager ;
                sudo systemctl start optimus-manager ;
                optimus-manager --set-startup nvidia ;
        	    echo "Oke. Good luck" ;
		          break ;;

        No ) 
		        echo "Ok. My job is done here" ; 
		        break;

    esac

done
	
		
		
		
		
#End Of Script
		break;;

        No ) 

		echo "Oke. Have a nice day!" ;
		break;



    esac



done

