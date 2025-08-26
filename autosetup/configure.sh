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
./install-extensions.sh          # o copiar de dotfiles/gnome_shell_extensions tal cual (peligroso si actualizo de 22.04 a 24.04)
./load-configuration-gnome.sh

# 4) Dotfiles
# TODO
stow -d ~/setup/dotfiles -t ~ argos bash dunst zsh   # colocar aquí gnome_shell_extensions si no funciona install-extensions
stow -d ~/setup/secrets -t ~ docker git gnupg kdeconnect rclone remmina ssh tailscale

# 5) Sistema
# TODO

echo "¡Todo listo! Reinicia sesión para ver los cambios."
