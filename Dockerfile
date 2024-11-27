#FROM ubuntu:latest
FROM ubuntu:rolling

#Config
ARG CACHE_URL
##Proxy apt through local apt cahce for faster builds
RUN bash -c "echo 'Acquire::http::Proxy \"${CACHE_URL}\";' > /etc/apt/apt.conf.d/01proxy"

#Install SWAY / Wayland /VNC / SSH
RUN apt update -y && apt upgrade -y
RUN apt install -y ubuntu-standard
RUN apt install -y sway xwayland dbus-x11 wayvnc libvncserver1 sudo passwd swayidle swaylock openssh-server wl-clipboard
#Configure SSH
COPY ./etc/sshd_config /etc/ssh/

#Install the nice to have packages
RUN apt install -y kitty openssl bind9-utils net-tools git apt-file file \
    ripgrep build-essential gcc make software-properties-common curl wget \
    tzdata iproute2 tidy
#Local Time!
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

#Install Neovim and firefox
#RUN add-apt-repository -y ppa:neovim-ppa/unstable 
RUN add-apt-repository -y ppa:mozillateam/ppa
COPY etc/mozillateamppa /etc/apt/preferences.d/
RUN sed -i "s/currentcodename/$(grep VERSION_CODENAME /etc/os-release | awk -F= '{print $2}')/" /etc/apt/preferences.d/mozillateamppa
##Force https sources to http for caching support
RUN find /etc/apt/sources.list /etc/apt/sources.list.d/ -type f -exec sed -Ei 's!https!http!g' {} \;
RUN apt update -y
#RUN apt install -y neovim 
RUN apt install -y firefox
RUN apt install -y npm

RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
    tar xzf nvim-linux64.tar.gz && \
    mv nvim-linux64 /usr/local/ && \
    ln -s /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim && \
    rm nvim-linux64.tar.gz

#Add DevLibraries
RUN apt install -y sqlite3
#Install Golang
RUN curl https://raw.githubusercontent.com/udhos/update-golang/refs/heads/master/update-golang.sh | bash
RUN ln -s /usr/local/go/bin/go /usr/local/bin/go
RUN ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

#Add an ssh server :: TODO: handle host key persistence?
RUN mkdir -p /run/sshd && chmod 755 /run/sshd


#Setup local non-root user
ENV SWAY_CONFIG_FILE=~/.config/sway/config
ENV SWAY_LAYOUT=grid
ENV SWAY_FONT_FAMILY=Monospace
ENV WLR_BACKENDS=headless
ENV DISPLAY=:1

ARG USERNAME
ARG PASSWORD
RUN useradd -m $USERNAME --shell /bin/bash 
RUN usermod -aG sudo $USERNAME

ENV XDG_RUNTIME_DIR=/tmp/.xdg-runtime
ENV WAYLAND_DISPLAY=wayland-1

USER $USERNAME
ENV HOME=/home/$USERNAME
WORKDIR /home/$USERNAME
RUN mkdir -p $XDG_RUNTIME_DIR && chown $USERNAME:$USERNAME $XDG_RUNTIME_DIR && chmod 700 $XDG_RUNTIME_DIR
RUN mkdir ./.config
COPY .config ./.config/
COPY .config/.tidyrc ./.tidyrc
RUN mkdir /home/$USERNAME/Downloads
COPY ./anime* /home/$USERNAME/Downloads
COPY ./.gitconfig /home/$USERNAME

ENV USERNAME=$USERNAME
ENV XDG_RUNTIME_DIR=/tmp/.xdg-runtime
RUN bash -c "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile=minimal"
RUN /home/$USERNAME/.cargo/bin/rustup update


USER root
RUN chown -v -R $USERNAME:$USERNAME /home/$USERNAME

COPY entry.sh /root/
RUN chmod 700 /root/entry.sh
CMD /root/entry.sh
