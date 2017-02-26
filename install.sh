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
      echo "Директория $i существует"
   else
      mkdir $HOME$i
   fi    
 done < dir.txt


while read i; 
 do 
   if [ -f $HOME$i ]; then
      rm -f $HOME$i
      ln -s $PWD$i $HOME$i
   else
      ln -s $PWD$i $HOME$i
   fi    
 done < dotfiles.txt

 sudo chmod +x ~/.config/bspwm/bspwmrc
 sudo chmod +x ~/.config/sxhkd/sxhkdrc
 sudo chmod +x ~/.config/polybar/launch.sh

 for i in $(ls $PWD/usr/bin/); do
   sudo rm -f /usr/bin/$i  
   sudo ln -s $PWD/usr/bin/$i /usr/bin/$i 
 done

 for i in $(ls $PWD/images/); do
   sudo rm -f $HOME/images/$i  
   sudo ln -s $PWD/images/$i $HOME/images/$i
   wpg -a  $PWD/images/$i
 done




