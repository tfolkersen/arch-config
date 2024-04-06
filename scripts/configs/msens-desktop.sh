sed -i "s/^xinput --set-prop \"Glorious Model D\" \"Coordinate Transformation Matrix\" .*$/xinput --set-prop \"Glorious Model D\" \"Coordinate Transformation Matrix\" 0.5 0 0 0 0.5 0 0 0 1/g" ~/.xinputStuff
sh ~/.xinputStuff
