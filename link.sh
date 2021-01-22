#!/bin/bash
alias ln='ln -fsr'
cd ~/.config/dot
ln vim ~/.vim
ln rofi ~/.config/rofi
ln git ~/.config/git
ln bash/inputrc ~/.inputrc
ln bash/logout ~/.bash_logout
ln bash/profile ~/.bash_profile
ln bash/run ~/.bashrc
ln i3status ~/.config/i3status
ln i3wm ~/.config/i3
unalias ln
cd
