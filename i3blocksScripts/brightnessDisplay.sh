func() {
    let b=$(cat /sys/class/backlight/amdgpu_bl1/brightness)
    echo $b
}

func
