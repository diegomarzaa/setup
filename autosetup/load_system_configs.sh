#!/usr/bin/env bash

set -e
echo "⚙️  Restaurando configuraciones de sistema (requiere sudo)..."
echo "⚠️  Se te preguntará antes de sobrescribir cualquier archivo existente."

# Asegúrate de que estás en el directorio raíz del repositorio
REPO_ROOT="$(git rev-parse --show-toplevel)"
if [ -z "$REPO_ROOT" ]; then
    echo "❌ Error: No se pudo determinar la raíz del repositorio Git."
    exit 1
fi

SOURCE_DIR="$REPO_ROOT/system-configs"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "-> No se encontró la carpeta 'system-configs'. Omitiendo este paso."
    exit 0
fi

echo "Los siguientes archivos/carpetas se restaurarán desde '$SOURCE_DIR':"
# Listar lo que se va a copiar para que el usuario esté informado
sudo find "$SOURCE_DIR" -mindepth 1 -maxdepth 3

read -p "❓ ¿Estás seguro de que quieres continuar? (s/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Ss]$ ]]; then
    echo "❌ Operación cancelada."
    exit 1
fi

# Copia los contenidos de forma segura e interactiva
# -r para recursivo, -p para preservar modo/propiedad/timestamps, -i para interactivo
sudo cp -rpi "$SOURCE_DIR"/* /

echo "✅ Restauración de configuraciones de sistema completada."
echo "ℹ️  Puede que necesites reiniciar servicios (network-manager, bluetooth) o el sistema para que los cambios surtan efecto."