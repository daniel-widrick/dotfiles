FROM ubuntu:latest

#Config
ARG USERNAME=lvlint67
ARG PASSWORD=youcantguessitnerd

#Install SWAY / Wayland /VNC
RUN apt update -y && apt upgrade -y
RUN apt install -y ubuntu-standard
RUN apt install -y sway xwayland dbus-x11 wayvnc libvncserver1 sudo passwd swayidle swaylock

#Just the baseline stuff
RUN apt install -y iproute2 iputils-ping tzdata
#Local Time!
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && dpkg-reconfigure -f noninteractive tzdata


#Install the nice to have packages
RUN apt install -y kitty openssl bind9-utils net-tools git apt-file file \
    ripgrep build-essential gcc make

ENV SWAY_CONFIG_FILE=~/.config/sway/config
ENV SWAY_LAYOUT=grid
ENV SWAY_FONT_FAMILY=Monospace
ENV WLR_BACKENDS=headless
ENV DISPLAY=:1


RUN useradd -m $USERNAME --shell /bin/bash  && echo "$USERNAME:${PASSWORD}" | chpasswd
RUN usermod -aG sudo $USERNAME


USER $USERNAME
ENV HOME=/home/$USERNAME
WORKDIR /home/$USERNAME
ENV XDG_RUNTIME_DIR=/home/$USERNAME/.xdg-runtime
ENV WAYLAND_DISPLAY=wayland-1
RUN mkdir -p $XDG_RUNTIME_DIR && chown $USERNAME:$USERNAME $XDG_RUNTIME_DIR && chmod 700 $XDG_RUNTIME_DIR
RUN mkdir ./.config
COPY .config ./.config/
RUN mkdir /home/$USERNAME/Downloads
COPY ./anime* /home/$USERNAME/Downloads

ENV USERNAME=$USERNAME
ENV XDG_RUNTIME_DIR=/home/$USERNAME/.xdg-runtime

#CMD /bin/bash
CMD /bin/bash -c "sudo -u $USERNAME /bin/bash -c export XDG_RUNTIME_DIR=/home/$USERNAME/.xdg-runtime; sway & sleep 5 & wayvnc 0.0.0.0 5901 -r /$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"