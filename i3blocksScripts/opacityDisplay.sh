x=$(awk '/^ *background_opacity +[0-9]+(\.[0-9]*)? *$/{print $2; exit}' ~/.config/kitty/kitty.conf)
echo ░$x░
