#!/usr/bin/env bash
# tmux
url="https://github.com/tmux/tmux/releases/download/3.1c/tmux-3.1c.tar.gz"\
&& wget "$url"\
&& tar -zxf tmux-*.tar.gz\
&& cd tmux-*/\
&& ./configure\
&& make\
&& sudo make install\
&& cd ..

# vim
# url="https://github.com/vim/vim.git"
# git clone --depth 1 "$url"

# kakoune
# url="https://github.com/mawww/kakoune/releases/download/v2020.09.01/kakoune-2020.09.01.tar.bz2"
# wget "$url"

# sc-im
# url="https://github.com/andmarti1424/sc-im/archive/v0.7.0.tar.gz"
# wget "$url"

# fzf
url="https://github.com/junegunn/fzf.git"\
&& git clone --detph 1 "$url" ~/.fzf\
&& ~/.fzf/install

# googler
url="https://raw.githubusercontent.com/jarun/googler/v4.3.1/googler"\
&& sudo curl -o /usr/local/bin/googler "$url"\
&& sudo chmod +x /usr/local/bin/googler

# i3status
url="https://i3wm.org/i3status/i3status-2.13.tar.bz2"\
&& wget "$url"\
&& tar -zxf i3status-*.tar.gz\
&& autoreconf -fi\
&& mkdir build\
&& cd build\
&& ../configure --disable-sanitizers\
&& make -j$(nproc)\
&& sudo make install\
&& cd ..

# dmenu
#url="https://dl.suckless.org/tools/dmenu-5.0.tar.gz"\
#&& wget "$url"\
#&& tar -zxf dmenu-*.tar.gz

# st
url="https://github.com/isbrqu/st/archive/master.zip"\
&& wget "$url"\
&& unzip -q st-master\
&& cd st-master\
&& sudo make clean install\
&& cd ..


