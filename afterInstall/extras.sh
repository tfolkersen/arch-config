let BUILDCORES=10
let LAPTOP=0

#Install clementine
git clone https://aur.archlinux.org/clementine.git
sed -i "s/cmake --build build/cmake --build build -j $BUILDCORES /g" clementine/PKGBUILD
makepkg -D clementine -si --noconfirm

if [ $LAPTOP == 1 ]; then
    git clone https://aur.archlinux.org/auto-cpufreq.git
    makepkg -D auto-cpufreq -si --noconfirm

    git clone https://aur.archlinux.org/mons.git
    makepkg -D mons -si --noconfirm

    sudo systemctl enable --now auto-cpufreq 
fi

