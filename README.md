# arch-config
### Configures Arch Linux after barebones install
TODO:
* Add LUKS configuration steps
* Make my personal machine configs optional (i.e. ```alsa-base-laptop.conf```, ```cursor-20.conf```)

#### Usage
First install barebones Arch Linux instance:
* Create partitions with ```fdisk``` and then format them. If using LUKS, create LUKS containers
* Mount partitions appropriately
* Install basic system using ```pacstrap```
* Run ```genfstab -U /mnt >> /mnt/etc/fstab```
* Run ```chroot /mnt```
* Set root password
* Install ```networkmanager``` and enable it
* Install ```grub```, ```efibootmgr```, ```ntfs-3g```, and ```os-prober```
* Edit ```/etc/default/grub``` to enable os-prober
* Install grub with ```grub-install```
* Run ```grub-mkconfig```
* Reboot

Clone this repository, edit ```users``` and ```root.sh``` as desired (i.e. to configure laptop features, then run ```root.sh``` as root
