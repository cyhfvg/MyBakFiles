#!/usr/bin/env bash

apt update
apt install gcc make

wget https://download.libsodium.org/libsodium/releases/LATEST.tar.gz

tar xf LATEST.tar.gz

cd libsodium-stable/

./configure

make && make check

make install

ldconfig
