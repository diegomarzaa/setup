#!/usr/bin/env bash

apt-mark showmanual > ./lista_paquetes_apt.txt
snap list --all > ./lista_paquetes_snap.txt
flatpak list --app --columns=application > ./lista_paquetes_flatpak.txt

gnome-extensions list --enabled > ./lista_extensiones_gnome.txt
dconf dump / > ./lista_configuracion_gnome.dconf