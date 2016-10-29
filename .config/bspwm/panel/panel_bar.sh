#! /bin/bash
#
# Example panel for lemonbar

#~/.config/bspwm/panel_colors.sh

PADDING="  "
PADDING2=" "

# set the u - underline or o - outline
UOLINE=u



COLOR_DEFAULT_FG="#BFa7a5a5"
COLOR_DEFAULT_BG="#BF000000"
COLOR_MONITOR_FG="#BF8dbcdf"
COLOR_MONITOR_BG="#BF000000"
COLOR_FOCUSED_MONITOR_FG="#BFb1d0e8"
COLOR_FOCUSED_MONITOR_BG="#BF144b6c"
COLOR_FREE_FG="#BFffffff"
COLOR_FREE_BG="#BF000000"
COLOR_FOCUSED_FREE_FG="#BFffffff"
COLOR_FOCUSED_FREE_BG="#B3000000"
COLOR_OCCUPIED_FG="#BFFCAF3E"
COLOR_OCCUPIED_BG="#BF000000"
COLOR_FOCUSED_OCCUPIED_FG="#BFFCAF3E"
COLOR_FOCUSED_OCCUPIED_BG="#B3000000"
COLOR_URGENT_FG="#BFf15d66"
COLOR_URGENT_BG="#BF000000"
COLOR_FOCUSED_URGENT_FG="#BF501d1f"
COLOR_FOCUSED_URGENT_BG="#BF000000"
COLOR_STATE_FG="#BF89b09c"
COLOR_STATE_BG="#BF000000"
COLOR_TITLE_FG="#BFa8a2c0"
COLOR_TITLE_BG="#BF000000"
#COLOR_SYS_FG="#b1a57d"
#COLOR_SYS_BG="#BF000000"
COLOR_UL="#BFFCAF3E"

num_mon=$(bspc query -M | wc -l)



while read -r line ; do
	case $line in
		
		C*)
			# clock output
			clock="   %{F$COLOR_FREE_FG}%{B$COLOR_FREE_BG}${line#?}%{B-}%{F-}  "
			;;
		T*)
			# xtitle output
			title="%{F$COLOR_FREE_FG}%{B$COLOR_FREE_BG} ${line#?} %{B-}%{F-}"
			;;
		B*)
			# battery output
			bat="%{F$COLOR_FREE_FG}%{B$COLOR_FREE_BG}${line#?}%{B-}%{F-}"
			;;

		N*)
			# network output
			net="%{F$COLOR_FREE_FG}%{B$COLOR_FREE_BG}${line#?}%{B-}%{F-}  "
			;;
		W*)
			# bspwm's state
			wm=""
			IFS=':'
			set -- ${line#?}
			while [ $# -gt 0 ] ; do
				item=$1
				name=${item#?}
				case $item in
					[mM]*)
						[ $num_mon -lt 2 ] && shift && continue
						case $item in
							m*)
								# monitor
								FG=$COLOR_MONITOR_FG
								BG=$COLOR_MONITOR_BG
								;;
							M*)
								# focused monitor
								FG=$COLOR_FOCUSED_MONITOR_FG
								BG=$COLOR_FOCUSED_MONITOR_BG
								;;
						esac
						wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc monitor -f ${name}:}$PADDING${name}$PADDING%{A}%{B-}%{F-}"
						;;
					[fFoOuU]*)
						case $item in
							f*)
								# free desktop
								FG=$COLOR_FREE_FG
								BG=$COLOR_FREE_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}$PADDING${name}$PADDING%{A}%{B-}%{F-}"
								;;
							F*)
								# focused free desktop
								FG=$COLOR_FOCUSED_FREE_FG
								BG=$COLOR_FOCUSED_FREE_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}%{+$UOLINE}$PADDING${name}$PADDING%{-$UOLINE}%{A}%{B-}%{F-}"
								;;
							o*)
								# occupied desktop
								FG=$COLOR_OCCUPIED_FG
								BG=$COLOR_OCCUPIED_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}$PADDING${name}$PADDING%{A}%{B-}%{F-}"
								;;
							O*)
								# focused occupied desktop
								FG=$COLOR_FOCUSED_OCCUPIED_FG
								BG=$COLOR_FOCUSED_OCCUPIED_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}%{+$UOLINE}$PADDING${name}$PADDING%{-$UOLINE}%{A}%{B-}%{F-}"
								;;
							u*)
								# urgent desktop
								FG=$COLOR_URGENT_FG
								BG=$COLOR_URGENT_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}$PADDING${name}$PADDING%{A}%{B-}%{F-}"
								;;
							U*)
								# focused urgent desktop
								FG=$COLOR_FOCUSED_URGENT_FG
								BG=$COLOR_FOCUSED_URGENT_BG
								UL=$COLOR_UL
								wm="${wm}%{F${FG}}%{B${BG}}%{U$UL}%{A:bspc desktop -f ${name}:}%{+$UOLINE}$PADDING${name}$PADDING%{-$UOLINE}%{A}%{B-}%{F-}"
								;;
						esac
						#wm="${wm}%{F${FG}}%{B${BG}}%{u${4}}%{U$UL}%{A:bspc desktop -f ${name}:} ${name}%{A}%{B-}%{F-}"
						;;
					[LTG]*)
						# layout, state and flags
						#wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG}$PADDING${name}$PADDING%{B-}%{F-}"
						;;
				esac
				shift
			done
			;;
	esac
	printf "%s\n" "%{c}${wm}%{r}${net}${bat}${clock}"
done

# %{r}${sys}