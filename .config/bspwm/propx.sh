#! /bin/bash

PROP_X=`xprop |awk '/WM_CLASS/{print $4}'`; notify-send  -t 10000 -u normal "$PROP_X"
