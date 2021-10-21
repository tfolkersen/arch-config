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

mkdir /mnt/arch-config
cp -r * /mnt/arch-config
arch-chroot /mnt/arch-config
