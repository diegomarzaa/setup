#!/usr/bin/env bash
sudo apt update
xargs -a apt-manuales-relevantes.txt sudo apt install -y
