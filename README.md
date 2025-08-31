# Diego Setup Ubuntu

## Fase 1: Configuración inicial, dotfiles y gnome

1.  **Instalar Dependencias Críticas**
    ```bash
    sudo apt update && sudo apt install -y git gpg git-crypt stow restic
    ```

2.  **Restaurar Clave GPG Privada**
  
    Desde un USB o disco duro, tenerlo redundante pues es muy importante no perder esto, es para que git-crypt me reconozca.

    ```bash
    gpg --import-options restore --import private.gpg
    ```

3.  **Clonar Repositorio Público**
    ```bash
    git clone github-diegomarzaa:diegomarzaa/setup.git ~/setup
    cd ~/setup
    ```

4.  **Desbloquear Secretos**
    ```bash
    git-crypt unlock
    ```

5.  **Ejecutar el Instalador**
    ```bash
    ./install.sh
    ```

## Fase 2: Restauración de Archivos Personales

1. **Desde Disco Duro (Restic)**
   
   Conectamos el disco duro, configuramos las variables de entorno para que sepa donde está el backup y la contraseña.
   ```bash

   restic self-update
   restic version # restic 0.18.0 compiled with go1.24.1 on linux/amd64
   export RESTIC_REPOSITORY=/media/diego/Diego Hardrive/backup_ubuntu_2025
   export RESTIC_PASSWORD="........."

   # Opción 1: Segura
   mkdir ~/restauracion-temporal
   restic restore latest --target ~/restauracion-temporal

   # Opción 2: Directa
   restic restore latest --target /
   ```

2. **Desde la Nube (rclone)**

    - [ ] Pendiente, como 2a forma posible de precaución. Ver nota personal en obsidian.

## Fase 3: Tareas Finales

1. **Verificar drivers de nvidia**

    Que en principio es:
    ```
    ubuntu-drivers devices
    sudo apt-fast install -y nvidia-driver-XXX
    sudo modprobe nvidia
    nvidia-smi
    ```

2. **Conda, verificar zsh...**

## Mantenimiento

- Ejecutar `./autosetup/save_all.sh`
    - Restic al disco duro también (mirar nota obsidian)
- Revisa la lista de paquetes apt/snap/flatpak y pasa a "relevantes" los que consideres.
- Dotfiles y secrets: ir añadiendolos a las respectivas carpetas.