alias pls='sudo'

alias ..='up 1'
alias ...='up 2'
alias ....='up 3'
alias .....='up 4'

alias pomo='export PYGAME_DETECT_AVX2=1 && mamba run -p /home/diego/miniforge3/envs/pomo python3 /home/diego/Documents/Proyectos/SimplePomo/SimplePomo/__main__.py'

alias brc='gedit ~/.bashrc'
alias sbrc='source ~/.bashrc'
alias docs='cd ~/Documents && ls'
alias desk='cd ~/Desktop && ls'
alias prog='cd ~/Documents/MAIN/3-Resources/Programación-Avanzada/Boletines'
alias al='cd /run/user/1000/gvfs/google-drive:host=uji.es,user=al426641 && ls'

alias recentinstalls="grep \" install \" /var/log/apt/history.log"
alias c='clear'
alias h='history'
alias hg='history | grep $1'

alias update='
    sudo apt-get update &&
    sudo apt-get upgrade &&
    sudo apt-get autoremove'


alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%Y-%m-%d"'

alias fh='find . -name '
alias python='python3'
alias cursor='~/Downloads/CURSOR-VSCODE.AppImage &'
alias bluetoothfix='sudo hciconfig hci0 down && sudo bluemoon -A && sudo hciconfig hci0 up && sudo systemctl restart bluetooth.service'

# ls aliases

alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# git aliases

alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gl='git log --oneline'
alias gb='git checkout -b'
alias gd='git diff'

# HERRAMIENTAS UTILES
alias sortt='du -sh * | sort -h'     # ordenar los contenidos por tamaño
alias searchh='find . -type f -exec du -ah {} + | sort -h'    # recursivo

alias lastmile='source ~/Documents/Proyectos/LastMile/venv/bin/activate && python3 ~/Documents/Proyectos/LastMile/app.py'

alias b='byobu'
