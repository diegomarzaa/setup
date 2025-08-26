#!/usr/bin/env bash
set -e # Salir inmediatamente si un comando falla

echo "🚀 Iniciando la configuración del nuevo sistema..."

# PASO 0: Comprobar dependencias
echo "🔎 Verificando dependencias (git, git-crypt, stow, zsh)..."
for cmd in git git-crypt stow zsh; do
  if ! command -v $cmd &> /dev/null; then
    echo "❌ Error: '$cmd' no está instalado. Por favor, instálalo primero."
    echo "Sugerencia: sudo apt update && sudo apt install $cmd"
    exit 1
  fi
done

# PASO 1: Desbloquear secretos (El usuario debe hacer esto manualmente antes)
if [ # TODO ??? ]; then
    echo "⚠️  Advertencia: Los secretos no parecen estar desbloqueados."
    echo "🗝️  Por favor, ejecuta 'git-crypt unlock' con tu clave antes de continuar."
    read -p "Presiona Enter para continuar de todos modos, o Ctrl+C para cancelar."
fi

# PASO 2: Instalar todo el software
echo "📦 Instalando paquetes y aplicaciones desde 'autosetup'..."
(cd autosetup && ./load_apt.sh)
(cd autosetup && ./load_snaps.sh)
(cd autosetup && ./load_flatpaks.sh)
(cd autosetup && ./load_install_extensions.sh)

# PASO 3: Crear enlaces simbólicos con Stow
echo "🔗 Creando enlaces simbólicos para dotfiles y secretos..."

# Stow para configuraciones públicas
echo "-> Aplicando configuraciones de 'dotfiles'..."
stow --verbose=2 -d ~/setup/dotfiles -t ~ argos bash dunst zsh

# Stow para secretos
echo "-> Aplicando configuraciones de 'secrets'..."
stow --verbose=2 -d ~/setup/secrets -t ~ docker git gnupg kdeconnect rclone remmina ssh tailscale

# PASO 4: Aplicar configuración de GNOME
echo "🎨 Cargando la configuración de GNOME..."
(cd autosetup && ./load_config_gnome.sh)

# PASO 5: Tareas post-instalación
echo "🔧 Realizando tareas finales..."
# Shell por defecto a Zsh
if [ -f /usr/bin/zsh ]; then
    echo "Cambiando la shell por defecto a Zsh. Necesitarás tu contraseña."
    chsh -s $(which zsh)
fi

echo "✅ ¡Configuración completada! Por favor, reinicia tu sesión para que todos los cambios surtan efecto."