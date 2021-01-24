#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

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
	libnl-genl-3-dev
}

_download() {
ferror='~/scr-main/error'

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

([[ -d z ]] || mkdir z)\
&& cd z\
&& mkdir log

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
cd "$ftmux"\
&& ./configure\
&& make\
&& sudo make install\
&& cd ..

cd "$fscim"\
&& sudo make -C src install\
&& cd ..

#cd "$fst"\
# && sudo make clean install\
# && cd ..

cd "$fi3status"\
&& autoreconf -fi\
&& mkdir build\
&& cd build\
&& ../configure --disable-sanitizers\
&& make -j$(nproc)\
&& sudo make install\
&& cd ..

mv "$ffzf" ~/.fzf\
&& ~/.fzf/install

chmod +x googler\
&& sudo mv googler /usr/local/bin/googler\
&& sudo googler -u

cd "$fst"\
&& sudo make clean install\
&& cd ..
}

_link() {
git clone https://github.com/isbrqu/dot.git ~/.config/dot
ln -fsr ~/.config/dot/vim ~/.vim
ln -fsr ~/.config/dot/rofi ~/.config/rofi
ln -fsr ~/.config/dot/git ~/.config/git
ln -fsr ~/.config/dot/bash/inputrc ~/.inputrc
ln -fsr ~/.config/dot/bash/logout ~/.bash_logout
ln -fsr ~/.config/dot/bash/profile ~/.bash_profile
ln -fsr ~/.config/dot/bash/run ~/.bashrc
ln -fsr ~/.config/dot/i3status ~/.config/i3status
ln -fsr ~/.config/dot/i3wm ~/.config/i3
}

main() {
_apt
_download
_extract
_link
}

main
