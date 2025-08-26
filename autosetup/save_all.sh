#!/usr/bin/env bash

# Installations
apt-mark showmanual > ./lista_paquetes_apt_all.txt
snap list --all > ./lista_paquetes_snap_all.txt
flatpak list --app --columns=application > ./lista_paquetes_flatpak_all.txt

echo "✅ Guardado de instalaciones apt/snap/flatpak completado."

# Extensiones Names
gnome-extensions list --enabled > ./lista_extensiones_gnome.txt

# Gnome Config + extensions config
dconf dump / > ./lista_configuracion_gnome_all.dconf

OUTPUT_FILE="./lista_configuracion_gnome_relevantes.dconf"

# 1. Apariencia (Tema, iconos, fuentes, modo oscuro)
dconf dump /org/gnome/desktop/interface/ > "$OUTPUT_FILE"

# Perifericos
dconf dump /org/gnome/desktop/peripherals/ >> "$OUTPUT_FILE"

# 2. Comportamiento de ventanas y espacios de trabajo
dconf dump /org/gnome/desktop/wm/preferences/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/mutter/ >> "$OUTPUT_FILE"

# 3. Atajos de teclado personalizados
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/desktop/wm/keybindings/ >> "$OUTPUT_FILE"

# 4. Configuraciones de extensiones específicas (Añade las que uses)
dconf dump /org/gnome/shell/extensions/dash-to-dock/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/shell/extensions/dash-to-panel/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/shell/extensions/gestureImprovements/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/shell/extensions/gsconnect/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/shell/extensions/just-perfection/ >> "$OUTPUT_FILE"
dconf dump /org/gnome/shell/extensions/pano/ >> "$OUTPUT_FILE"

echo "✅ Volcado total y selectivo de dconf completado."