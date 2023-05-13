#!/usr/bin/env bash

apt update
apt install snapd -y

snap install core

snap install shadowsocks-libev --edge
