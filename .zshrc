# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ZINIT
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


# -------------------- PLUGINS --------------------
# Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Hihglighting
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

# Autosuggestions
zinit light zsh-users/zsh-autosuggestions

# FZF
zinit light Aloxaf/fzf-tab





# -------- ALIASES

alias fd="fdfind"





# ----------------------------------- HISTORY SETTING ----------------------------------

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh_history
HISTDUP=erase
setopt appendhistory
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_save_no_dups



# ------------------------------- CUSTOM KEYBINDINGS -------------------------------------
# KEYBINDINGS
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[1;5C' forward-word           # Ctrl + → para avanzar una palabra
bindkey '^[[1;5D' backward-word          # Ctrl + ← para retroceder una palabra


autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line


# --------------------- ALIASES ----------------------

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# ---------------------------------------- ROS2 --------------------------------------

ros2s() {
    echo "\033[1;36mSourceando ROS2 Humble...\033[0m"
    echo -e "\033[1;32m\tsource /opt/ros/humble/setup.zsh\033[0m"
    source /opt/ros/humble/setup.zsh

    echo -e "\033[1;36mCreando los siguientes alias...:\033[0m"
    echo -e "\033[1;32m\tros2src='source /opt/ros/humble/setup.zsh'\033[0m"
    echo -e "\033[1;32m\tsrc='source install/setup.zsh'\033[0m"
    alias ros2src='source /opt/ros/humble/setup.zsh'
    alias src='source install/setup.zsh'

    echo "\033[1;36mSourceando cosas de colcon...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/colcon_cd/function/colcon_cd.sh\033[0m"
    echo -e "\033[1;33m\t - usa 'colcon_cd' para navegar entre paquetes\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh\033[0m"
    echo -e "\033[1;33m\t - autocompletado de colcon\033[0m"
    source /usr/share/colcon_cd/function/colcon_cd.sh
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh

    echo "\033[1;36mExportando variables comunes...\033[0m"
    echo -e "\033[1;32m\texport LDS_MODEL=LDS-01\033[0m"
    echo -e "\033[1;32m\texport TURTLEBOT3_MODEL=burger\033[0m"
    export LDS_MODEL=LDS-01
    export TURTLEBOT3_MODEL=burger
    
    echo "\033[1;36mExportando setup del gazebo...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/gazebo/setup.sh\033[0m"
    source /usr/share/gazebo/setup.sh
    
    echo "\033[1;36mExportando autocompletado de ros2...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/ros2cli/ros2cli/env.sh\033[0m"
    eval "$(register-python-argcomplete3 ros2)"
    eval "$(register-python-argcomplete3 colcon)"
    
    unset ROS_DOMAIN_ID
    # export ROS_DOMAIN_ID=3
    echo -e "\033[1;32m\tDOMAIN UNSETEADO\033[0m"
}


function chpwd() {
    if [[ "$PWD" == "$HOME/Documents/Universidad/3rCurso/IR2121-ROBOTICA-MOBIL" || "$PWD" == "$HOME/Documents/Universidad/3rCurso/IR2121-ROBOTICA-MOBIL/"* ]]; then
        if [[ -z "$ROS2_SOURCEADO" ]]; then
            ros2s
            export ROS2_SOURCEADO=1
        fi
    else
        unset ROS2_SOURCEADO
    fi
}


# -------------------------- APPS ----------------
export PATH=$PATH:/home/diego/.spicetify




# ---------------------------------------- CONDA -----------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/diego/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/diego/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/diego/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/diego/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/diego/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/diego/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


# --------------------------------------- CUDA PARA TENSORFLOW ---------------------

export PATH=/usr/local/cuda-12.4/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH


# -------------------------- PATHS

export PATH=$PATH:/home/diego/.spicetify
export PATH=$PATH:/home/diego/Documents/Matlab/bin




# ------------------------------------Completion Styling - FZF COMPLETIONS -----------------


# Setup fzf
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# Include fzf default command

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'  # color
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color $realpath'


# ---------- FAST NAVIGATION TOOLS ------------
# ---------------------------------------------

# ---------- Fuzzy directory

function cdd() {
    cd "$(zoxide query -i -- $@)" || return
}


# ---------- Find files

alias ff='fd --type f --hidden --follow --exclude .git'


# ---------- Find and cd to directory

fdc() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git | fzf) && cd "$dir"
}

# ---------- Open file

fdo() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf) && xdg-open "$file"
}




# ------------------------------ CUSTOM PROMPT ---------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# Default editor
export EDITOR=gedit


export PATH="$HOME/.local/bin:$PATH"


# ------ CUSTOM PROMPT END OF ZSHRC FOR QUICK PROMPT ------------

eval "$(zoxide init --cmd cd zsh)"
(( ! ${+functions[p10k]} )) || p10k finalize

