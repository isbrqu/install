#!/usr/bin/env bash

echo "$1 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
vi /etc/sudoers
cat sources.list > /etc/apt/sources.list

