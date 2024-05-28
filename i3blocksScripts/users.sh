ucount=$(w | grep -o "[0-9]\+ user" | grep -o "[0-9]\+")

if [[ "$ucount" -gt 1 ]] ; then
    echo "### $ucount ####"
fi

