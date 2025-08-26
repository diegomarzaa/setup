# Diego Setup Ubuntu

1.  **Instalar Dependencias**
    ```bash
    sudo apt update && sudo apt install -y git git-crypt stow
    ```

2.  **Clonar Repositorio**
    ```bash
    git clone github-diegomarzaa:diegomarzaa/setup.git ~/setup
    cd ~/setup
    ```

3.  **Desbloquear Secretos**
    ```bash
    git-crypt unlock
    ```

4.  **Ejecutar el Instalador**
    ```bash
    ./install.sh
    ```

##  Mantenimiento

- Ejecutar `./autosetup/save_all.sh`
- Revisa la lista de paquetes apt/snap/flatpak y pasa a "relevantes" los que consideres.
- Dotfiles y secrets: ir añadiendolos a las respectivas carpetas.

## Pendiente

- [ ] Conda
- [ ] Drivers nvidia

Que en principio es:
```
ubuntu-drivers devices
sudo apt-fast install -y nvidia-driver-XXX
sudo modprobe nvidia
nvidia-smi
```

- [ ] Zsh bien

