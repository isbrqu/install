#!/usr/bin/env bash

username="isbrqu"
pathdot=".config/dot"

(su –c 'echo "$username  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers'\
&& su -c 'vi /etc/sudoers')\
|| echo 'error' && exit 1

(sudo 'cat sources.list > /etc/apt/sources.list'\
&& sudo apt update\
&& sudo apt upgrade\
&& sudo apt install -y\
	git\
	curl\
	neofecth\
	xclip\
	xorg\
	autoconf\
	ntfs-3g\
	i3\
	python3-pip\
	build-essential\
	bison\
	pkg-config\
	libevent-dev\
	ncurses-dev\
	libconfuse-dev\
	libyajl-dev\
	libasound2-dev\
	libiw-dev\
	asciidoc\
	libpulse-dev\
	libnl-genl-3-dev)\
|| (echo 'error' && exit 1)

(chmod +x manual.sh\
&& ./manual.sh)\
|| (echo 'error' && exit 1)

git clone https://github.com/isbrqu/dot.git ~/.config/dot\
&& chmod +x link.sh\
&& ./link.sh
