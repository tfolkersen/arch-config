ucount=$(w | grep -o "[0-9]\+ users" | grep -o "[0-9]\+")

if [[ "$ucount" -gt 1 ]] ; then
    echo "### $ucount ####"
fi

