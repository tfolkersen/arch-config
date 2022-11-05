func() {
    let b=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
    echo $b
}

func
