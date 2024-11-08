#!/bin/bash

export XDG_RUNTIME_DIR=/tmp/.xdg-runtime
export WAYLAND_DISPLAY=wayland-1


#Generate ssh host keys if they don't exist
## Persisted via _data bind after first boot
if [ ! -f /etc/ssh/ssh_host_rsa_key ]
then 
	ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N '';
fi
if [ ! -f /etc/ssh/ssh_host_ecdsa_key ]
then
	ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '';
fi
if [ ! -f /etc/ssh/ssh_host_ed25519_key ];
then
	ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N '';
fi
chown -R ${MYUSERNAME}:${MYUSERNAME} /home/${MYUSERNAME}/.ssh
chown -R ${MYUSERNAME}:${MYUSERNAME} /home/${MYUSERNAME}/git-repos
chown -R ${MYUSERNAME}:${MYUSERNAME} /home/${MYUSERNAME}/.mozilla
chown -R ${MYUSERNAME}:${MYUSERNAME} /home/${MYUSERNAME}/.gitconfig
chmod 700 /home/${MYUSERNAME}/.ssh
chmod 600 /home/${MYUSERNAME}/.ssh/id_rsa
chmod 644 /home/${MYUSERNAME}/.ssh/id_rsa.pub
chmod 600 /home/${MYUSERNAME}/.ssh/auhorized_keys
chmod 770 /home/${MYUSERNAME}/{.mozilla,git-repos,.gitconfig}

echo "Starting SSH Server..."
/usr/sbin/sshd

echo "My Docker user: ${MYUSERNAME}"
echo "My Docker pw: ${PASSWORD}"
echo "${MYUSERNAME}:${PASSWORD}" | chpasswd
unset PASSWORD


echo "Start sway..."
sudo -E -u ${MYUSERNAME} sway &
sleep 5
echo "Start wayvnc..."
sudo -E -u ${MYUSERNAME} wayvnc 0.0.0.0 5901 -r /$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY
