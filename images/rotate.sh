#!/bin/bash

a="$(cat $HOME/images/count.txt)"
#PRE=$(xrdb -q | grep color0: | awk '{print $2}' | sed 's/#//')
PRE=$(sed -n "/^background/p" ~/.config/polybar/config | awk '{print $3}' | sed "s/#cc//")
echo $PRE

  
   wpg -s $a
   killall -USR1 termite

   POS=$(xrdb -q | grep color0: | awk '{print $2}' | sed 's/#//')
   echo $POS
   sed --follow-symlinks -i "s/${PRE}/${POS}/g" $HOME/.config/polybar/config

   let a=a+1

   if [ -f $HOME/images/$a ]; then

   sed --follow-symlinks -i 1d $HOME/images/count.txt
   echo $a >> $HOME/images/count.txt

   else
   	echo "There is no file $a"
	sed --follow-symlinks -i 1d $HOME/images/count.txt
	echo 1 >> $HOME/images/count.txt
   fi


   

