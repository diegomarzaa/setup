# ==============================================================================
#                            PRE-INITIALIZATION
#
# This section contains code that must run at the very beginning of the Zsh
# startup process for features like the instant prompt.
# ==============================================================================

# Enable Powerlevel10k instant prompt.
# This must stay at the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi



# ==============================================================================
#                                       INBOX
#
# Fast changes added to this section, pending to organise them later.
# ==============================================================================




# ==============================================================================
#                            PLUGIN MANAGER (ZINIT)
#
# Sets up the Zinit plugin manager, which handles loading all other tools.
# ==============================================================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# ==============================================================================
#                            PLUGINS
#
# All plugins are loaded here using Zinit.
# ==============================================================================

# (P10k) Powerlevel10k Theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# (Highlighting) Syntax highlighting for the command line
zinit light zsh-users/zsh-syntax-highlighting

# (Autosuggestions) Fish-like suggestions based on history
zinit light zsh-users/zsh-autosuggestions

# (Completions) Additional completion definitions for Zsh
zinit light zsh-users/zsh-completions
# Initialize the completions system
autoload -U compinit && compinit

# (FZF-Tab) Replace Zsh's default completion selection with fzf
zinit light Aloxaf/fzf-tab

# Extra

# ==============================================================================
#                            ENVIRONMENT VARIABLES
#
# Centralized location for all `export` statements, including PATH.
# ==============================================================================

# Set the default editor
export EDITOR=nvim

# Consolidated PATH modifications
# The order is important: paths added first are checked first.
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/.local/bin:$PATH"

# ==============================================================================
#                            SHELL HISTORY
#
# Configuration for Zsh's command history.
# ==============================================================================

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY         # Append to history file, don't overwrite
setopt HIST_IGNORE_ALL_DUPS   # If a new command is a duplicate, remove the older one
setopt HIST_IGNORE_SPACE      # Don't save commands that start with a space
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate consecutive events to the history file
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history


# ==============================================================================
#                            SHELL OPTIONS
#
# General Zsh behavior enhancements.
# ==============================================================================
setopt AUTO_CD              # If you type a directory name, cd into it
setopt interactive_comments  # Allow comments in interactive mode

# ==============================================================================
#                            ALIASES
#
# All command aliases are defined here.
# ==============================================================================

alias python='python3'
alias szsh='source ~/.zshrc'
alias c='clear'
alias h='history'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'

if [ -f ~/.terminal_aliases ]; then
    . ~/.terminal_aliases
fi

# ==============================================================================
#                            KEYBINDINGS
#
# Custom keybindings for Zsh's line editor (ZLE).
# ==============================================================================

bindkey -e # Use Emacs keybindings

# History search with arrow keys and Ctrl+P/N
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Word navigation with Ctrl + Arrow Keys
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Edit the current command line in $EDITOR (Ctrl+X, Ctrl+E)
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line


# ==============================================================================
#                            CUSTOM FUNCTIONS & TOOLS
#
# Custom helper functions and complex tool configurations.
# For even better organization, you could move these to a separate file
# (e.g., ~/.zshrc_functions) and `source` it here.
# ==============================================================================

function extract() {
    if [ -z "$1" ]; then
        echo "Usage: extract <file>"
    else
        if [ -f "$1" ]; then
            case "$1" in
                *.tar.bz2)  tar xjf "$1"    ;;
                *.tar.gz)   tar xzf "$1"    ;;
                *.bz2)      bunzip2 "$1"    ;;
                *.rar)      unrar x "$1"    ;;
                *.gz)       gunzip "$1"     ;;
                *.tar)      tar xf "$1"     ;;
                *.tbz2)     tar xjf "$1"    ;;
                *.tgz)      tar xzf "$1"    ;;
                *.zip)      unzip "$1"      ;;
                *.Z)        uncompress "$1" ;;
                *.7z)       7z x "$1"       ;;
                *)          echo "'$1' cannot be extracted via extract()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
    fi
}

# ---------- Fast Navigation Tools ----------

# Fuzzy find a directory and cd into it (requires zoxide)
function cdd() {
    cd "$(zoxide query -i -- $@)" || return
}

# ---------- ROS2 Environment Management ----------

# Function to source the ROS2 environment and set up aliases/completions
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

# ==============================================================================
#                            TOOL-SPECIFIC CONFIGURATIONS
#
# Configuration for specific plugins and tools like FZF.
# ==============================================================================

# FZF keybindings and fuzzy completion
if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
    source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# Zsh completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # Case-insensitive completion
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'  # Colorize completions
zstyle ':completion:*' menu no                          # Do not use menu completion

# FZF-Tab completion preview settings
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color $realpath'


# --- Quick Help (prints once per interactive session) -------------------------
# Safe with p10k Instant Prompt: runs via a precmd hook (post-init).
if [[ $- == *i* && -z ${ZSH_MOTD_DISABLE:-} ]]; then
  autoload -Uz add-zsh-hook

  _zsh_quick_help() {
    local b='%B' n='%b' g='%F{244}' c='%F{81}' y='%F{220}' r='%F{203}' w='%F{255}' reset='%f%b'
    print -P ""
    print -P "${c}┏━━━━━━━━━━━━━━━━━━━━ ${b}Zsh Quick Help${n} ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓${reset}"
    print -P "${w}• Nav:${reset}  ${y}.. ... ....${reset}  ${g}cdd${reset} fuzzy cd"
    print -P "${w}• Edit:${reset} ${g}Ctrl-X Ctrl-E${reset} edit current cmd in \$EDITOR"
    print -P "${w}• Files:${reset} ${g}extract <file>${reset} (zip, tar.gz, 7z, …)"
    print -P "${w}• ROS2:${reset} ${g}ros2s${reset} env; aliases: ${g}ros2src${reset}, ${g}src${reset}"
    print -P "${w}• Prompt:${reset} ${g}p10k configure${reset}   ${w}Conda:${reset} ${g}conda activate <env>${reset}"
    print -P "${w}• Shared terminal:${reset} ${g}sshx${reset}"
    print -P "${w}• Help:${reset} ${g}helpme${reset} show again"
    print -P "${c}┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛${reset}"
  }

  helpme() { _zsh_quick_help }

  _print_quick_help_once() {
    [[ -n ${ZSH_MOTD_SHOWN:-} ]] && return
    ZSH_MOTD_SHOWN=1
    _zsh_quick_help
    add-zsh-hook -D precmd _print_quick_help_once >/dev/null 2>&1
  }

  add-zsh-hook precmd _print_quick_help_once
fi
# -------------------------------------------------------------------------------


# ==============================================================================
#                       FINAL INITIALIZATION & AUTO-GENERATED
#
# This code runs last. It includes auto-generated blocks from installers
# and final setup commands for the prompt.
# ==============================================================================

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/home/diego/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/home/diego/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# Initialize Zoxide (must be after Zsh's options are set)
eval "$(zoxide init --cmd cd zsh)"

# Load Powerlevel10k theme configuration.
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# [Improvement] Finalize Powerlevel10k. Recommended for instant prompt.
(( ! ${+functions[p10k]} )) || p10k finalize

# To customize prompt, run `p10k configure` or edit ~/setup/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/setup/dotfiles/zsh/.p10k.zsh ]] || source ~/setup/dotfiles/zsh/.p10k.zsh

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/home/diego/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
