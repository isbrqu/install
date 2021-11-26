#!/usr/bin/env bash

sh autogen.sh
./configure
# algunas advertencias y errores
make
sudo make install

