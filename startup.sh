#!/bin/bash
setxkbmap -layout us -variant altgr-intl
xmodmap .config/dotfiles/keyboard-xmodmap/logitech-k400-fn-swap
# xmodmap .config/dotfiles/keyboard-xmodmap/logitech-k400-dou
xinput disable 10

