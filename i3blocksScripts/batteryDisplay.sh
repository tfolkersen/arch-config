func() {
    local d=$(awk '/Discharging/ { print $4; exit }' <(acpi))

    local b=$(awk '/Battery/ { print $4; exit }' <(acpi))

    if [ $d ];
    then
        d=$(echo $d | sed 's/,//g')
        echo $d
    else
        echo '['$b']'
    fi

}

func
