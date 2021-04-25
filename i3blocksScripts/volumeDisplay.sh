func() {
	local m=$(awk '/off/ { print $7;exit; }' <(amixer -M sget Master))
	local vol=$(awk -F"[][]" '/dB/ { print $2;exit; }' <(amixer -M sget Master))

	if [ "$m" == "[off]" ];
	then
		vol="["$vol"]"
	fi
	echo $vol
}

func
