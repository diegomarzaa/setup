#!/usr/bin/env bash

# Paths
REPO_PATH_OBSIDIAN="/home/diego/Documents/Github/Personal/ObsidianNotes"
DOTF_PATH="/home/diego/.dotfiles/"


# Mostrar botón
echo "💻"
echo "---"

# Sync options
echo "🔄 Obsidian Notes Sync | bash='bash -c \"cd $REPO_PATH_OBSIDIAN && /home/diego/.config/argos/scripts/gitsync-script.sh $REPO_PATH_OBSIDIAN auto\"' terminal=false"

echo "🔄 .dotfiles Sync | bash='bash -c \"cd $DOTF_PATH && /home/diego/.config/argos/scripts/gitsync-script.sh $DOTF_PATH ask\"' terminal=false"

echo "---"


# Sync Drive

SYNC_SCRIPT="/home/diego/.config/argos/scripts/drivesync-script.sh"  # Path to sync script
echo "📂 Drive Sync"
echo "--🔄 Dry-run Resync | bash='bash -c \"$SYNC_SCRIPT --dry-run --resync\"' terminal=true"
echo "--⚠️ Full Resync | bash='bash -c \"$SYNC_SCRIPT --resync\"' terminal=true"
echo "--✅ Normal Sync | bash='bash -c \"$SYNC_SCRIPT\"' terminal=true"


# Mount Drive

MOUNT_PATH="/home/diego/gdrive"  # Set mount path

if mount | grep -q "$MOUNT_PATH"; then
    echo "--🛑 Unmount GDrive | bash='fusermount -u $MOUNT_PATH' refresh=true terminal=false"
else
    RCLONE_CMD="rclone mount gdrive: $MOUNT_PATH --vfs-cache-mode full --dir-cache-time 24h --poll-interval 15s --tpslimit 10 --daemon"
    echo "--🗂️ Mount GDrive | bash='$RCLONE_CMD' refresh=true terminal=false"
fi


echo "---"



# Tools
echo "✏️ Abrir Excalidraw | bash='bash -c \"xdg-open obsidian://adv-uri?vault=ObsidianNotes\\&commandid=obsidian-excalidraw-plugin%3Aexcalidraw-autocreate-popout\"' terminal=false"
echo "🍅 Simple Pomo | bash='/home/diego/miniforge3/bin/python3 /home/diego/Documents/Proyectos/SimplePomo/__main__.py' terminal=false"
echo "🔀 PDF to Obsidian (OCR) | bash='code ~/Documents/Github/Professional/pdf-ocr-obsidian ~/Documents/Github/Professional/pdf-ocr-obsidian/pdf-markdown-ocr.ipynb' terminal=false"
echo "🔀 Obsidian to LaTeX | bash='/home/diego/miniforge3/bin/python3 /home/diego/Downloads/latex-tests/script-python2.py' terminal=true"

DIVIDE_TRANSCRIBE_SCRIPT="/home/diego/.config/argos/scripts/split_transcribe.py"
echo "🎵 Transcribir Audios | bash='/home/diego/miniforge3/bin/python3 \"$DIVIDE_TRANSCRIBE_SCRIPT\"' terminal=true"



# Simple Apps
echo "---"
echo "📊 Matlab | bash='/home/diego/Documents/Matlab/bin/matlab -desktop &' terminal=false"
echo "🔗 MATLAB Connector | bash='bash -c \"~/bin/MATLABConnector toggle\"' terminal=false"
echo "📝 Gedit | bash=gedit terminal=false"
echo "📂 Nautilus | bash=nautilus terminal=false"
echo " Terminal Explorer | bash='spf' terminal=true"
echo "---"

