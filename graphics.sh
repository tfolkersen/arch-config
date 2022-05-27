sudo -v

i=0
while read user
do
    home=/home/$user

	if [ $i == 0 ]
	then
		home=/$user
	fi
    sudo sed -i "s/154/155/g" $home/.xinputStuff


    i=$(($i + 1))
done < users

git clone https://aur.archlinux.org/nvidia-470xx-utils.git
git clone https://aur.archlinux.org/lib32-nvidia-470xx-utils.git

cd nvidia-470xx-utils
makepkg -si --noconfirm
cd ..

cd lib32-nvidia-470xx-utils
makepkg -si --noconfirm
cd ..

sudo mkdir -p /etc/X11/xorg.conf.d
sudo cp 20-nvidia.conf /etc/X11/xorg.conf.d

sudo sed -i "s/MODULES=()$/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/g" /etc/mkinitcpio.conf
sudo mkinitcpio -P linux
