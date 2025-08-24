#!/usr/bin/env bash

OBSI_PATH="/home/diego/Documents/Github/Personal/ObsidianNotes"
DOTF_PATH="/home/diego/.dotfiles/"

dunstify "Auto Suspend Script" "Script started. Syncing and locking screen..."

# Commands to run IN ORDER
COMMANDS_TO_RUN=(
    "/home/diego/.config/argos/scripts/gitsync-script.sh $OBSI_PATH auto"
    "/home/diego/.config/argos/scripts/gitsync-script.sh $DOTF_PATH auto"
    # "rsync -av /home/diego/critical_folder /media/backup_drive/"
    # "/home/diego/.config/argos/scripts/another-sync.sh arg1 arg2"
)

xdg-screensaver lock

dunstify "Auto Suspend Script" "Screen Locked."

for cmd in "${COMMANDS_TO_RUN[@]}"; do
    dunstify "Auto Suspend Script" "Running command: $cmd"
    echo "Running command: $cmd" >> "$LOG_FILE"
    bash -c "$cmd"
done

dunstify "Auto Suspend Script" "Finished. Suspending..."

systemctl suspend
