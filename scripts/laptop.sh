# kitty font size 12 --> 10.5
sed -i "s/^ *font_size \+[0-9]\+\(\.[0-9]*\)\? *$/font_size 10.5/g" ~/.config/kitty/kitty.conf

# i3 font size 12 --> 10
sed -i "s/^ *font *pango:jetbrains *mono *medium *[0-9]\+\(\.[0-9]*\)\? *$/font pango:jetbrains mono medium 10/g" ~/.config/i3/config

# change dunst font size 14 --> 12
sed -i "s/^ *font *= *JetBrains *Mono *[0-9]\+\(\.[0-9]\*\)\? *$/    font = JetBrains  Mono 12/g" ~/.config/dunst/dunstrc

# change DPI to 227
echo "Xft.dpi: 227" | xrdb -merge

# switch displays
xrandr --output eDP-1 --mode 2560x1600 --rate 60 --primary --output HDMI-1 --off

# reload wallpaper
sh ~/.fehbg

# restart i3
i3-msg restart

# reload kitty
pkill --signal SIGUSR1 kitty

# restart dunst
killall dunst
dunst &

# display notification
notify-send -t 6000 "Switched output to laptop"

# restart picom
killall picom
sleep 1
picom &

