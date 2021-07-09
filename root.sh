hostname="hostname"

usernames=(root user1 user2)
#colors=("ff0000" "800000" "0000ff" "000080" "8000ff" "400080")
usercount=${#usernames[@]}



timedatectl set-ntp true

pacman -S --noconfirm rsync reflector
reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist
pacman -Syyu --noconfirm
pacman -S --noconfirm vim man git gcc python3 make cmake sed unzip neofetch

echo $hostname > /etc/hostname

sed -i "s/#en_US/en_US/g" /etc/locale.gen
ln -fs /usr/share/zoneinfo/Canada/Mountain /etc/localtime
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "LANGUAGE=en_US" >> /etc/locale.conf
locale-gen

timedatectl set-local-rtc true
timedatectl set-ntp true

pacman -S --noconfirm alsa-utils mesa\
 xorg-server xorg-xinit xorg-xinput numlockx\
 i3-gaps i3status dmenu thunar dunst feh terminator picom ranger okular scrot i3blocks\
 pinta ueberzug tumbler\
 noto-fonts noto-fonts-cjk terminus-font ttf-roboto ttf-roboto-mono ttf-jetbrains-mono\
 firefox vlc xfce4 xfce4-goodies

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

mkdir -p /usr/share/i3blocksScripts
cp i3blocksScripts/* /usr/share/i3blocksScripts
chmod +x /usr/share/i3blocksScripts/*

echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
echo "Defaults !tty_tickets" >> /etc/sudoers

mkdir /var/shared
groupadd shared

for user in ${usernames[@]}
do
	useradd -m -G wheel $user
	usermod -a -G shared $user
done

git clone https://github.com/grassmunk/Chicago95.git

mkdir -p /usr/share/themes/
mkdir -p /usr/share/icons
cp -r Chicago95/Theme/Chicago95 /usr/share/themes
cp -r Chicago95/Icons/* /usr/share/icons
cp -r Chicago95/Cursors/* /usr/share/icons

mkdir -p /usr/share/fonts/truetype
cp -r Chicago95/Fonts/* /usr/share/fonts/truetype
fc-cache -f -v


for i in $(seq 0 $(($usercount - 1)))
do
	user=${usernames[i]}
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

	mkdir $home/Desktop
	mkdir $home/Downloads
	mkdir $home/Documents

	mkdir -p $home/.local/share/sounds
	cp -r Chicago95/sounds/Chicago95 $home/.local/share/sounds
	

	#### Virtualbox
	#cp resolution.sh $home
	#chmod +x $home/resolution.sh

	#c1=${colors[2 * i]}
	#c2=${colors[2 * i + 1]}

	#sed -i "s/#0000ff/#"$c1"/g" $home/.config/i3/config
	#sed -i "s/#000080/#"$c2"/g" $home/.config/i3/config

	ln -fs /var/shared $home/shared

	chown -R $user $home
done

#mv Chicago95 /var/shared
rm -rf Chicago95
chgrp -R shared /var/shared
chmod -R 2775 /var/shared

