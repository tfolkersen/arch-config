# kitty font size 10.5 --> 12
sed -i "s/^ *font_size \+[0-9]\+\(\.[0-9]*\)\? *$/font_size 12/g" ~/.config/kitty/kitty.conf

# i3 font size 10 --> 12
sed -i "s/^ *font *pango:jetbrains *mono *medium *[0-9]\+\(\.[0-9]*\)\? *$/font pango:jetbrains mono medium 12/g" ~/.config/i3/config

# change dunst font size 12 --> 14
sed -i "s/^ *font *= *JetBrains *Mono *[0-9]\+\(\.[0-9]\*\)\? *$/    font = JetBrains  Mono 14/g" ~/.config/dunst/dunstrc

# change DPI to 96
echo "Xft.dpi: 96" | xrdb -merge


# switch displays
xrandr --output HDMI-1 --mode 1920x1080 --rate 60 --primary --output eDP-1 --off 

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
notify-send -t 6000 "Switched output to HDMI"

# restart picom
killall picom
sleep 1
picom &
