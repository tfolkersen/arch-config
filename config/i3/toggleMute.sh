func() {
    local m=$(awk '/off/ { print $6;exit; }' <(amixer -M sget Master))
    local vol=$(awk -F"[][]" '/dB/ { print $2;exit; }' <(amixer -M sget Master))

    if [ "$m" == "[off]" ];
    then
        amixer set Master toggle && pkill -RTMIN+2 i3blocks
        amixer set Headphone toggle && pkill -RTMIN+2 i3blocks
    else
        amixer set Headphone toggle && pkill -RTMIN+2 i3blocks
    fi
}

func
