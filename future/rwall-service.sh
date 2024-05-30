#!/bin/bash
#Check time since last wallpaper was set (truncate both dates to last hour)
trunc() {
    local tscale=$((60 * 60))

    echo $(( "$tscale" * ("$1" / "$tscale") ))
}

last=$(stat --printf=%Y $HOME/.fehbg)
last=$(trunc "$last")

current=$(date +%s)
current=$(trunc "$current")

delta=$(("$current" - "$last"))

if [[ "$delta" -ge 1 ]] ; then
    DISPLAY=:0 feh --bg-fill -z $HOME/shared/wall/green
fi
