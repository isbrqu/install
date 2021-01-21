#!/usr/bin/env bash

username="isbrqu"
pathdot=".config/dot"

su –command echo "$username  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers\
&& vi /etc/sudoers

sudo cat sources.list > /etc/apt/sources.list

chmod +x apt.sh\
&& ./apt.sh
chmod +x manual.sh\
&& ./manual.sh
