#!/bin/bash

BASE_DIR="/home/diego/Documents/[10] Google Drive Sync"

# Local path (Ubuntu) → Remote path (Google Drive)
declare -A FOLDERS=(
    #["$BASE_DIR/Bandeja de entrada - Sync"]="gdrive:Inbox"
    #["$BASE_DIR/Curso3 - Sync"]="gdrive:Curso3"
    #["$BASE_DIR/Documentos Personales - Sync"]="gdrive:DocumentosPersonales"
    ["$BASE_DIR/Grabaciones - Sync"]="gdrive:Móvil/Grabaciones"
)


# Get optional arguments (--dry-run, --resync, etc.)
SYNC_OPTIONS=""
if [[ "$@" =~ "--dry-run" ]]; then
    SYNC_OPTIONS="--dry-run"
fi
if [[ "$@" =~ "--resync" ]]; then
    SYNC_OPTIONS="$SYNC_OPTIONS --resync"
fi


for local_path in "${!FOLDERS[@]}"; do
    remote_path="${FOLDERS[$local_path]}"

    # Ensure local folder exists
    if [ ! -d "$local_path" ]; then
        echo "📁 Creating missing folder: $local_path"
        mkdir -p "$local_path"
    fi

    echo "🔄 Syncing:"
    echo "   📂 Local:  $local_path"
    echo "   ☁️ Remote: $remote_path"
    echo "--------------------------------------"
    
    rclone bisync "$local_path" "$remote_path" --verbose $SYNC_OPTIONS
done

