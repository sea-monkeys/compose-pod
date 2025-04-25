#!/bin/bash
# --------------------------------------
# Git configuration
# --------------------------------------
USER_NAME=openvscode-server
echo "🚀 Initializing the environment..."

echo "🤗 Configuring Git $USER_NAME"
if [ -f "/home/$USER_NAME/.ssh/config" ]; then
    echo "🙂 Git configuration already exists"
else
    
    echo "📦 Configuring git user"

    echo "[user]" > $HOME/.gitconfig
    echo "    email = ${GIT_USER_EMAIL}" >> $HOME/.gitconfig
    echo "    name = ${GIT_USER_NAME}" >> $HOME/.gitconfig
    echo "[safe]" >> $HOME/.gitconfig
    echo "    directory = ${HOME}/${PROJECT_NAME}" >> $HOME/.gitconfig

    chmod 644 $HOME/.gitconfig
    
    echo "🤗 Configuring Git"

    echo "Host $GIT_HOST" > /home/$USER_NAME/.ssh/config
    echo "    HostName $GIT_HOST" >> /home/$USER_NAME/.ssh/config
    echo "    User git" >> /home/$USER_NAME/.ssh/config
    echo "    IdentityFile ~/.ssh/$PRIVATE_KEY_NAME" >> /home/$USER_NAME/.ssh/config
    echo "    StrictHostKeyChecking no" >> /home/$USER_NAME/.ssh/config

    chmod 600 /home/$USER_NAME/.ssh/config

    mkdir -p ~/.ssh &&
    [[ ! -z $SSH_PUBLIC_KEY  ]] &&
    echo $SSH_PUBLIC_KEY > /home/$USER_NAME/.ssh/$PUBLIC_KEY_NAME &&
    chmod 644 /home/$USER_NAME/.ssh/$PUBLIC_KEY_NAME &&
    [[ ! -z $SSH_PRIVATE_KEY  ]] &&
    echo $SSH_PRIVATE_KEY | base64 -d > /home/$USER_NAME/.ssh/$PRIVATE_KEY_NAME &&
    chmod 600 /home/$USER_NAME/.ssh/$PRIVATE_KEY_NAME

fi

# --------------------------------------
# Clone the project repository
# --------------------------------------
if [ -d "$HOME/$PROJECT_NAME" ]; then
    echo "🙂 Project $PROJECT_NAME already exists"
else
    echo "🤗 Cloning project $PROJECT_NAME"
    git clone $GIT_REPOSITORY $HOME/$PROJECT_NAME
fi

