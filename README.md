# dotfiles

```
git clone github-diegomarzaa:diegomarzaa/setup.git ~/setup
cd ~/setup/dotfiles
stow -d /home/diego/setup/dotfiles -t ~ bash dunst argos zsh
```

## Backups

```
conda activate base
conda env export > ../backups/base.yml
```

## Restores

APT

```
sudo apt update && sudo apt full-upgrade -y

function install {
  which $1 &> /dev/null

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install -y $1
  else
    echo "Already installed: ${1}"
  fi
}

install curl
install git
install tree
install wget

sudo apt upgrade -y
sudo apt autoremove -y
```

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

## Pendientes / Testear

- [ ] git
- [ ] zsh
- [ ] tmux
- [ ] vscode
