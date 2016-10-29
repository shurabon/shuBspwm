#! /bin/bash

PANEL_FIFO=/tmp/panel-fifo
PANEL_HEIGHT=24
PANEL_FONT="Hack:size=9"
PANEL_WM_NAME=panel_p

if xdo id  "$PANEL_WM_NAME" > /dev/null ; then
	printf "%s\n" "The panel is already running." >&2
	exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

bspc config top_padding $PANEL_HEIGHT
bspc subscribe report > "$PANEL_FIFO" &
xtitle -sf 'T%s' > "$PANEL_FIFO" &
#clock -sf 'S%a %H:%M' > "$PANEL_FIFO" &

# clock
while true;
        do
                echo C$(date +"%H:%M");
        sleep 5;
done > "$PANEL_FIFO" &

# date
while true;
        do
                echo D$(date +'%d.%b.%a');
        sleep 5;
done > "$PANEL_FIFO" &

# ru/en
while true;
        do
                echo X$(setxkbmap -print | sed -n 's#xkb_symbols[^"]*"\([^"]*\)".*$#\1#p' | awk -F+ '{print $2}');
        sleep 1;
done > "$PANEL_FIFO" &

# battary
while true;
        do

                batpercent=`acpi -b | awk '{print $4}' | sed 's/%//g' | sed 's/,//g'`
                chgstate=`acpi -b | awk '{print $3}' | sed 's/,//g'`
                    if [ $chgstate == "Charging" ]
                      then
                        baticon=""
                    elif [ $batpercent -le 5 ]
                      then
                        baticon=""
                    elif [ $batpercent -gt 5 ] && [ $batpercent -le 25 ]
                      then
                        baticon=""
                    elif [ $batpercent -gt 25 ] && [ $batpercent -le 50 ]
                      then
                        baticon=""
                    elif [ $batpercent -gt 50 ] && [ $batpercent -le 75 ]
                      then
                        baticon=""
                    elif [ $batpercent -gt 75 ]
                      then
                        baticon=""
                    else
                      baticon=""
                    fi
                echo B$baticon;
        sleep 5;
done > "$PANEL_FIFO" &

# network
while true;
        do
        curethstat=`cat /sys/class/net/enp1s0f0/operstate`
        curwifistat=`cat /sys/class/net/wlp2s0/operstate`
        if [ "$curethstat" = "down" ] && [ "$curwifistat" = "down" ]
          then
          echo N""
        elif [ "$curethstat" = "up" ] && [ "$curwifistat" = "down" ]
          then
          echo N""
        elif [ "$curethstat" = "down" ] && [ "$curwifistat" = "up" ]
          then
          echo N""
        else
          echo N"  "

        fi
        sleep 5;
done > "$PANEL_FIFO" &


~/.config/bspwm/panel/panel_colors.sh

~/.config/bspwm/panel/panel_bar.sh < "$PANEL_FIFO" | lemonbar -f "fontawesome:size=14" -f "ubuntu:size=14" -g 1345x25+10+5 -p -u 2 -F "#a7a5a5" -B "#BF000000" | sh &


wid=$(xdo id "$PANEL_WM_NAME")
tries_left=20
while [ -z "$wid" "$tries_left" -gt 0 ] ; do
	sleep 0.05
	wid=$(xdo id "$PANEL_WM_NAME")
	tries_left=$((tries_left - 1))
done
[ -n "$wid" ] && xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

wait
