#!/usr/bin/env bash
while read -r app; do
  flatpak install -y flathub "$app"
done < flatpaks.txt
