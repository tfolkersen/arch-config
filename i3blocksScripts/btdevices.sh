out=""
wiimote=0
deviceList=$(bluetoothctl devices Connected)

grep -Fq "58:BD:A3:42:33:46" <<< "$deviceList"
result=$?

if [[ "$result" -eq 0 ]] ; then
    out="𝕎"
    wiimote=1
fi

deviceCount=0
while read -r device ; do
    if [[ -n "$device" ]] ; then
        deviceCount=$((deviceCount + 1))
    fi
done <<< "$deviceList"

deviceCount=$((deviceCount - wiimote))

if [[ $((deviceCount)) -gt 0 ]] ; then
    out="$out+$deviceCount"
fi

echo "$out"
