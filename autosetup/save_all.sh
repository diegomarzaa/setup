#!/usr/bin/env bash

# Installations
apt-mark showmanual > ./lista_paquetes_apt_all.txt
snap list --all > ./lista_paquetes_snap_all.txt
flatpak list --app --columns=application > ./lista_paquetes_flatpak_all.txt

echo "✅ Guardado de instalaciones apt/snap/flatpak completado."

# Extensiones Names
gnome-extensions list --enabled > ./lista_extensiones_gnome.txt

echo "✅ Guardado de extensiones de GNOME completado."

# 1) All - Gnome Config + extensions config
dconf dump / > ./lista_configuracion_gnome_all.dconf

# 2) Selective
OUTPUT_FILE="./lista_configuracion_gnome_relevantes.dconf"

# Array con todas las rutas de dconf que quieres respaldar.
# Añade o quita las que necesites.
PATHS_TO_BACKUP=(
    "/org/gnome/desktop/interface/"
    "/org/gnome/desktop/peripherals/"
    "/org/gnome/desktop/wm/preferences/"
    "/org/gnome/mutter/"
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/"
    "/org/gnome/desktop/wm/keybindings/"
    "/org/gnome/shell/extensions/dash-to-dock/"
    "/org/gnome/shell/extensions/dash-to-panel/"
    "/org/gnome/shell/extensions/gestureImprovements/"
    "/org/gnome/shell/extensions/gsconnect/"
    "/org/gnome/shell/extensions/just-perfection/"
    "/org/gnome/shell/extensions/pano/"
)

echo "📝 Guardando configuraciones selectivas de GNOME en $OUTPUT_FILE"

# Empezamos con un archivo vacío.
> "$OUTPUT_FILE"

# Iteramos sobre cada ruta del array
for path in "${PATHS_TO_BACKUP[@]}"; do
    # 1. Preparamos el encabezado eliminando la barra inicial y final
    header=$(echo "$path" | sed 's/^\///' | sed 's/\/$//')

    # 2. Escribimos el encabezado de sección correcto en el archivo
    echo -e "\n[$header]" >> "$OUTPUT_FILE"

    # 3. Hacemos el volcado, eliminamos el encabezado inútil '[/]' y lo añadimos al archivo
    dconf dump "$path" | grep -v '^\[/\]$' >> "$OUTPUT_FILE"
done

echo "✅ Volcado total y selectivo de dconf completado."