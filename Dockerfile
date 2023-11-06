FROM ubuntu:latest

RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y xubuntu-desktop

RUN rm /run/reboot-required*

RUN useradd -m tux -p $(openssl passwd testing)
RUN usermod -aG sudo tux

RUN apt install -y xrdp
RUN adduser xrdp ssl-cert

RUN ln -sf /bin/bash /bin/sh
RUN apt install -y neofetch

COPY xsession /home/tux/.xsession
RUN sed -i '3 a echo "\
export GNOME_SHELL_SESSION_MODE=xubuntu\\n\
export XDG_SESSION_TYPE=x11\\n\
export XDG_CURRENT_DESKTOP=LXQt\\n\
export XDG_CONFIG_DIRS=/etc/xdg/xdg-xubuntu:/etc/xdg\\n\
" > ~/.xsessionrc' /etc/xrdp/startwm.sh

EXPOSE 3389

CMD service xrdp start ; bash
