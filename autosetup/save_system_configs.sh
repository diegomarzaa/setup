#!/usr/bin/env bash

set -e
echo "💾 Guardando configuraciones de sistema (requiere sudo)..."

# Asegúrate de que estás en el directorio raíz del repositorio
REPO_ROOT="$(git rev-parse --show-toplevel)"
if [ -z "$REPO_ROOT" ]; then
    echo "❌ Error: No se pudo determinar la raíz del repositorio Git."
    exit 1
fi

DEST_DIR="$REPO_ROOT/system-configs"

# --- Lista de archivos/carpetas a respaldar ---
# Sintaxis: "ruta/absoluta/en/el/sistema"
SYSTEM_PATHS=(
    "/etc/NetworkManager/system-connections/"
    "/etc/ufw/"
    "/var/lib/bluetooth/"
    # --- Añade aquí otras rutas que necesites ---
    # Ejemplo: "/usr/local/bin/" para scripts personalizados
    # Ejemplo: "/etc/default/grub" si personalizas el arranque
)

for path in "${SYSTEM_PATHS[@]}"; do
    if [ -e "$path" ]; then
        echo "  -> Copiando $path..."
        # Crear la estructura de directorios de destino si no existe
        mkdir -p "$DEST_DIR$(dirname "$path")"
        # Usar rsync para copiar preservando permisos y estructura
        sudo rsync -a "$path" "$DEST_DIR$path"
    else
        echo "  -> OMITIENDO (no encontrado): $path"
    fi
done

echo "✅ Guardado de configuraciones de sistema completado."