# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'



# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi





################################# FUNCIONES CUSTOM ################################################3

ros2s() {
    echo -e "\033[1;36mSourceando ROS2 Humble...:\033[0m"
    echo -e "\033[1;32m\tsource /opt/ros/humble/setup.bash\033[0m"
    source /opt/ros/humble/setup.bash

    echo -e "\033[1;36mCreando los siguientes alias...:\033[0m"
    echo -e "\033[1;32m\tros2src='source /opt/ros/humble/setup.bash'\033[0m"
    echo -e "\033[1;32m\tsrc='source install/setup.bash'\033[0m"
    alias ros2src='source /opt/ros/humble/setup.bash'
    alias src='source install/setup.bash'

    echo -e "\033[1;36mSourceando cosas de colcon...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/colcon_cd/function/colcon_cd.sh\033[0m"
    echo -e "\033[1;33m\t - usa 'colcon_cd' para navegar entre paquetes\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash\033[0m"
    echo -e "\033[1;33m\t - autocompletado de colcon\033[0m"
    source /usr/share/colcon_cd/function/colcon_cd.sh
    source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash

    echo -e "\033[1;36mExportando variables comunes...\033[0m"
    echo -e "\033[1;32m\texport LDS_MODEL=LDS-01\033[0m"
    echo -e "\033[1;32m\texport TURTLEBOT3_MODEL=burger\033[0m"
    export LDS_MODEL=LDS-01
    export TURTLEBOT3_MODEL=burger
    
    echo -e "\033[1;36mExportando setup del gazebo...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/gazebo/setup.sh\033[0m"
    source /usr/share/gazebo/setup.sh
    
    echo -e "\033[1;36mExportando autocompletado de ros2...\033[0m"
    echo -e "\033[1;32m\tsource /usr/share/ros2cli/ros2cli/env.sh\033[0m"
    
    export ROS_DOMAIN_ID=3
}



phone() {
	adb connect 192.168.1.128:5555
	scrcpy --always-on-top -S -b2M -m900 --power-off-on-close
}


up() {
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}



function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}


function bash_prompt(){
    PS1='${debian_chroot:+($debian_chroot)}'${blu}'$(git_branch)'${pur}' \W'${grn}' \$ '${clr}
}


list() {
    # ls pero en forma de árbol, con todas las subcarpetas
    if [ $2 ]; then
        tree --noreport -C $1 -L $2
    else
        if [ $1 ]; then
            if [ $1 -eq $1 ] 2>/dev/null; then
                if [ $1 -gt 1 ]; then
                   tree --noreport -C -L $1 | less -r
                else
                    tree --noreport -C -L 1 $1
                fi
            else
                tree --noreport -C $1 -L 1
            fi
        else
            tree --noreport -C -L 1
        fi
    fi
}












################################# PRINT ON OPEN ################################################3

## toilet -t --gay -F border BIENVENIDO :D

# neofetch
#. /usr/share/autojump/autojump.sh   # BUSCADOR GLOBAL

## top 10 commands you run most
# history | awk '{cmd[$2]++} END {for(elem in cmd) {print cmd[elem] " " elem}}' | sort -n -r | head -10

declare -A comandos_comunes
comandos_comunes["zsh"]="Terminal chingona"
comandos_comunes["??"]="Sugerencias Copilot"
comandos_comunes["fh archivo*.jpg"]="Buscador global (RegEx, entre comillas)"
comandos_comunes["phone"]="Visualizar móvil en el PC (sin cable)"
comandos_comunes["ros2s"]="Habilitar ros2 en esta terminal y hacer sources"
comandos_comunes["j, jo"]="autojump, fast navigation"
comandos_comunes["permalias nombre='comando'"]="Nuevo alias"
comandos_comunes["ncdu ~/"]="Disk usage analize"
comandos_comunes["ncdu ~/"]="Disk usage analize"
comandos_comunes["zsh"]=""

comandos() {
    local max_length=0
    local padding=2  # Extra space after the longest command

    # Find the length of the longest command
    for cmd in "${!comandos_comunes[@]}"; do
        if [ ${#cmd} -gt $max_length ]; then
            max_length=${#cmd}
        fi
    done

    # Add padding to max_length
    max_length=$((max_length + padding))

    echo "Comandos útiles: "
    for cmd in "${!comandos_comunes[@]}"; do
        printf -- "- %-${max_length}s" "$cmd"
        printf -- "→ %s\n" "${comandos_comunes[$cmd]}"
    done
}

comandos






# Alias definitions.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/diego/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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
# <<< conda initialize <<<

export PATH=/usr/local/cuda-12.4/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH
