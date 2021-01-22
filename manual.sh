#!/usr/bin/env bash

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
(( $? == 0 )) || (echo "error tmux" && exit 1)

echo "sc-im"
wget "$url_scim" --quiet
(( $? == 0 )) || (echo "error sc-im" && exit 1)

echo "dmenu"
wget "$url_dmenu" --quiet
(( $? == 0 )) || (echo "error dmenu" && exit 1)

echo "i3status"
wget "$url_i3status" --quiet
(( $? == 0 )) || (echo "error i3status" && exit 1)

echo "vim"
git clone --depth 1 --quiet -- "$url_vim" vim
(( $? == 0 )) || (echo "error vim" && exit 1)

echo "fzf"
git clone --depth 1 --quiet -- "$url_fzf" fzf
(( $? == 0 )) || (echo "error fzf" && exit 1)

echo "st"
git clone --depth 1 --quiet -- "$url_st" st
(( $? == 0 )) || (echo "error st" && exit 1)

echo "googler"
wget "$url_googler" --quiet
(( $? == 0 )) || (echo "error googler" && exit 1)

tar --extract --gunzip --file="$ztmux"\
&& rm "$ztmux"

tar --extract --gunzip --file="$zscim"\
&& rm "$zscim"

tar --extract --gunzip --file="$zdmenu"\
&& rm "$zdmenu"

tar --extract --bzip2 --file="$zi3status"\
&& rm "$zi3status"

(cd "$ftmux"\
&& ./configure\
&& make\
&& sudo make install\
&& cd ..)\
|| echo "error tmux" >> "$ferror"

(cd "$fscim"\
&& sudo make -C src install\
&& cd ..)\
|| echo "error scim" >> "$ferror"

# (cd "$fst"\
# && sudo make clean install\
# && cd ..)\
# || echo "error st" >> "$ferror"

(cd "$fi3status"\
&& autoreconf -fi\
&& mkdir build\
&& cd build\
&& ../configure --disable-sanitizers\
&& make -j$(nproc)\
&& sudo make install\
&& cd ..)\
|| echo "error i3status" >> "$ferror"

(mv "$ffzf" ~/.fzf\
&& ~/.fzf/install)\
|| echo "error googler" >> "$ferror"

(chmod +x googler\
&& sudo mv googler /usr/local/bin/googler\
&& sudo googler -u)\
|| echo "error googler" >> "$ferror"

(cd "$fst"\
&& sudo make clean install\
&& cd ..)\
|| echo "error st" >> "$ferror"

