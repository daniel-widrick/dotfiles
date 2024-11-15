timedatectl set-timezone America/New_York

pacman -Sy gptfdisk --noconfirm
sgdisk --zap-all /dev/sda

#Remove any old ubuntu lvm installs
lvscan | awk '{print $2}' | sed "s/'//g" | xargs lvchange -an



#Wipe Partition Table of SDA
echo 'g\nw\n' | fdisk /dev/sda

#Create 2G /boot partition
echo 'n\n1\n2048\n+2G\ny\nw\n' | fdisk /dev/sda
echo 't\n1\n1\nw\n' | fdisk /dev/sda



#Create 4G /swap
echo 'n\n2\n\n+4G\nw\n' | fdisk /dev/sda

#Fill rest of drive with /root
echo 'n\n\n\n\nw\n' | fdisk /dev/sda
echo 't\n3\n19\nw\n' | fdisk /dev/sda

#Format Partitions
mkfs.fat -F32 /dev/sda1
mkfs.ext4 -F /dev/sda3

#Mount root system
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

#Install essentials
pacstrap -K /mnt base linux linux-firmware
genfstab -U /mnt > /mnt/etc/fstab

mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys
mount --bind /run /mnt/run
