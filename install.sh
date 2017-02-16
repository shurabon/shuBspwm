    #!/bin/bash

# для автологина  sudo systemctl enable xlogin@user (должен быть установлен xlogin-git). 
# для автостарта иксов добавить [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx в нижнюю часть ~/.bash_profile  
# установка необходимых компонентов 

#sudo pacman -S compton 
#yaourt -S bspwm-git sxhkd-git lemonbar-xft-git ttf-font-awesome dmenu2 neofetch-git --noconfirm

echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Yes is selected"; break;;
        No ) echo "No is selected"; break;;
    esac
done


#yaourt -S $(cat pkglist)

while read i; 
 do 
   if [ -d $HOME$i ]; then
      echo "Директория $i существует"
   else
      mkdir $HOME$i
   fi    
 done < dir.txt




# acpi compton 

while read i; 
 do 
   if [ -f $HOME$i ]; then
      rm -f $HOME$i
      ln -s $PWD$i $HOME$i
   else
      ln -s $PWD$i $HOME$i
   fi    
 done < dotfiles.txt




