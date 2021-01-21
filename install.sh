#!/usr/bin/env bash

username="isbrqu"
pathdot=".config/dot"
echo "$username  ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
&& vi /etc/sudoers
cat sources.list > /etc/apt/sources.list
