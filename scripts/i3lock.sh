#!/bin/sh

BLANK='#00000000'
CLEAR='#00000055'
DEFAULT='#4fc3f7cc'
TEXT='#ffffffff'
WRONG='#ef5350cc'
VERIFYING='#26c6dacc'
BG="$HOME/pCloudDrive/Wallpapers/lock-screen2.jpg"

i3lock \
--insidever-color=$CLEAR        \
--ringver-color=$VERIFYING      \
\
--insidewrong-color=$CLEAR      \
--ringwrong-color=$WRONG        \
\
--inside-color=$CLEAR           \
--ring-color=$DEFAULT           \
--line-color=$BLANK             \
--separator-color=$DEFAULT      \
\
--verif-color=$TEXT             \
--wrong-color=$TEXT             \
--time-color=$TEXT              \
--date-color=$TEXT              \
--layout-color=$TEXT            \
--keyhl-color=$WRONG            \
--bshl-color=$WRONG             \
\
--clock                         \
--bar-indicator                 \
--bar-direction=1               \
--bar-pos="0:h"                 \
--bar-max-height=80             \
--bar-base-width=4              \
--bar-step=25                   \
--bar-periodic-step=15          \
--bar-color=$CLEAR              \
--time-str="%H:%M:%S"           \
--date-str="%A, %Y-%m-%d"       \
--time-size=72                  \
--date-size=20                  \
--verif-size=16                 \
--wrong-size=16                 \
--image="$BG"
