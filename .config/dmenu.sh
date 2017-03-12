#!/bin/bash

COL0=$(xrdb -q | grep color0: | awk '{print $2}')
COL1=$(xrdb -q | grep color1: | awk '{print $2}')

dmenu_recent -y 350 -h 25 -x 300 -w 800 -o 0.75 -fn "Ubuntu-12:normal" -nb $COL0 -nf '#aaa' -sb $COL1 -sf $COL0
