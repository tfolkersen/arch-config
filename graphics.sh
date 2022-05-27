git clone https://aur.archlinux.org/nvidia-470xx-utils.git
git clone https://aur.archlinux.org/lib32-nvidia-470xx-utils.git

pacman -S --noconfirm dkms linux-headers

cd nvidia-470xx-utils
makepkg -si --noconfirm
cd ..

cd lib32-nvidia-470xx-utils
makepkg -si --noconfirm
cd ..




