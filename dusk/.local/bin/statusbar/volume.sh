#!/bin/bash
#COLOR=^c#FFF7D4^
COLOR=
if [[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@| grep -c "0.00") > 0 ]]; then
	echo "🔇"
	exit
fi
VOLUME=$(echo "`wpctl get-volume @DEFAULT_SINK@ | sed 's/.* //'`" '* 100' | bc | sed 's/\..*//')
if [[ -z $VOLUME ]]; then
	echo " %"
	exit
fi

VOLUME_BAR=""
(( $VOLUME > 01 )) && X=0 && VOLUME_BAR+="^C10^^r${X},14,2,02^"
(( $VOLUME > 14 )) && X=3 && VOLUME_BAR+="^C9^^r${X},12,2,04^"
(( $VOLUME > 28 )) && X=6 && VOLUME_BAR+="^C10^^r${X},10,2,06^"
(( $VOLUME > 42 )) && X=9 && VOLUME_BAR+="^C9^^r${X},08,2,08^"
(( $VOLUME > 56 )) && X=12 && VOLUME_BAR+="^C10^^r${X},06,2,10^"
(( $VOLUME > 70 )) && X=15 && VOLUME_BAR+="^C9^^r${X},04,2,12^"
(( $VOLUME > 84 )) && X=18 && VOLUME_BAR+="^C10^^r${X},02,2,14^"

VOLUME_BAR+="^d^^f$(($X+8))^"
echo "${VOLUME_BAR}${COLOR}${VOLUME}%^d^"
