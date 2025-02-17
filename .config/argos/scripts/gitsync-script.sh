#!/usr/bin/env bash

# Validate arguments
if [ -z "$1" ]; then
    zenity --error --text="❌ ERROR: No repository path provided!"
    exit 1
fi

REPO_PATH="$1"
COMMIT_MODE="$2" # "auto" (automatic) or "ask" (ask for commit message)

# Check if directory exists
if [ ! -d "$REPO_PATH" ]; then
    zenity --error --text="❌ ERROR: Repository path not found: $REPO_PATH"
    exit 1
fi

# Handle commit message
if [ "$COMMIT_MODE" == "ask" ]; then
COMMIT_MSG=$(zenity --entry --title="Commit Message" --text="Enter a commit message:" --width=400)
if [ -z "$COMMIT_MSG" ]; then
    zenity --error --text="❌ Commit cancelled!"
    exit 1
fi
else
COMMIT_MSG="Automatic backup - $(date)"
fi


(
    echo "0";
    echo "# 📡 Connecting to GitHub..."
    cd "$REPO_PATH" || { echo "1"; echo "# ❌ ERROR: Repository not found"; exit 1; }

    echo "10"; 
    echo "# 🔄 Running 'git pull'..."
    git pull origin main &> /tmp/git_output || { echo "15"; echo "# ❌ ERROR in git pull"; exit 1; }

    echo "25";
    echo "# 📂 Adding changes with 'git add .'";
    git add . &> /tmp/git_output || { echo "35"; echo "# ❌ ERROR in git add"; exit 1; }

    echo "45";

    echo "# 📝 Committing changes..."
    git commit -m "$COMMIT_MSG" &> /tmp/git_output || { echo "55"; echo "# ❌ ERROR in git commit"; exit 1; }

    echo "65";
    echo "# 🚀 Pushing changes..."
    git push origin main &> /tmp/git_output || { echo "75"; echo "# ❌ ERROR in git push"; exit 1; }

    echo "85";
    echo "# ✅ Sync complete!";
    echo "100";

) | zenity --progress --title="📡 Syncing to GitHub..." \
    --width=450 --auto-close --percentage=0 --text="Connecting to the future..." \
    --ok-label="😎 Let's keep procrastinating"

