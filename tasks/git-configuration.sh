#!/bin/bash
# --------------------------------------
# Git configuration
# --------------------------------------
USER_NAME=openvscode-server
echo "🚀 Initializing the environment..."
# $HOME == /home/workspace
echo

echo "🤗 Configuring Git $USER_NAME on $HOME"
if [ -f "/home/$USER_NAME/.ssh/config" ]; then
    echo "🙂 Git configuration already exists"
else
    echo "📦 Configuring git user"

    chmod 644 $HOME/.gitconfig
    chmod 600 /home/$USER_NAME/.ssh/config

    find /home/$USER_NAME/.ssh -type f ! -name "*.pub" -exec chmod 600 {} \;
    chmod 644 /home/$USER_NAME/.ssh/*.pub

fi
