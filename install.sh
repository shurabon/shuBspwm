    #!/bin/bash

# для автологина  sudo systemctl enable xlogin@user (должен быть установлен xlogin-git). 
# для автостарта иксов добавить [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx в нижнюю часть ~/.bash_profile  
# установка необходимых компонентов 
# для установки в virtualbox необходимы следующие пакеты: virtualbox guest utils, virtualbox guest iso, virtualbox guest modules arch


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
      echo "Dir $i is exist"
   else
      mkdir $HOME$i
   fi    
 done < $PWD/dir.txt

for i in $(cat $PWD/dotfiles.txt)
do
   if [ -f $HOME$i ]; then
      rm -f $HOME$i
      ln -s $PWD$i $HOME$i
      echo "ln $PWD$i $HOME$i is made"
   else
      echo $PWD$i $HOME$i 
   fi    
done

 sudo chmod +x ~/.config/bspwm/bspwmrc
 sudo chmod +x ~/.config/sxhkd/sxhkdrc
 sudo chmod +x ~/.config/polybar/launch.sh

 for i in $(ls $PWD/usr/bin/); do
   sudo rm -f /usr/bin/$i  
   sudo ln -s $PWD/usr/bin/$i /usr/bin/$i 
 done
 

echo "Do you wish to generate color schemes?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) for i in $(ls $PWD/images/); do sudo rm -f $HOME/images/$i;  sudo ln -s $PWD/images/$i $HOME/images/$i; wpg -a  $PWD/images/$i; done; break;;
        No ) echo "No is selected"; break;;
    esac
done





