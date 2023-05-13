#!/usr/bin/env bash

apt update
apt install snapd

snap install core

snap install shadowsocks-libev --edge
