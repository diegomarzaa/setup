#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.

# --- Guardado de Listas de Paquetes ---
echo "📦 Guardando listas de paquetes..."
apt-mark showmanual > ./lista_paquetes_apt_all.txt
snap list --all > ./lista_paquetes_snap_all.txt
flatpak list --app --columns=application > ./lista_paquetes_flatpak_all.txt
echo "✅ Guardado de instalaciones apt/snap/flatpak completado."
echo "---"

# --- Guardado de Extensiones de GNOME ---
echo "🧩 Guardando lista de extensiones de GNOME..."
gnome-extensions list --enabled > ./lista_extensiones_gnome.txt
echo "✅ Guardado de extensiones de GNOME completado."
echo "---"

# --- Guardado de Configuración Dconf ---

# 1) Volcado Completo
echo "🎨 Realizando volcado completo de dconf..."
dconf dump / > ./lista_configuracion_gnome_all.dconf
echo "✅ Volcado completo guardado en lista_configuracion_gnome_all.dconf."
echo "---"

# 2) Volcado Selectivo
OUTPUT_FILE="./lista_configuracion_gnome_relevantes.dconf"
echo "📝 Guardando configuraciones selectivas de GNOME en $OUTPUT_FILE"

# Array con las rutas de dconf a respaldar
PATHS_TO_BACKUP=(
    "/org/gnome/desktop/interface/"
    "/org/gnome/desktop/peripherals/"
    "/org/gnome/desktop/wm/preferences/"
    "/org/gnome/mutter/"
    "/org/gnome/settings-daemon/plugins/media-keys/" # Incluye custom-keybindings y otras
    "/org/gnome/desktop/wm/keybindings/"
    "/org/gnome/shell/extensions/dash-to-dock/"
    "/org/gnome/shell/extensions/dash-to-panel/"
    "/org/gnome/shell/extensions/gestureImprovements/"
    "/org/gnome/shell/extensions/gsconnect/"
    "/org/gnome/shell/extensions/just-perfection/"
    "/org/gnome/shell/extensions/pano/"
)

# Empezamos con un archivo vacío
: > "$OUTPUT_FILE"

# Iteramos sobre cada ruta del array
for path in "${PATHS_TO_BACKUP[@]}"; do
    # Verifica si el directorio dconf existe antes de intentar hacer el volcado
    if dconf list "$path" >/dev/null 2>&1; then
        echo "  -> Procesando ruta: $path"
        
        # Preparamos el encabezado
        header=$(echo "$path" | sed 's#^/##; s#/$##')
        
        # Hacemos el volcado
        dump_content=$(dconf dump "$path" | grep -v '^\[/\]$')
        
        # Solo escribimos en el archivo si el volcado no está vacío
        if [[ -n "$dump_content" ]]; then
            printf "\n[%s]\n" "$header" >> "$OUTPUT_FILE"
            printf "%s\n" "$dump_content" >> "$OUTPUT_FILE"
        else
            echo "     (La ruta está vacía o no tiene configuraciones personalizadas, omitiendo)"
        fi
    else
        echo "  -> OMITIENDO ruta (no encontrada): $path"
    fi
done

echo "✅ Volcado selectivo de dconf completado."