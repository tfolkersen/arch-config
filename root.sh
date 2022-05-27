#!/bin/bash

hostname="hostname"

timedatectl set-ntp true

pacman -S --noconfirm rsync reflector
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm
pacman -S --noconfirm vim man git gcc python3 make cmake sed unzip neofetch openssh

echo $hostname > /etc/hostname

sed -i "s/#en_US/en_US/g" /etc/locale.gen
ln -fs /usr/share/zoneinfo/Canada/Mountain /etc/localtime
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LANGUAGE=en_US" >> /etc/locale.conf
locale-gen

timedatectl set-local-rtc true
timedatectl set-ntp true

pacman -S --noconfirm archlinux-keyring

pacman -S --noconfirm alsa-utils mesa\
 xorg-server xorg-xinit xorg-xinput numlockx\
 i3-gaps i3status dmenu thunar dunst feh terminator kitty picom ranger okular scrot i3blocks lxappearance\
 pinta ueberzug tumbler ffmpegthumbnailer\
 noto-fonts noto-fonts-cjk terminus-font ttf-liberation ttf-roboto ttf-roboto-mono ttf-jetbrains-mono\
 firefox vlc xfce4 xfce4-goodies xsel sxhkd pavucontrol pulseaudio dkms linux-headers clementine

pacman -S --noconfirm texlive-most texlive-lang biber

#pacman -S --noconfirm xorg-bdftopcf xorg-mkfontscale

cp numlockTTY.sh /usr/local/bin/numlockTTY
chmod +x /usr/local/bin/numlockTTY
cp numlockTTY.service /etc/systemd/system/numlockTTY.service
systemctl enable numlockTTY
systemctl start numlockTTY

cp evdev /usr/share/X11/xkb/keycodes/evdev
mkdir -p /etc/X11/xorg.conf.d
cp cursor-20.conf /etc/X11/xorg.conf.d

cp alsa-base.conf /etc/modprobe.d/alsa-base.conf

mkdir -p /usr/share/i3blocksScripts
cp i3blocksScripts/* /usr/share/i3blocksScripts
chmod +x /usr/share/i3blocksScripts/*

echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Defaults !tty_tickets" >> /etc/sudoers

#mkdir /var/shared
mkdir /home/Shared

groupadd shared

while read user
do
	useradd -m -G wheel $user
	usermod -a -G shared $user
done < users

git clone https://github.com/grassmunk/Chicago95.git

mkdir -p /usr/share/themes/
mkdir -p /usr/share/icons
cp -r Chicago95/Theme/Chicago95 /usr/share/themes
cp -r Chicago95/Icons/* /usr/share/icons
cp -r Chicago95/Cursors/* /usr/share/icons

mkdir -p /usr/share/fonts/truetype
cp -r Chicago95/Fonts/* /usr/share/fonts/truetype
fc-cache -f -v


i=0
while read user
do
	home=/home/$user

	if [ $i == 0 ]
	then
		home=/$user
	fi

	cp bashrc $home/.bashrc

	mkdir $home/.vim
	cp -r colors $home/.vim/colors

	cp i3status.conf $home/.i3status.conf

	cp vimrc $home/.vimrc

	cp xinitrc $home/.xinitrc
	chmod +x $home/.xinitrc

	cp xinputStuff $home/.xinputStuff
	chmod +x $home/.xinputStuff

	cp xfceStuff $home/.xfceStuff
	chmod +x $home/.xfceStuff

	cp -r config $home/.config

    cp gtkrc-2.0 $home/.gtkrc-2.0
	#find $home/.config -type f -exec sed -i "s/USERNAMEGOESHERE/"$user"/g" {} +
	find $home -type f -exec sed -i "s/USERNAMEGOESHERE/"$user"/g" {} +

	mkdir $home/Desktop
	mkdir $home/Downloads
	mkdir $home/Documents

	mkdir -p $home/.local/share/sounds
	cp -r Chicago95/sounds/Chicago95 $home/.local/share/sounds

    cp Xresources $home/.Xresources
	

	#### Virtualbox
	#cp resolution.sh $home
	#chmod +x $home/resolution.sh


	ln -fs /home/Shared $home/shared

	chown -R $user $home
    i=$(($i + 1))
done < users

#mv Chicago95 /var/shared
rm -rf Chicago95
chgrp -R shared /home/Shared
chmod -R 2775 /home/Shared

