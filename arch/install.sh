ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime
hwclock --systohc
locale-gen
echo 'dev' > /etc/hostname
mkinitcpio -P
echo 'root:root' | chpasswd #TODO: Secret

#Install bootloader
pacman -Sy systemd --noconfirm
bootctl --path=/boot install
chmod 600 /boot/loader/random-seed

#Configure Boot
cat <<EOF > /boot/loader/entries/arch.conf
title   Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=/dev/sda3 rw
EOF

cat <<EOF > /boot/loader/loader.conf
timeout 3
default arch
EOF

cat <<EOF > /etc/systemd/network/20-wired.network
[Match]
Name=enp2s0

[Link]
RequiredForOnline=routable

[Network]
DHCP=yes
EOF


pacman -Sy openssh vim docker docker-compose sudo cronie git less --noconfirm
echo '%wheel ALL=(ALL:ALL) ALL' >> /etc/sudoers
useradd -m lvlint67
echo 'lvlint67:lvlint67' | chpasswd

usermod -aG wheel lvlint67
usermod -aG docker lvlint67

echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'Port 6722' >> /etc/ssh/sshd_config

systemctl enable systemd-networkd
systemctl enable sshd
systemctl enable systemd-resolved
systemctl enable cronie
systemctl enable docker

echo '5  5  *  *  2	root	/usr/bin/pacman -Syu --noconfirm' >> /etc/crontab
