#!/bin/bash

a="$(cat $HOME/images/count.txt)"

echo $a

  
   wpg -s $a
   killall -USR1 termite

   let a=a+1

   if [ -f $HOME/images/$a ]; then

   sed --follow-symlinks -i 1d $HOME/images/count.txt
   echo $a >> $HOME/images/count.txt

   else
   	echo "There is no file $a"
	sed --follow-symlinks -i 1d $HOME/images/count.txt
	echo 1 >> $HOME/images/count.txt
   fi


   

