#!/usr/bin/env bash
sudo apt update
xargs -a apt-manuales.txt sudo apt install -y
