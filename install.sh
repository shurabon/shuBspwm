    #!/bin/bash

# для автологина  sudo systemctl enable xlogin@user (должен быть установлен xlogin-git). 
# для автостарта иксов добавить [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx в нижнюю часть ~/.bash_profile  
# установка необходимых компонентов 



echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) yaourt -S $(cat pkglist) --noconfirm; break;;
        No ) echo "No is selected"; break;;
    esac
done


#yaourt -S $(cat pkglist)

while read i; 
 do 
   if [ -d $HOME$i ]; then
      echo "Directory $i is exist"
   else
      mkdir $HOME$i
      echo "The directory $i has been done"
   fi    
 done < dir.txt


while read i; 
 do 
   if [ -f $HOME$i ]; then
      echo "The file $i is exist and will be delete"
      rm -f $HOME$i
      ln -s $PWD$i $HOME$i
   else
      echo "The file $ is NOT exist and will be created symbolic link"
      ln -s $PWD$i $HOME$i
   fi    
 done < dotfiles.txt

 sudo chmod +x ~/.config/bspwm/bspwmrc
 sudo chmod +x ~/.config/sxhkd/sxhkdrc
 sudo chmod +x ~/.config/polybar/launch.sh

 for i in $(ls $PWD/usr/bin/); do
   sudo rm -f /usr/bin/$i  
   sudo ln -s $PWD/usr/bin/$i /usr/bin/$i 
   echo "file $i has been created in /usr/bin"
 done

 for i in $(ls $PWD/images/); do
   sudo rm -f $HOME/images/$i  
   sudo ln -s $PWD/images/$i $HOME/images/$i
   wpg -a  $PWD/images/$i
 done




