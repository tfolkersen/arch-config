if [[ ! -e $HOME/.i3btimer ]] ; then
    exit
fi

remaining=$(cat $HOME/.i3btimer)

if [[ "$remaining" -le -12 ]] || [[ -n "$1" ]] ; then
    rm $HOME/.i3btimer
    exit
fi

if [[ "$remaining" -ge 0 ]] ; then
    minutes=$(("$remaining" / 60))
    seconds=$(("$remaining" % 60))

    if [[ "${#seconds}" -lt 2 ]] ; then
        seconds="0""$seconds"
    fi

    echo "$minutes"":""$seconds"
else
    if [[ $((-"$remaining" % 2)) -eq 1 ]] ; then
        echo "████████████████████ TIMER END ████████████████████"
    else
        echo ""
    fi

    if [[ "$remaining" -eq -2 ]] then
        notify-send -u critical "TIMER END"

        if [[ -d $HOME/.timerSounds ]] ; then
            sounds=()
            while IFS="\n" read -ra fileName ; do
                if [[ -n "$fileName" ]] ; then
                    sounds+=("$fileName")
                fi

            done < <(ls $HOME/.timerSounds)

            soundCount="${#sounds[@]}"
            choiceIndex=$(("$RANDOM" % "$soundCount"))

            (mpv --really-quiet --volume=100 "$HOME/.timerSounds/${sounds[$choiceIndex]}" 2>&1 > /dev/null &)
        fi
    fi
fi

echo $((remaining - 1)) > $HOME/.i3btimer
