WARNING!!!!!!!!! README DESACTUALIZADO, SE ACTUALIZARÁ CUANDO ESTÉ TODO CLARO, POR AHORA NADA

# dotfiles

```
git clone github-diegomarzaa:diegomarzaa/setup.git ~/setup
cd ~/setup/dotfiles
stow -d /home/diego/setup/dotfiles -t ~ bash dunst argos zsh
```

# Backups

```
conda activate base
conda env export > ../backups/base.yml
```

# Restores

Conda

```
conda env create -f ../backups/base.yml
```

Drivers de nvidia

```
# Hacer paso a paso
ubuntu-drivers devices
sudo apt-fast install -y nvidia-driver-XXX
sudo modprobe nvidia
nvidia-smi
```

VSCode

```
echo "⌨️  Installing VSCode"
sudo apt update
sudo apt install -y code
```

# Pendientes / Testear

- [ ] git
- [ ] zsh
- [ ] tmux
- [ ] vscode
