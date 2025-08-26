#!/usr/bin/env bash
set -e

# 1) Sistema y paquetes
# TODO
# sudo apt update && sudo apt install -y ansible git curl flatpak snapd gnome-shell-extension-manager

# 2) Snap & Flatpak & APT
./install-apt.sh
./install-snaps.sh
./install-flatpaks.sh

# 3) GNOME
# TODO
./install-extensions.sh

# 4) Dotfiles
# TODO

# 5) Sistema
# TODO

echo "¡Todo listo! Reinicia sesión para ver los cambios."
