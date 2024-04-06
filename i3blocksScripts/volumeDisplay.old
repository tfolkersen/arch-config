func() {
    local m=$(awk '/off/ { print $6;exit; }' <(amixer -M sget Master))
    local vol=$(awk -F"[][]" '/dB/ { print $2;exit; }' <(amixer -M sget Master))

    if [ "$m" == "[off]" ];
    then
        echo "["$vol"]"
    else
        echo " "$vol" "
    fi
}

func
