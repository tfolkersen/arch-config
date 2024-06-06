trunc() {
    truncScale=$((60 * 60))
    echo $(("$truncScale" * ("$1" / "$truncScale")))
}

maxDelta=$((2 * 60))

currentTime=$(date +%s)
truncTime=$(trunc "$currentTime")
delta=$(("$currentTime" - "$truncTime"))

if [[ "$delta" -le "$maxDelta" || "$delta" -ge $((60 * 60 - "$maxDelta")) ]] ; then
    echo "██████████████ Stand up █ Walk █ Tidy desk █ Reconsider task ██████████████"
fi
