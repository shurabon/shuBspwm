    #!/bin/bash

# для автологина  sudo systemctl enable xlogin@user (должен быть установлен xlogin-git). 
# для автостарта иксов добавить [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx в нижнюю часть ~/.bash_profile  
# установка необходимых компонентов 

sudo pacman -S bspwm sxhkd-git compton 
yaourt -S lemonbar-xft-git ttf-font-awesome dmenu2

# acpi compton 

#mkdir $HOME/.config/bspwm/panel
while read i; 
 do 
   if [ -f $HOME$i ]; then
      rm -f $HOME$i
      ln -s $PWD$i $HOME$i
   else
      ln -s $PWD$i $HOME$i
   fi    
 done < dotfiles.txt




