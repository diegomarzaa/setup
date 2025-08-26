#!/usr/bin/env bash
sudo apt update
xargs -a lista_paquetes_apt_relevantes.txt sudo apt install -y
