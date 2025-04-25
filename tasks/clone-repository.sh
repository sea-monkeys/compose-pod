#!/bin/bash
# --------------------------------------
# Clone the project repository
# --------------------------------------
if [ -d "$HOME/$PROJECT_NAME" ]; then
    echo "🙂 Project $PROJECT_NAME already exists"
else
    echo "🤗 Cloning project $PROJECT_NAME"
    git clone $GIT_REPOSITORY $HOME/$PROJECT_NAME
fi

