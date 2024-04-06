#!/bin/bash

#       Instructions
#
# Edit variables at top of: root.sh, users, afterInstall/extras.sh
# Run as root after installing base system
#
#
# users file must have root at the top



hostname="hostname"
let LAPTOP=0
let TYPESETTING=0

timedatectl set-ntp true

pacman -S --noconfirm rsync reflector
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -S --noconfirm archlinux-keyring

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

if [ $LAPTOP == 1 ]; then
    sed -i "s/##//g" config/i3blocks/config
    sed -i "s/##LAPTOP##//g" xinputStuff
    sed -i "s/!!LAPTOP!!//g" Xresources
    sed -i "s/##LAPTOP##//g" config/i3blocks/config

    # laptop mouse sensitivity
    sed -i "s/^xinput --set-prop \"Glorious Model D\" \"Coordinate Transformation Matrix\" .*$/xinput --set-prop \"Glorious Model D\" \"Coordinate Transformation Matrix\" 0.75 0 0 0 0.75 0 0 0 1/g" xinputStuff

    cp alsa-base-laptop.conf /etc/modprobe.d/alsa-base.conf

    # i3 run laptop xmodmap
    sed -i "s/^exec xmodmap \~\/scripts\/configs\/xmKeyboard/exec xmodmap \~\/scripts\/configs\/xmLaptop/g" config/i3/config

    
    # i3 font size for laptop
    sed -i "s/^ *font *pango:jetbrains *mono *medium *[0-9]\+\(\.[0-9]*\)\? *$/font pango:jetbrains mono medium 10/g" config/i3/config

    # dunst font size for laptop
    sed -i "s/^ *font *= *JetBrains *Mono *[0-9]\+\(\.[0-9]\*\)\? *$/    font = JetBrains  Mono 12/g" config/dunst/dunstrc

    # kitty font size for laptop
    sed -i "s/^ *font_size \+[0-9]\+\(\.[0-9]*\)\? *$/font_size 10.5/g" config/kitty/kitty.conf
else
    sed -i "s/##DESKTOP##//g" xinputStuff
    sed -i "s/!!DESKTOP!!//g" Xresources
    cp alsa-base-desktop.conf /etc/modprobe.d/alsa-base.conf
fi


pacman -S --noconfirm alsa-utils mesa\
 xorg-server xorg-xinit xorg-xinput numlockx\
 i3-gaps i3status dmenu thunar dunst feh terminator kitty picom ranger okular scrot i3blocks lxappearance\
 pinta ueberzug tumbler ffmpegthumbnailer\
 noto-fonts noto-fonts-cjk terminus-font ttf-liberation ttf-roboto ttf-roboto-mono ttf-jetbrains-mono\
 firefox vlc xfce4 xfce4-goodies xsel sxhkd pavucontrol pulseaudio dkms linux-headers gst-plugins-bad ripgrep\
 ethtool dhcpcd xorg-xmodmap

if [ $TYPESETTING == 1 ]; then
    pacman -S --noconfirm texlive-most texlive-lang biber
fi

#pacman -S --noconfirm xorg-bdftopcf xorg-mkfontscale

cp numlockTTY.sh /usr/local/bin/numlockTTY
chmod +x /usr/local/bin/numlockTTY
cp numlockTTY.service /etc/systemd/system/numlockTTY.service
systemctl enable numlockTTY
systemctl start numlockTTY

cp evdev /usr/share/X11/xkb/keycodes/evdev
mkdir -p /etc/X11/xorg.conf.d
        # ||                                 ||
        # vv Maybe use for nvidia driver?    vv
#cp cursor-20.conf /etc/X11/xorg.conf.d


mkdir -p /usr/share/i3blocksScripts
cp -r i3blocksScripts /usr/share
make -C /usr/share/i3blocksScripts
chmod +x /usr/share/i3blocksScripts/*.sh

echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Defaults !tty_tickets" >> /etc/sudoers

#mkdir /var/shared
mkdir /home/Shared

groupadd shared
groupadd video

while read user
do
	useradd -m -G wheel $user
	usermod -a -G shared $user
    usermod -a -G video $user
done < users

git clone https://github.com/grassmunk/Chicago95.git
git clone https://github.com/tfolkersen/misc.git

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
	
	cp -r scripts $home/scripts

    ## Install misc programs
    mkdir $home/scripts/programs
    cp -r misc/dvorak $home/scripts/programs
    cp -r misc/sched $home/scripts/programs

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


##### LAPTOP
if [ $LAPTOP == 1 ]; then
    pacman -S --no-confirm bluez bluez-utils powertop acpi acpilight
    #pacman -S --no-confirm xf86-input-synaptics
    systemctl enable bluetooth
    systemctl start bluetooth
fi

#Downgrade ncurses, add to IgnorePkg
pacman --noconfirm -U https://archive.archlinux.org/packages/n/ncurses/ncurses-6.4-1-x86_64.pkg.tar.zst
line=$(grep "^IgnorePkg *=" /etc/pacman.conf)
sed -i "s/^IgnorePkg *=.*$/$line ncurses/g" /etc/pacman.conf

# change nvim theme for root user (blue status/tab)
sed -i "s/^ *\[\"statusColor\"\] *=.*$/    \[\"statusColor\"\] = \"#0040ff\",/g" /root/.config/nvim/colors/elise.lua

cp -r afterInstall /home/Shared


