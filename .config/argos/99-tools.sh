#!/usr/bin/env bash

# Paths
REPO_PATH_OBSIDIAN="/home/diego/Documents/Github/Personal/ObsidianNotes"
DOTF_PATH="/home/diego/.dotfiles/"

# Mostrar botón
echo "💻"
echo "---"

# Sync options
echo "🔄 Sync Obsidian Notes | bash='bash -c \"cd $REPO_PATH_OBSIDIAN && /home/diego/.config/argos/scripts/gitsync-script.sh $REPO_PATH_OBSIDIAN auto\"' terminal=false"
echo "🔄 Sync .dotfiles | bash='bash -c \"cd $DOTF_PATH && /home/diego/.config/argos/scripts/gitsync-script.sh $DOTF_PATH ask\"' terminal=false"

echo "---"


# Tools
echo "✏️ Abrir Excalidraw | bash='bash -c \"xdg-open obsidian://adv-uri?vault=ObsidianNotes\\&commandid=obsidian-excalidraw-plugin%3Aexcalidraw-autocreate-popout\"' terminal=false"
echo "🍅 Simple Pomo | bash='/home/diego/miniforge3/bin/python3 /home/diego/Documents/Proyectos/SimplePomo/__main__.py' terminal=false"

# Simple Apps
echo "---"
echo "📊 Matlab | bash=matlab terminal=true"
echo "📝 Gedit | bash=gedit terminal=false"
echo "📂 Nautilus | bash=nautilus terminal=false"
echo "---"

