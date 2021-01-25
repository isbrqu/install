#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

ztmux='tmux-3.1c.tar.gz'
zscim='v0.7.0.tar.gz'
zdmenu='dmenu-5.0.tar.gz'
zi3status='i3status-2.13.tar.bz2'

url_tmux="https://github.com/tmux/tmux/releases/download/3.1c/$ztmux"
url_scim="https://github.com/andmarti1424/sc-im/archive/$zscim"
url_dmenu="https://dl.suckless.org/tools/$zdmenu"
url_i3status="https://i3wm.org/i3status/$zi3status"
url_vim="https://github.com/vim/vim.git"
url_fzf="https://github.com/junegunn/fzf.git"
url_st="https://github.com/isbrqu/st.git"
url_googler="https://raw.githubusercontent.com/jarun/googler/v4.3.1/googler"

ftmux="${ztmux%.tar.gz}"
fscim="sc-im-0.7.0"
fdmenu="${zdmenu%.tar.gz}"
fi3status="${zi3status%.tar.bz2}"
fvim="vim"
ffzf="fzf"
fst="st"

_apt() {
sudo apt update\
&& sudo apt upgrade -y\
&& sudo apt install -y\
	git\
	curl\
	neofetch\
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
	libnl-genl-3-dev\
	libx11-dev\
	libxft-dev\
        xinput
}

_download() {

([[ -d z ]] || mkdir z)\
&& cd z

echo "tmux"
wget "$url_tmux" --quiet

echo "sc-im"
wget "$url_scim" --quiet

echo "dmenu"
wget "$url_dmenu" --quiet

echo "i3status"
wget "$url_i3status" --quiet

echo "vim"
git clone --depth 1 --quiet -- "$url_vim" vim

echo "fzf"
git clone --depth 1 --quiet -- "$url_fzf" fzf

echo "st"
git clone --depth 1 --quiet -- "$url_st" st

echo "googler"
wget "$url_googler" --quiet

tar --extract --gunzip --file="$ztmux"\
&& rm "$ztmux"

tar --extract --gunzip --file="$zscim"\
&& rm "$zscim"

tar --extract --gunzip --file="$zdmenu"\
&& rm "$zdmenu"

tar --extract --bzip2 --file="$zi3status"\
&& rm "$zi3status"
}

_extract() {
cd ~/m/z/$ftmux\
&& ./configure\
&& make\
&& sudo make install\
&& cd ..

cd ~/m/z/$fscim\
&& make -C src\
&& sudo make -C src install\
&& cd ..

cd ~/m/z/$fst\
&& sudo make clean install\
&& cd ..

cd ~/m/z/$fi3status\
&& autoreconf -fi\
&& mkdir build\
&& cd build\
&& ../configure --disable-sanitizers\
&& make -j$(nproc)\
&& sudo make install\
&& cd ..

mv ~/m/z/$ffzf ~/.fzf\
&& ~/.fzf/install

chmod +x ~/m/z/googler\
&& sudo mv ~/m/z/googler /usr/local/bin/googler\
&& sudo googler -u

cd ~/m/z/$fst\
&& sudo make clean install\
&& cd ..
}

_link() {
([[ -d ~/.config ]] || mkdir ~/.config)\
&& cd ~/.config\
&& git clone --recurse-submodules https://github.com/isbrqu/dot dot\
&& cd dot\
&& ln -fsr vim ~/.vim\
&& ln -fsr rofi ~/.config/rofi\
&& ln -fsr git ~/.config/git\
&& ln -fsr bash/inputrc ~/.inputrc\
&& ln -fsr bash/logout ~/.bash_logout\
&& ln -fsr bash/profile ~/.bash_profile\
&& ln -fsr bash/run ~/.bashrc\
&& ln -fsr i3status ~/.config/i3status\
&& ln -fsr i3wm ~/.config/i3\
&& ln -fsr tmux ~/.tmux\
&& ln -fsr tmux/config ~/.tmux.conf
}

main() {
_apt
_download
_extract
_link
}

main

