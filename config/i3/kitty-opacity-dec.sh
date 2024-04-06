x=$(awk '/^ *background_opacity +[0-9]+(\.[0-9]*)? *$/{x = $2-0.01; if (x < 0) x = 0; end; print x; exit}' ~/.config/kitty/kitty.conf)
sed -i "s/^ *background_opacity \+[0-9]\+\(\.[0-9]*\)\? *$/background_opacity $x/g" ~/.config/kitty/kitty.conf
pkill --signal SIGUSR1 kitty
pkill -RTMIN+4 i3blocks

