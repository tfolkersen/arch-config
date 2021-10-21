mkfs.ext4 /dev/sda1
mkswap /dev/sda2
swapon /dev/sda2
mkfs.ext4 /dev/sda3
mkfs.ext4 /dev/sda4
mount /dev/sda3 /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mount /dev/sda4 /mnt/home

pacstrap /mnt base base-devel linux linux-firmware grub networkmanager vim man

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt

pacman -S --noconfirm virtualbox-guest-utils git
systemctl enable NetworkManager
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

sh root.sh

echo "Change root's password by typing \"passwd\""
echo "Then change user1's password by typing \"passwd user1\""
echo "Then restart by typing \"shutdown -r now\""

