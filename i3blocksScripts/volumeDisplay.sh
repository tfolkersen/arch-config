func() {
    local m=$(awk '/off/ { print $7;exit; }' <(amixer -M sget Headphone))
    local vol=$(awk -F"[][]" '/dB/ { print $2;exit; }' <(amixer -M sget Headphone))

    if [ "$m" == "[off]" ];
    then
        echo "["$vol"]"
    else
        echo " "$vol" "
    fi
}

func
